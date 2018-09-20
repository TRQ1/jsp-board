<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 9. 20.
  Time: AM 11:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    Class.forName("org.mariadb.jdbc.Driver");
    String url = "jdbc:mariadb://localhost:3306/boards";
    String userid = "root";
    String passwd = "qwer0987";

    String password = "";
    int idx = Integer.parseInt(request.getParameter("id"));
    int pg = Integer.parseInt(request.getParameter("pg"));
    String pass = request.getParameter("password");

    try {
        Connection conn = DriverManager.getConnection(url, userid, passwd); //DB 연결
        Statement stmt = conn.createStatement();

        System.out.println("password :" + pass);

        String sql = "SELECT passwd FROM board WHERE id=" + idx;
        System.out.println("sql passwd : " + sql);
        ResultSet rs = stmt.executeQuery(sql);

        if(rs.next()) {
            password = rs.getString(1);
            System.out.println(password);
        }

        //password값이랑 파라메터로 받아온 pass값이 같을 경우 modify로 포워딩
        if(password.equals(pass)){
            RequestDispatcher dispatcher = request.getRequestDispatcher("modify.jsp"); // getRequestDisparcher로 modify.jsp 호출
            request.setAttribute("request","requestValue"); //setAttribute로 기존 정보를 보내준다.
            dispatcher.forward(request, response); //forwarding

        } else {        // 그게 아닐경우 알람창 발생
%>
<script language=javascript>
    self.window.alert("비밀번호를 틀렸습니다.");
    location.href="javascript:history.back()";
</script>
<%
        }
    } catch(SQLException e) {
        System.out.println(e.toString());
    }
%>
