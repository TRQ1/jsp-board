<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 9. 20.
  Time: AM 11:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<script language = "javascript">  // 자바 스크립트 시작
function modifyCheck()
{
    var form = document.modifyform;

    if( !form.password.value )
    {
        alert( "비밀번호를 적어주세요" );
        form.password.focus();
        return;
    }
    form.submit();
}
</script>
<%
    int idx = Integer.parseInt(request.getParameter("id"));
    int pg = Integer.parseInt(request.getParameter("pg"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>수정 확인</title>
</head>
<body>
<table>
    <form name=modifyform method=post action="modify_check_do.jsp?id=<%=idx%>&pg=<%=pg%>">
        <tr>
            <td>
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr style="text-align:center;">
                        <td width="5"></td>
                        <td>수정</td>
                        <td width="5"></td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td>&nbsp;</td>
                        <td align="center">비밀번호</td>
                        <td><input name="password" type="password" size="50" maxlength="100"></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
                    <tr height="1" bgcolor="#82B5DF"><td colspan="4"></td></tr>
                    <tr align="center">
                        <td>&nbsp;</td>
                        <td colspan="2">
                            <input type=button value="취소" OnClick="javascript:history.back(-1)">
                            <input type=button value="확인" OnClick="javascript:modifyCheck();">
                            <input type=button value="목록" OnClick="window.location='lists.jsp?id=<%=idx%>&pg=<%=pg%>'">
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
</table>
</body>
</html>
