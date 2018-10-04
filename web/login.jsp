<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 10. 3.
  Time: PM 3:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="database_process.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script language="javascript">
    function checkLogin() {
        var form = document.loginform;

        if (!form.userId.value) {
            alert("비밀번호를 적어주세요");
            form.userId.focus();
            return;
        }

        var form = document.loginform;

        if (!form.userPasswd.value) {
            alert("비밀번호를 적어주세요");
            form.userPasswd.focus();
            return;
        }
        form.submit();
    }
</script>
<html>
<head>
    <title>로그인</title>
    <H1>로그인 페이지</H1>
</head>
<body>
<form name=loginform method=post action="login_do.jsp">
    사용자:<br/><input type="text" name="userId"/><br/>
    패스워드:<br/><input type="password" name="userPasswd"/><br/>
    <input type="submit" value="Login" OnClick="javascript:checkLogin();"/>
</form>
</body>
</html>
