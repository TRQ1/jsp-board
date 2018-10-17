<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 10. 16.
  Time: AM 9:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="database_process.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");

    int idx = Integer.parseInt(request.getParameter("id"));
    int pg = Integer.parseInt(request.getParameter("pg"));
    String userId = request.getParameter("userId");
    String content = request.getParameter("content");

    int id = sqlSelectCommentId(content, idx);
    System.out.println(id);

    sqlCommentDelete(id);
%>
<script language=javascript>
    self.window.alert("해당 글을 삭제하였습니다.");
    location.href = "lists.jsp?id=<%=idx%>&pg=<%=pg%>&userId=<%=userId%>";
</script>

