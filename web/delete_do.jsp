<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 9. 20.
  Time: AM 9:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    Class.forName("org.mariadb.jdbc.Driver");
    String url = "jdbc:mariadb://localhost:3306/boards";
    String userid = "root";
    String passwd = "qwer0987";

    String password = "";


    int idx = Integer.parseInt(request.getParameter("id"));
    String pass = request.getParameter("password");

    try {
        Connection conn = DriverManager.getConnection(url, userid, passwd); //DB 연결
        Statement stmt = conn.createStatement();

        String sql = "SELECT passwd FROM board WHERE id=" + idx;
        System.out.println(sql);
        ResultSet rs = stmt.executeQuery(sql);

        if(rs.next()) {
            password = rs.getString(1);
        }

        //password값이랑 파라메터로 받아온 pass값이 같을 경우 글 삭제
        if(password.equals(pass)){
            sql = "DELETE FROM board WHERE id=" + idx;
            stmt.executeUpdate(sql);
%>
<script language=javascript>
    self.window.alert("해당 글을 삭제하였습니다.");
    location.href="lists.jsp";
</script>
<%
            rs.close();
            stmt.close();
            conn.close();
        } else {        // 그게 아닐경우 알람창 발생
%>
<script language=javascript>
    self.window.alert("비밀번호를 틀렸습니다.");
    location.href="javascript:history.back()";
</script>
<%
        }
    } catch(SQLException e) {
        System.out.println(e.toString());
    }
%>

