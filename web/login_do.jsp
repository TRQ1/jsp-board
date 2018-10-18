<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 10. 4.
  Time: AM 9:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="database_process.jsp" %>
<%@include file="cookie_process.jsp" %>
<%@include file="checkLogin.jsp" %>
<%
    String userName = request.getParameter("userId");
    String userPasswd = request.getParameter("userPasswd");

    int useridx = 0;

    Connection conn = connDb(); // DB connection 메소드 호출
    PreparedStatement pstm = null;
    ResultSet rs = null;
    String userGetName = null;
    String userGetPass = null;
    String noAccountUser = null;

    try {
        String sqlAccount = "SELECT id, userid, userpasswd FROM account";
        pstm = conn.prepareStatement(sqlAccount);
        rs = pstm.executeQuery(sqlAccount);

        if (rs.next()) {
            int getId = rs.getInt(1);
            userGetName = rs.getString(2);
            userGetPass = rs.getString(3);

            if (userName == userGetName) {
                useridx = getId;
                System.out.println("useridx : " + useridx);
            }
        }

    } catch (SQLException e) {
        System.out.println(e);
    } finally {
        close(pstm, conn);
        resultClose(rs);
    }

    String userGId = userGetName;
    String userGPass = userGetPass;
    if (userName.equals(userGId) && userPasswd.equals(userGPass)) {
        String randomPassword = generateRandomString(10);
        createCookie(response, "loginId", userName);
        response.sendRedirect("lists.jsp");
    }
%>

