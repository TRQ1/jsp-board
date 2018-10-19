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
    PreparedStatement pstm = null;
    ResultSet rs = null;

    int count = 0;
    int countAfter = 0;
    int max = 0;

    int id = Integer.parseInt(request.getParameter("id"));
    int pg = Integer.parseInt(request.getParameter("pg"));
    String author = null;
    String password = null;
    String title = null;
    String content = null;

    author = request.getParameter("author"); //write.jsp에서 author에 입력한 데이터값
    password = request.getParameter("password"); //write.jsp에서 password에 입력한 데이터값
    title = request.getParameter("title"); //write.jsp에서 title에 입력한 데이터값
    content = request.getParameter("content"); //write.jsp에서 content에 입력한 데이터   값

    /**
     * 회원 로그인시 작성자와 패스워드를 안받기때문에 처리 해주는 로직
     */
    if (author == null && password == null) {
        author = userId;
        password = "null";
    }

    String sqlMax = "SELECT MAX(id) FROM board";
    pstm = conn.prepareStatement(sqlMax);
    rs = pstm.executeQuery(sqlMax);

    if (rs.next()) {
        max = rs.getInt(1);
    }

    count = sqlCount();
    sqlInsert(author, password, title, content, "post", max);
    countAfter = sqlCount();

    System.out.println("count1 : " + count);
    System.out.println("countAfter1 : " + countAfter);

    if (count + 1 == countAfter) {
%>
<script language=javascript>
    self.window.alert("입력한 글을 저장하였습니다.");
    location.href = "lists.jsp?id=<%=id%>&pg=<%=pg%>";
</script>
<%
        System.out.println("done");
    }
%>