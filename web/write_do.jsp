<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 9. 19.
  Time: PM 3:38
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

    String author = request.getParameter("author"); //write.jsp에서 author에 입력한 데이터값
    String password = request.getParameter("password"); //write.jsp에서 password에 입력한 데이터값
    String title = request.getParameter("title"); //write.jsp에서 title에 입력한 데이터값
    String content = request.getParameter("content"); //write.jsp에서 content에 입력한 데이터값

    try {
        Connection conn = DriverManager.getConnection(url, userid, passwd); //DB 연결

        String sql = "INSERT INTO board(author,passwd,title,content,todate) VALUES(?,?,?,?,NOW())";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, author);
        pstmt.setString(2, password);
        pstmt.setString(3, title);
        pstmt.setString(4, content);

        pstmt.execute();
        pstmt.close();
        conn.close();
    }
    catch(SQLException e) {
        out.println( e.toString() );
    }
%>
<script language=javascript>
    self.window.alert("입력한 글을 저장하였습니다.");
    location.href="lists.jsp";
</script>
