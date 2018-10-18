<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%

    String loginId = checkLogin(request, "loginId");

    if (loginId == null || "".equals(loginId)) {
        loginId = "방문자";
    }

%>