<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 9. 20.
  Time: PM 12:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@include file="database_process.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");

    Connection conn = connDb(); // DB connection 메소드 호출

    int idx = Integer.parseInt(request.getParameter("id"));
    int pg = Integer.parseInt(request.getParameter("pg"));


    String title = request.getParameter("title");
    String content = request.getParameter("content");

    sqlUpdate(title, content, idx);
%>
<script language=javascript>
    self.window.alert("글이 수정되었습니다.");
    location.href = "lists.jsp?pg=<%=pg%>";
</script>
