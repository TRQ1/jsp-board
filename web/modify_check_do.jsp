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
<%@include file="database_process.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");

    Class.forName("org.mariadb.jdbc.Driver");
    Connection conn = connDb(); // DB connection 메소드 호출

    String password = "";
    int idx = Integer.parseInt(request.getParameter("id"));
    int pg = Integer.parseInt(request.getParameter("pg"));
    String userId = request.getParameter("userId");
    String pass = request.getParameter("password");

    password = sqlPasswd(idx); //메소드 호출하여 password 확인
    if (password.equals(pass)) {
        RequestDispatcher dispatcher = request.getRequestDispatcher("modify.jsp"); // getRequestDisparcher로 modify.jsp 호출
        dispatcher.forward(request, response); //forwarding 하여 기존 정보를 보낸다.
    } else {        // 그게 아닐경우 알람창 발생
%>
<script language=javascript>
    self.window.alert("비밀번호를 틀렸습니다.");
    location.href="javascript:history.back()";
</script>
<%
    }
%>
