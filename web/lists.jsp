<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 9. 18.
  Time: PM 7:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!--sql를 사용하기 위해 import-->
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
    final int pageSize = 5;// 한페이지에 보일 게시물 수 
    final int countPage = 6;// 아래에 보일 페이지 최대개수 1~5 / 6~10 / 11~15 식으로 5개로 고정 
    int pg = 1; //기본 페이지값 

    if(request.getParameter("pg")!=null) {//받아온 pg값이 있을때, 다른페이지일때 
        pg = Integer.parseInt(request.getParameter("pg"));// pg값을 저장
    }
    int start = (pg * pageSize) - (pageSize - 1);// 해당페이지에서 시작번호
    int end = (pg * pageSize);// 해당페이지에서 끝번호
    int allPage = 0;// 전체 페이지수 
    int startPage = ((pg - 1) / countPage * countPage) + 1;// 시작블럭숫자 (1~5페이지일경우 1, 6~10일경우 6) 
    int endPage = ((pg - 1) / countPage * countPage) + countPage;// 끝 블럭 숫자 (1~5일 경우 5, 6~10일경우 10) 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>게시판</title>
</head>
<body>
<%
    Class.forName("org.mariadb.jdbc.Driver");
    String url = "jdbc:mariadb://localhost:3306/boards";
    String userid = "root";
    String passwd = "qwer0987";
    int total = 0;

    try {
        Connection conn = DriverManager.getConnection(url,userid,passwd); //DB 연결
        Statement stmt = conn.createStatement(); //Statement 객체 생성

        String sqlCount = "SELECT COUNT(*) FROM board"; // board 테이블에 데이터 갯수 확인
        ResultSet rs = stmt.executeQuery(sqlCount); //DB 실행

        if(rs.next()){ //rs 값에 들어올 경우
            total = rs.getInt(1); // select문 count 값
        }
        rs.close();

        //String sqlList = "SELECT id, title, author, todate from board order by id DESC"; // 쿼리문
        //rs = stmt.executeQuery(sqlList); //DB 실행

        allPage = (int)Math.ceil(total / (double)pageSize);

        if(endPage > allPage) {
            endPage = allPage;
        }
        System.out.println("count : " + total);
        // id 값 기준으로 sort.. (추후 다른 컬럼을 생성하여 기준점을 잡을 예정)
        String sqlList = "SELECT id, author, title, todate from board where id >="+start + " and id <= "+ end +" order by id DESC";
        rs = stmt.executeQuery(sqlList);
%>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
    <tr height="5"><td width="5"></td></tr>
    <tr style="text-align:center;">
        <td width="5"></td>
        <td width="20">번호</td>
        <td width="200">제목</td>
        <td width="50">글쓴이</td>
        <td width="60">등록일</td>
        <td width="7"></td>
    </tr>
    <%
        if(total==0) { // total 값이 0일 경우 등록된 글이 없음 출력
    %>
    <tr align="center" bgcolor="#FFFFFF" height="30">
        <td colspan="6">등록된 글이 없습니다.</td>
    </tr>
    <%
    } else {

        while(rs.next()) { // rs 값이 있을 경우
            int id = rs.getInt(1);
            String title= rs.getString(2);
            String author = rs.getString(3);
            String todate = rs.getString(4);
    %>
    <tr height="25" align="center">
        <td>&nbsp;</td>
        <td><%=id %></td>
        <!-- get 방식으로 주소 뒤에 ?를 붙인 변수명=변수값 이 해당 주소에 입력 -->
        <td align="left"><a href="detail.jsp?id=<%=id%>&pg=<%=pg%>"><%=title %></td>
        <td align="center"><%=author %></td>
        <td align="center"><%=todate %></td>
        <td>&nbsp;</td>
    </tr>
    <tr height="1" bgcolor="#D2D2D2"><td colspan="6"></td></tr>
    <%
                }
            }
            rs.close(); //rs 객체 반환
            stmt.close(); //stmt 객체 반환
            conn.close(); //conn 객체 반환
        } catch(SQLException e) {
            System.out.println( e.toString() );
        }
    %>
    <tr height="1" bgcolor="#82B5DF"><td colspan="6" width="752"></td></tr>
</table>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
    <tr><td colspan="4" height="5"></td></tr>
    <tr>
        <td align="center">
            <%
                if(pg > countPage) {
            %>
            [<a href="lists.jsp?pg=1">◀◀</a>]
            [<a href="lists.jsp?pg=<%=startPage-1%>">◀</a>]
            <%
                }
            %>

            <%
                for(int i=startPage; i<= endPage; i++){
                    if(i == pg){
            %>
            <u><b>[<%=i %>]</b></u>
            <%
            }else{
            %>
            [<a href="lists.jsp?pg=<%=i %>"><%=i %></a>]
            <%
                    }
                }
            %>

            <%
                if(endPage < allPage){
            %>
            [<a href="lists.jsp?pg=<%=endPage+1%>">▶</a>]
            [<a href="lists.jsp?pg=<%=allPage%>">▶▶</a>]
            <%
                }
            %>
        </td>
    </tr>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
    <tr><td colspan="4" height="5"></td></tr>
    <tr align="right">
        <td><input type=button value="글쓰기" OnClick="window.location='write.jsp'"></td>
    </tr>
</table>
</body>
</html>

