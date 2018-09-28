<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 9. 20.
  Time: PM 12:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    Class.forName("org.mariadb.jdbc.Driver");
    String url = "jdbc:mariadb://localhost:3306/boards";
    String userid = "root";
    String passwd = "qwer0987";


    int idx = Integer.parseInt(request.getParameter("id"));
    int pg = Integer.parseInt(request.getParameter("pg"));

    try {
        Connection conn = DriverManager.getConnection(url, userid, passwd); //DB 연결
        Statement stmt = conn.createStatement();

        String title = request.getParameter("title");
        String content = request.getParameter("content");

        String sql = "UPDATE board SET title='" + title + "' ,content='" + content + "' WHERE id=" + idx;
        System.out.println(sql);
        stmt.executeUpdate(sql);
%>
<script language=javascript>
    self.window.alert("글이 수정되었습니다.");
    location.href="lists.jsp?pg=<%=pg%>";
</script>
<%
        stmt.close();
        conn.close();
%>
<%
    } catch(SQLException e) {
        System.out.println( e.toString() );
    }

%>
