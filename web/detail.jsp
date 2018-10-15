<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 9. 19.
  Time: PM 5:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@include file="database_process.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
    Connection conn = connDb(); // DB connection 메소드 호출
    PreparedStatement pstm = null;
    ResultSet rs = null;

    int idx = Integer.parseInt(request.getParameter("id")); // lists.jsp에서 get 메소드로 전달된 id 값
    int pg = Integer.parseInt(request.getParameter("pg"));
    String userId = request.getParameter("userId");
    String author = null;
    String title = null;
    String content = null;

    try {
        String sqlSelect = "SELECT author, title, content, todate FROM board WHERE id=" + idx;
        pstm = conn.prepareStatement(sqlSelect);
        rs = pstm.executeQuery(sqlSelect);

        // 해당 id 값에 대한 정보
        if (rs.next()) {
            author = rs.getString(1);
            title = rs.getString(2);
            content = rs.getString(3);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>글 상세</title>
</head>
<body>
<table>
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr style="text-align:center;">
                    <td width="5"></td>
                    <td>글 상세</td>
                    <td width="5"></td>
                </tr>
            </table>
            <table width="413">
                <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
                <tr>
                    <td width="0">&nbsp;</td>
                    <td align="center" width="76">글쓴이</td>
                    <td width="319"><%=author%></td>
                    <td width="0">&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
                <tr>
                    <td width="0">&nbsp;</td>
                    <td align="center" width="76">제목</td>
                    <td width="319"><%=title%><</td>
                    <td width="0">&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
                <tr>
                    <td width="0">&nbsp;</td>
                    <td align="center" width="76">내용</td>
                    <td width="319"><%=content %></td>
                    <td width="0">&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
                <tr>
                    <td width="0">&nbsp;</td>
                    <td width="399" colspan="2" height="200">
                </tr>
            <%
                }
                } catch(SQLException e) {
                    System.out.println( e.toString() );
                } finally {
                    close(pstm, conn);
                    resultClose(rs);
                }

            %>
                <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
                <tr height="1" bgcolor="#82B5DF"><td colspan="4" width="407"></td></tr>
                <tr align="right">
                    <td width="0">&nbsp;</td>
                    <td colspan="2" width="399">
                            <%
                        System.out.println("userId : " + userId);
                        System.out.println("author : " + author);
                           if(userId.equals(author)) {
                        %>
                        <input type=button value="수정" name=id
                               OnClick="window.location='modify.jsp?id=<%=idx%>&pg=<%=pg%>&userId=<%=userId%>'">
                        <input type=button value="삭제" name=id OnClick="window.location='delete.jsp?id=<%=idx%>&pg=<%=pg%>'">
                        <input type=button value="목록"
                               OnClick="window.location='lists.jsp?pg=<%=pg%>&userId=<%=userId%>'">
                            <%
                         } else {
                        %>
                        <input type=button value="수정" name=id
                               OnClick="window.location='modify_check.jsp?id=<%=idx%>&pg=<%=pg%>&userId=<%=userId%>'">
                        <input type=button value="답글" name=id
                               OnClick="window.location='reply.jsp?id=<%=idx%>&pg=<%=pg%>'">
                        <input type=button value="삭제" name=id
                               OnClick="window.location='delete.jsp?id=<%=idx%>&pg=<%=pg%>'">
                        <input type=button value="목록" OnClick="window.location='lists.jsp?pg=<%=pg%>'">
                            <%
                                }
                        %>
                    <td width="0">&nbsp;</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>
