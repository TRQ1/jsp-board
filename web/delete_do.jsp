<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 9. 20.
  Time: AM 9:51
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

    String password = "";

    int idx = Integer.parseInt(request.getParameter("id"));
    String pass = request.getParameter("password");

    password = sqlPasswd(idx); //메소드 호출하여 password 확인

    //password값이랑 파라메터로 받아온 pass값이 같을 경우 글 삭제
    if (password.equals(pass)) {
        sqlPostDelete(idx);
%>
<script language=javascript>
    self.window.alert("해당 글을 삭제하였습니다.");
    location.href="lists.jsp";
</script>
<%
        } else {        // 그게 아닐경우 알람창 발생
%>
<script language=javascript>
    self.window.alert("비밀번호를 틀렸습니다.");
    location.href="javascript:history.back()";
</script>
<%
        }
%>

