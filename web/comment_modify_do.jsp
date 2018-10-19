<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 10. 16.
  Time: PM 5:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="database_process.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");

    int idx = Integer.parseInt(request.getParameter("id"));
    int pg = Integer.parseInt(request.getParameter("pg"));
    int cid = Integer.parseInt(request.getParameter("cid"));
    String content = request.getParameter("contentComment");

    sqlCommentUpdate(content, cid);
%>
<script language=javascript>
    self.window.alert("댓글이 수정되었습니다.");
    location.href = "detail.jsp?id=<%=idx%>&pg=<%=pg%>";
</script>
