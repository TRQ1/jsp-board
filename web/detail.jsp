<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 9. 19.
  Time: PM 5:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@include file="database_process.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");
    Connection conn = connDb(); // DB connection 메소드 호출
    PreparedStatement pstm = null;
    ResultSet rs = null;

    int idx = Integer.parseInt(request.getParameter("id")); // lists.jsp에서 get 메소드로 전달된 id 값
    int pg = Integer.parseInt(request.getParameter("pg"));
    int cid = 0;
    String userId = request.getParameter("userId");
    String loginUserName = null;
    String loginVistorName = null;
    String author = null;
    String title = null;
    String content = null;


    if (userId.equals("null")) {
        loginVistorName = "vistor";
    } else if (!userId.equals("null")) {
        loginUserName = userId;
    }

    try {
        String sqlSelect = "SELECT author, title, content, todate FROM board WHERE id=" + idx;
        pstm = conn.prepareStatement(sqlSelect);
        rs = pstm.executeQuery(sqlSelect);

        // 해당 id 값에 대한 정보
        if (rs.next()) {
            author = rs.getString(1);
            title = rs.getString(2);
            content = rs.getString(3);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>글 상세</title>
</head>
<body>
<table>
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr style="text-align:center;">
                    <td width="5"></td>
                    <td>글 상세</td>
                    <td width="5"></td>
                </tr>
            </table>
            <table width="413">
                <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
                <tr>
                    <td width="0">&nbsp;</td>
                    <td align="center" width="76">글쓴이</td>
                    <td width="319"><%=author%></td>
                    <td width="0">&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
                <tr>
                    <td width="0">&nbsp;</td>
                    <td align="center" width="76">제목</td>
                    <td width="319"><%=title%>
                    </td>
                    <td width="0">&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
                <tr>
                    <td width="0">&nbsp;</td>
                    <td align="center" width="76">내용</td>
                    <td width="319"><%=content %></td>
                    <td width="0">&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
                <tr>
                    <td width="0">&nbsp;</td>
                    <td width="399" colspan="2" height="200">
                </tr>
            <%
                }
                } catch(SQLException e) {
                    System.out.println( e.toString() );
                } finally {
                    close(pstm, conn);
                    resultClose(rs);
                }

            %>
                <tr height="1" bgcolor="#dddddd"><td colspan="4" width="407"></td></tr>
                <tr height="1" bgcolor="#82B5DF"><td colspan="4" width="407"></td></tr>
                <tr align="right">
                    <td width="0">&nbsp;</td>
                    <td colspan="2" width="399">
                            <%
                           if(userId.equals(author)) {
                        %>
                        <input type=button value="수정" name=id
                               OnClick="window.location='modify.jsp?id=<%=idx%>&pg=<%=pg%>&userId=<%=userId%>'">
                        <input type=button value="삭제" name=id OnClick="window.location='delete.jsp?id=<%=idx%>&pg=<%=pg%>'">
                        <input type=button value="목록"
                               OnClick="window.location='lists.jsp?pg=<%=pg%>&userId=<%=userId%>'">
                            <%
                         } else {
                        %>
                        <input type=button value="수정" name=id
                               OnClick="window.location='modify_check.jsp?id=<%=idx%>&pg=<%=pg%>&userId=<%=userId%>'">
                        <input type=button value="답글" name=id
                               OnClick="window.location='reply.jsp?id=<%=idx%>&pg=<%=pg%>'">
                        <input type=button value="삭제" name=id
                               OnClick="window.location='delete.jsp?id=<%=idx%>&pg=<%=pg%>'">
                        <input type=button value="목록" OnClick="window.location='lists.jsp?pg=<%=pg%>'">
                            <%
                                }
                        %>
                    <td width="0">&nbsp;</td>
                </tr>
            </table>
            <table>
                <%
                    try {
                        int commentTotal = sqlCountComment(idx);

                        String sqlList = "SELECT author, content, todate from comment where parent=" + idx + " ORDER BY id DESC";
                        pstm = conn.prepareStatement(sqlList);
                        rs = pstm.executeQuery(sqlList);

                        if (userId != loginVistorName && userId.equals(loginUserName)) {
                %>
                <form name=writecommentcheckform method=post
                      action="write_comment_do.jsp?id=<%=idx%>&pg=<%=pg%>&userId=<%=userId%>">
                    <tr>
                        <td align="right" width="76">사용자:</td>
                        <td width="319" name="userId"><%=userId%>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">내용</td>
                        <td><textarea name="contentComment" cols="40" rows="5"></textarea></td>
                        <td align="left" colspan="2" width="200">
                            <input type=submit value="댓글 쓰기">
                        </td>
                    </tr>
                </form>
                <%
                } else {
                %>
                <form name=writecommentcheckform method=post
                      action="write_vistor_comment_do.jsp?id=<%=idx%>&pg=<%=pg%>">
                    <tr>
                        <td align="right" width="76">사용자:</td>
                        <td><input type="text" name="authorComment" width="319"/></td>
                        <td align="left" width="76">패스워드:</td>
                        <td><input type="password" name="passwdComment" width="319"/></td>
                    </tr>
                    <tr>
                        <td align="center">내용</td>
                        <td><textarea name="contentComment" cols="40" rows="5"></textarea></td>
                        <td align="left" colspan="2" width="200">
                            <input type=submit value="댓글 쓰기">
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </form>
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="2" width="200"></td>
                </tr>
                <tr height="1" bgcolor="#82B5DF">
                    <td colspan="2" width="200"></td>
                </tr>
                <%
                    if (commentTotal == 0) {
                %>
                <tr align="center" bgcolor="#FFFFFF" height="30">
                    <td colspan="6">등록된 글이 없습니다.</td>
                </tr>
                <%
                } else {
                    while (rs.next()) {
                        String authorComment = rs.getString(1);
                        String contentComment = rs.getString(2);
                        String todateBefore = rs.getString(3);
                        String todateComment = todateBefore.substring(0, todateBefore.length() - 2);

                        if (userId.equals(author) || userId.equals(authorComment)) {
                %>
                <tr align="left">
                    <td align="left"><%=authorComment%>
                    </td>
                    <td align="left" colspan="1"><%=contentComment%>
                    </td>
                    <td align="right"><%=todateComment%>
                    </td>
                    <td align="right">
                        <input type=button value="댓글 수정"
                               OnClick="window.location='comment_modify.jsp?id=<%=idx%>&pg=<%=pg%>&userId=<%=userId%>&content=<%=contentComment%>&author=<%=authorComment%>&cid=<%=cid%>'">
                    </td>
                    <td align="right">
                        <input type=button value="댓글 삭제"
                               OnClick="window.location='comment_account_delete.jsp?id=<%=idx%>&pg=<%=pg%>&userId=<%=userId%>&content=<%=contentComment%>">
                    </td>
                </tr>
                <%
                } else if (userId.equals("null")) {
                %>
                <tr align="left">
                    <td align="left"><%=authorComment%>
                    </td>
                    <td align="left" colspan="1"><%=contentComment%>
                    </td>
                    <td align="right"><%=todateComment%>
                    </td>
                    <td align="right">
                        <input type=button value="댓글 수정"
                               OnClick="window.location='comment_modify_check.jsp?id=<%=idx%>&pg=<%=pg%>&userId=<%=userId%>&content=<%=contentComment%>&author=<%=authorComment%>'">
                    </td>
                    <td align="right">
                        <input type=button value="댓글 삭제"
                               OnClick="window.location='comment_delete.jsp?id=<%=idx%>&pg=<%=pg%>&userId=<%=userId%>&content=<%=contentComment%>&cid=<%=cid%>'">

                    </td>
                </tr>
                <%
                    }
                %>
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="2" width="200"></td>
                </tr>
                <tr height="1" bgcolor="#82B5DF">
                    <td colspan="2" width="200"></td>
                </tr>
                <%
                            }
                        }
                    } catch (SQLException e) {
                        System.out.println(e);
                    } finally {
                        close(pstm, conn);
                        resultClose(rs);
                    }
                %>
                </form>
            </table>
        </td>
    </tr>
</table>
</body>
</html>
