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
<%
    String userName = request.getParameter("userId");
    String userPasswd = request.getParameter("userPasswd");

    int useridx = 0;

    Connection conn = connDb(); // DB connection 메소드 호출
    PreparedStatement pstm = null;
    ResultSet rs = null;
    String userId = request.getParameter("userId");
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
    if (userName == null && userPasswd == null) {
        RequestDispatcher dispatcher = request.getRequestDispatcher("lists.jsp"); // getRequestDisparcher로 list.jsp 호출
        dispatcher.forward(request, response); //forwarding 하여 기존 정보를 보낸다.
    } else if (userName.equals(userGId) && userPasswd.equals(userGPass)) {
        createCookie(response, userName);
        obtainCookie(request, userName);

        RequestDispatcher dispatcher = request.getRequestDispatcher("lists.jsp"); // getRequestDisparcher로 list.jsp 호출
        dispatcher.forward(request, response); //forwarding 하여 기존 정보를 보낸다.
    } else if (userName == userGId && userPasswd != userGPass) {
        out.println("<br>");
        out.println("<font color='red' size='5'>패스워드가 틀렸습니다. 확인해 주세요.</font>");
    } else if (userName != userGId) {
        out.println("<br>");
        out.println("<font color='red' size='5'>계정이 없습니다. 아이디를 확인해 주세요.</font>");
    }
%>

