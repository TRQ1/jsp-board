<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 9. 19.
  Time: PM 5:30
  To change this template use File | Settings | File Templates.
--%>
<<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
    request.setCharacterEncoding("UTF-8");

    Class.forName("org.mariadb.jdbc.Driver");
    String url = "jdbc:mariadb://localhost:3306/boards";
    String userid = "root";
    String passwd = "qwer0987";

    int idx = Integer.parseInt(request.getParameter("id")); // lists.jsp에서 get 메소드로 전달된 id 값
    System.out.println(idx);

    try {
        Connection conn = DriverManager.getConnection(url, userid, passwd); //DB 연결
        Statement stmt = conn.createStatement();

        String sql = "SELECT author, title, content FROM board WHERE id=" + idx;
        System.out.println(sql);
        ResultSet rs = stmt.executeQuery(sql);

        // 해당 id 값에 대한 정보
        if (rs.next()) {
            String author = rs.getString(1);
            String title = rs.getString(2);
            String content = rs.getString(3);
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
                stmt.executeUpdate(sql);
                rs.close();
                stmt.close();
                conn.close();
                }
            } catch(SQLException e) {
                System.out.println( e.toString() );
                }
            %>
                <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
                <tr height="1" bgcolor="#82B5DF"><td colspan="4" width="407"></td></tr>
                <tr align="right">
                    <td width="0">&nbsp;</td>
                    <td colspan="2" width="399">
                        <input type=button value="수정">
                        <input type=button value="삭제" name=id OnClick="window.location='delete.jsp?id=<%=idx%>'">
                        <input type=button value="목록" OnClick="window.location='lists.jsp'">
                    <td width="0">&nbsp;</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>
