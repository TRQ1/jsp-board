<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 10. 8.
  Time: AM 10:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="database_process.jsp" %>
<%@include file="checkLogin.jsp" %>
<%
    int idx = Integer.parseInt(request.getParameter("id"));
    int pg = Integer.parseInt(request.getParameter("pg"));
    String userId = loginId;

    request.setCharacterEncoding("UTF-8");
    Connection conn = connDb(); // DB connection 메소드 호출
    PreparedStatement pstm = null;
    ResultSet rs = null;
    String title = null;

    try {
        String sqlTitle = "SELECT title FROM board WHERE id=" + idx;
        pstm = conn.prepareStatement(sqlTitle);
        rs = pstm.executeQuery(sqlTitle);


        if (rs.next()) {
            title = rs.getString(1);
        }
    } catch (SQLException e) {
        System.out.println(e);
    } finally {
        close(pstm, conn);
        resultClose(rs);
    }

%>
<html>
<head>
    <title>답글</title>
</head>
<body>
<table>
    <form name=replyform method=post action="reply_do.jsp?id=<%=idx%>">
        <tr>
            <td>
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr style="text-align:center;">
                        <td width="5"></td>
                        <td>답글</td>
                        <td width="5"></td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td>&nbsp;</td>
                        <td align="center">제목</td>
                        <td><input name="title" size="50" maxlength="100" value="Re: <%=title%>"></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr height="1" bgcolor="#dddddd">
                        <td colspan="4"></td>
                    </tr>
                    <%
                        if (userId == null || userId.equals("null")) {
                    %>
                    <tr>
                        <td>&nbsp;</td>
                        <td align="center">이름</td>
                        <td><input name="author" size="50" maxlength="50"></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr height="1" bgcolor="#dddddd">
                        <td colspan="4"></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td align="center">비밀번호</td>
                        <td><input name="password" type="password" size="50" maxlength="50"></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr height="1" bgcolor="#dddddd">
                        <td colspan="4"></td>
                    </tr>
                    <%
                    } else {
                    %>
                    <tr>
                        <td>&nbsp;</td>
                        <td align="center">이름</td>
                        <td><%=userId%>
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr height="1" bgcolor="#dddddd">
                        <td colspan="4"></td>
                    </tr>
                    <%
                        }
                    %>
                    <tr>
                        <td>&nbsp;</td>
                        <td align="center">내용</td>
                        <td><textarea name="content" cols="50" rows="13"></textarea></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr height="1" bgcolor="#dddddd">
                        <td colspan="4"></td>
                    </tr>
                    <tr height="1" bgcolor="#82B5DF">
                        <td colspan="4"></td>
                    </tr>
                    <tr align="right">
                        <td>&nbsp;</td>
                        <td colspan="2">
                            <input type=submit value="등록">
                            <input type=button value="취소" OnClick="javascript:history.back(-1)">
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
    </form>
</table>
</body>
</html>
