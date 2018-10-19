<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 10. 16.
  Time: AM 9:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="database_process.jsp" %>
<%@include file="checkLogin.jsp" %>
<%
    int id = Integer.parseInt(request.getParameter("id")); // 원래 글의 parent
    int pg = Integer.parseInt(request.getParameter("pg"));
    String userId = loginId;
    String content = request.getParameter("content");

    int caId = sqlSelectCommentId(content, id);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>삭제</title>
</head>
<body>
<table>
    <form name=deleteform method=post
          action="comment_delete_do.jsp?id=<%=id%>&pg=<%=pg%>&cid=<%=caId%>">
        <tr>
            <td>
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr style="text-align:center;">
                        <td width="5"></td>
                        <td>삭제</td>
                        <td width="5"></td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td>&nbsp;</td>
                        <td align="center">비밀번호</td>
                        <td><input name="password" type="password" size="50" maxlength="100"></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr height="1" bgcolor="#dddddd">
                        <td colspan="4"></td>
                    </tr>
                    <tr height="1" bgcolor="#82B5DF">
                        <td colspan="4"></td>
                    </tr>
                    <tr align="center">
                        <td>&nbsp;</td>
                        <td colspan="2">
                            <input type=button value="삭제" OnClick="javascript:deleteCheck();">
                            <input type=button value="취소" OnClick="javascript:history.back(-1)">
                            <input type=button value="목록" OnClick="window.location='lists.jsp?id=<%=id%>&pg=<%=pg%>'">
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
</table>
</form>
</body>
</html>
