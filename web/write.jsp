<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 9. 19.
  Time: PM 1:16
  To change this template use File | Settings | File Templates.
--%>
<<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>글쓰기</title>
</head>
<body>
<table>
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr style="repeat-x; text-align:center;">
                    <td width="5"></td>
                    <td>글쓰기</td>
                    <td width="5"></td>
                </tr>
            </table>
            <table>
                <tr>
                    <td>&nbsp;</td>
                    <td align="center">이름</td>
                    <td><input name="title" size="50" maxlength="100"></td>
                    <td>&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
                <tr>
                    <td>&nbsp;</td>
                    <td align="center">글쓴이</td>
                    <td><input name="name" size="50" maxlength="50"></td>
                    <td>&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
                <tr>
                    <td>&nbsp;</td>
                    <td align="center">비밀번호</td>
                    <td><input name="password" size="50" maxlength="50"></td>
                    <td>&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
                <tr>
                    <td>&nbsp;</td>
                    <td align="center">내용</td>
                    <td><textarea name="memo" cols="50" rows="13"></textarea></td>
                    <td>&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd"><td colspan="4"></td></tr>
                <tr height="1" bgcolor="#82B5DF"><td colspan="4"></td></tr>
                <tr align="center">
                    <td>&nbsp;</td>
                    <td colspan="2"><input type=button value="등록">
                        <input type=button value="취소">
                    <td>&nbsp;</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>
