<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 10. 16.
  Time: AM 11:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="database_process.jsp" %>
<%@include file="checkLogin.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
    Connection conn = connDb(); // DB connection 메소드 호출
    PreparedStatement pstm = null;
    ResultSet rs = null;

    int count = 0;
    int countAfter = 0;

    int idx = Integer.parseInt(request.getParameter("id"));
    int pg = Integer.parseInt(request.getParameter("pg"));
    String author = loginId;
    String content = request.getParameter("contentComment");


    count = sqlCountComment(idx);
    sqlInsertAcoountCommnet(author, content, idx);
    countAfter = sqlCountComment(idx);

    System.out.println("count1 : " + count);
    System.out.println("countAfter1 : " + countAfter);

    if (count + 1 == countAfter) {
%>
<script language=javascript>
    self.window.alert("입력한 글을 저장하였습니다.");
    location.href = "lists.jsp?id=<%=idx%>&pg=<%=pg%>";
</script>
<%
        System.out.println("done");
    }
%>
