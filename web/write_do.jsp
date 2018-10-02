<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 9. 19.
  Time: PM 3:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@include file="database_process.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
    Connection conn = connDb(); // DB connection 메소드 호출

    int count = 0;
    int countAfter = 0;

    String author = request.getParameter("author"); //write.jsp에서 author에 입력한 데이터값
    String password = request.getParameter("password"); //write.jsp에서 password에 입력한 데이터값
    String title = request.getParameter("title"); //write.jsp에서 title에 입력한 데이터값
    String content = request.getParameter("content"); //write.jsp에서 content에 입력한 데이터값

    count = sqlCount();
    sqlInsert(author, password, title, content);
    countAfter = sqlCount();

    System.out.println("count1 : " + count);
    System.out.println("countAfter1 : " + countAfter);

    if (count + 1 == countAfter) {
%>
<script language=javascript>
    self.window.alert("입력한 글을 저장하였습니다.");
    location.href="lists.jsp";
</script>
<%
        System.out.println("done");
    }
%>