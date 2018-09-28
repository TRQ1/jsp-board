<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 9. 19.
  Time: PM 3:38
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
    int count = 0;
    int countAfter = 0;

    String author = request.getParameter("author"); //write.jsp에서 author에 입력한 데이터값
    String password = request.getParameter("password"); //write.jsp에서 password에 입력한 데이터값
    String title = request.getParameter("title"); //write.jsp에서 title에 입력한 데이터값
    String content = request.getParameter("content"); //write.jsp에서 content에 입력한 데이터값

    try {
        Connection conn = DriverManager.getConnection(url, userid, passwd); //DB 연결
        Statement stmt = conn.createStatement();

        String sqlCount = "SELECT COUNT(*) FROM board";
        System.out.println(sqlCount);
        ResultSet rs = stmt.executeQuery(sqlCount);

        if(rs.next()) {
            count = rs.getInt(1);
        }
        rs.close();

        String sql = "INSERT INTO board(author,passwd,title,content,todate) VALUES(?,?,?,?,NOW())";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        // 받은 파라메터를 각 디비값에 셋팅
        pstmt.setString(1, author);
        pstmt.setString(2, password);
        pstmt.setString(3, title);
        pstmt.setString(4, content);

        pstmt.execute();

        String sqlCountAfter = "SELECT COUNT(*) FROM board";
        System.out.println(sqlCountAfter);
        ResultSet rsca = stmt.executeQuery(sqlCountAfter);

        if(rsca.next()) {
            countAfter = rs.getInt(1);
        }
        rsca.close();

        System.out.println("count1 : "+ count);
        System.out.println("countAfter1 : "+ countAfter);

        if(count++ == countAfter){
%>
<script language=javascript>
    self.window.alert("입력한 글을 저장하였습니다.");
    location.href="lists.jsp";
</script>
<%
        stmt.close();
        pstmt.close();
        conn.close();
        }
}
catch(SQLException e) {
System.out.println( e.toString() );
}
%>