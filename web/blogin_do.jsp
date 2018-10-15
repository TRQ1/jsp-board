<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 10. 15.
  Time: AM 10:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="cookie_process.jsp" %>
<%
    RequestDispatcher dispatcher = request.getRequestDispatcher("lists.jsp"); // getRequestDisparcher로 list.jsp 호출
    dispatcher.forward(request, response); //forwarding 하여 기존 정보를 보낸다.
%>
