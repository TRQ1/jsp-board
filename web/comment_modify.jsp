<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 10. 16.
  Time: PM 5:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="database_process.jsp" %>
<%

    /**
     * 로그인시 댓글 ID 찾는 로직
     */


    int id = Integer.parseInt(request.getParameter("id")); // 원래 글의 parent
    int cid = Integer.parseInt(request.getParameter("cid"));  // 댓글 ID
    int pg = Integer.parseInt(request.getParameter("pg"));
    String userId = request.getParameter("userId");
    String content = request.getParameter("content");
    String author = request.getParameter("author"); // 댓글 쓴 사람

    System.out.println("userId : " + userId);
    System.out.println("author: " + author);

    int caId = sqlSelectCommentId(content, id);
    System.out.println("caId : " + caId);
%>
<html>
<head>
    <title>댓글 수정</title>
</head>
<body>
<table>
    <%
        if (userId.equals(author)) {
    %>
    <form name=commentModifyform method=post
          action="comment_modify_do.jsp?id=<%=id%>&pg=<%=pg%>&userId=<%=userId%>&author=<%=author%>&cid=<%=caId%>">
        <tr>
            <td align="right" width="76">사용자:</td>
            <td><%=author%>
            </td>
            <td><textarea name="contentComment" cols="40" rows="5"></textarea></td>
            <td align="right">
                <input type=submit value="댓글 수정">
            </td>
        </tr>
            <%
        } else if(userId.equals("null") && author != null){
    %>
        <form name=commentModifyform method=post
              action="comment_modify_do.jsp?id=<%=id%>&pg=<%=pg%>&userId=<%=userId%>&author=<%=author%>&cid=<%=cid%>">
            <tr>
                <td align="right" width="76">사용자:</td>
                <td><%=author%>
                </td>
                <td><textarea name="contentComment" cols="40" rows="5"></textarea></td>
                <td align="right">
                    <input type=submit value="댓글 수정">
                </td>
            </tr>
            <%
                }
            %>
        </form>
</table>
</body>
</html>
