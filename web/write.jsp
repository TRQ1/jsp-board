<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 9. 19.
  Time: PM 1:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@include file="database_process.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script language = "javascript"> // 자바 스크립트 시작
function writeCheck()
{
    var form = document.writeform;

    if( !form.author.value )   // form 에 있는 name 값이 없을 때
    {
        alert( "이름을 적어주세요" ); // 경고창 띄움
        form.author.focus();   // form 에 있는 name 위치로 이동
        return;
    }

    if( !form.password.value )
    {
        alert( "비밀번호를 적어주세요" );
        form.password.focus();
        return;
    }

    if( !form.title.value )
    {
        alert( "제목을 적어주세요" );
        form.title.focus();
        return;
    }

    if( !form.content.value )
    {
        alert( "내용을 적어주세요" );
        form.content.focus();
        return;
    }

    form.submit();
}
</script>
<%
    request.setCharacterEncoding("UTF-8");

    Connection conn = connDb(); // DB connection 메소드 호출
    PreparedStatement pstm = null;
    ResultSet rs = null;

    int idx = Integer.parseInt(request.getParameter("id"));
    int pg = Integer.parseInt(request.getParameter("pg"));
    String userId = request.getParameter("userId");

%>
<html>
<head>
    <title>글쓰기</title>
</head>
<body>
<table>
    <form name=writeform method=post action="write_do.jsp?id=<%=idx%>&pg=<%=pg%>&userId=<%=userId%>">
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr style="text-align:center;">
                <td width="5"></td>
                <td>글쓰기</td><td width="5"></td>
            </tr>
            </table>
            <table>
                <tr>
                    <td>&nbsp;</td>
                    <td align="center">제목</td>
                    <td><input name="title" size="50" maxlength="100"></td>
                    <td>&nbsp;</td>
                </tr>
                <%
                    if (!userId.equals("null")) {
                %>
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4"></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td align="center">글쓴이</td>
                    <td name="author" size="50" maxlength="50"><%=userId%>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4"></td>
                </tr>
                <%
                } else {
                %>
                <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
                <tr>
                    <td>&nbsp;</td>
                    <td align="center">글쓴이</td>
                    <td><input name="author" size="50" maxlength="50"></td>
                    <td>&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
                <tr>
                    <td>&nbsp;</td>
                    <td align="center">비밀번호</td>
                    <td><input type="password" name="password" size="50" maxlength="50"></td>
                    <td>&nbsp;</td>
                </tr>
                <%
                    }
                %>
                <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
                <tr>
                    <td>&nbsp;</td>
                    <td align="center">내용</td>
                    <td><textarea name="content" cols="50" rows="13"></textarea></td>
                    <td>&nbsp;</td>
                </tr>

                <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
                <tr height="1" bgcolor="#82B5DF"><td colspan="4"></td></tr>
                <tr align="center">
                    <td>&nbsp;</td>
                    <td colspan="2"><input type=submit value="등록" OnClick="javascript:writeCheck();">
                        <input type=button value="취소" OnClick="javascript:history.back(-1)">
                    <td>&nbsp;</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>
