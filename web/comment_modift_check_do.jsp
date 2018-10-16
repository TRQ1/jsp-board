<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 9. 20.
  Time: AM 11:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="database_process.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");

    String password = "";
    int idx = Integer.parseInt(request.getParameter("id"));
    int pg = Integer.parseInt(request.getParameter("pg"));
    String userId = request.getParameter("userId");
    String content = request.getParameter("content");
    String pass = request.getParameter("password");
    String author = request.getParameter("author");

    int id = sqlSelectCommentId(content, idx);
    System.out.println("id : " + id);
    password = sqlCommentPasswd(id);
    System.out.println("pass : " + password);
    if (password.equals(pass)) {
        response.sendRedirect("comment_modify.jsp?id=" + idx + "&pg=" + pg + "&cid=" + id + "&userId=" + userId + "&author=" + author);
    } else {        // 그게 아닐경우 알람창 발생
%>
<script language=javascript>
    self.window.alert("비밀번호를 틀렸습니다.");
    location.href = "javascript:history.back()";
</script>
<%
    }
%>
