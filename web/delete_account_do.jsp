<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 10. 24.
  Time: AM 10:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="database_process.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
    Connection conn = connDb(); // DB connection 메소드 호출
    PreparedStatement pstm = null;
    ResultSet rs = null;

    int idx = Integer.parseInt(request.getParameter("id"));

    sqlPostDelete(idx);
%>
<script language=javascript>
    self.window.alert("해당 글을 삭제하였습니다.");
    location.href = "lists.jsp";
</script>
<%
%>
