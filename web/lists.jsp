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
<%@include file="database_process.jsp" %>
<%
    /**
     * 쿠키값 불러오기 (로그인된 쿠키값을 확인)
     */
    String userId = request.getParameter("userId");

    Cookie[] cookies = request.getCookies(); // 요청정보로부터 쿠키를 가져온다.
    String cookieName = null;
    String cookieValue = null;
    System.out.println("cookies : " + cookies);
    if (cookies != null) {
        for (int i = 0; i < cookies.length; i++) {      // 쿠키 배열을 반복문으로 돌린다.
            String name = cookies[i].getName();      // 쿠키의 이름을 가져온다.
            String value = cookies[i].getValue();    // 쿠키의 값을 가져온다.
            System.out.println("name =" + name);
            System.out.println("value =" + value);
            if (value.equals(userId)) {
                cookieValue = value;
            }
        }
    } else if (cookies == null) {
        cookieValue = "방문자";
    }
%>
<%
    final int pageSize = 5;// 한페이지에 보일 게시물 수 
    final int countPage = 6;// 아래에 보일 페이지 최대개수 1~5 / 6~10 / 11~15 식으로 5개로 고정 
    int pg = 1; //기본 페이지값 

    if(request.getParameter("pg")!=null) {//받아온 pg값이 있을때, 다른페이지일때 
        pg = Integer.parseInt(request.getParameter("pg"));// pg값을 저장
    }
    int start = (pg * pageSize) - (pageSize - 1);// 해당페이지에서 시작번호 5 - 4  = 1 //id 값에 대한 시작 번호
    int end = (pg * pageSize);// 해당페이지에서 끝번호 5  // id 값에 대한 끝 번호
    int allPage = 0;// 전체 페이지수 
    int startPage = ((pg - 1) / countPage * countPage) + 1;// 시작블럭숫자 (1~5페이지일경우 1, 6~10일경우 6) 시작페이지를 구하기
    int endPage = ((pg - 1) / countPage * countPage) + countPage;// 끝 블럭 숫자 (1~5일 경우 5, 6~10일경우 10) 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>게시판</title>
</head>
<body>
<%
    Connection conn = connDb(); // DB connection 메소드 호출
    PreparedStatement pstm = null;
    ResultSet rs = null;
    try {
        int total = sqlCount(); // count 값을 구하기 위한 메소드 호출

        //String sqlList = "SELECT id, title, author, todate from board order by id DESC"; // 쿼리문
        //rs = stmt.executeQuery(sqlList); //DB 실행
        allPage = (int)Math.ceil(total / (double)pageSize); // 전체 게시물 갯수와 페이지에 보여야할 갯수를 나누어서 필요한 전체 페이지 수를 구한다. 나눠진 값에대해 자리 올림을 하여 필요 페이지수를 구한다.

        if(endPage > allPage) { //마지막 페이지가 모든 페이지 값보다 클시에 마지막 페이지는 총 페이지 수로 대체
            endPage = allPage;
        }
        System.out.println("count : " + total);

        /**
         * 아래 parent 기준으로 정렬하기 위해 사용 하는 로직 및 쿼리는 추후 쿼리로만 처리할 예정 << 테스트중
         */

        int sort = 1;
        String sqlSort = "SELECT id from board order by parent desc, step asc"; // parent id값 기준으로 order by 하여 오름차순 정렬
        pstm = conn.prepareStatement(sqlSort);
        rs = pstm.executeQuery(sqlSort);

        while (rs.next()) {
            int deptNum = rs.getInt(1);
            String sqlDeptUpdate = "UPDATE board SET sort=" + sort + " where id=" + deptNum; // parent 값을 기준으로 정렬에 사용할 쿼리 정보를 sort 컬럼에 update
            System.out.println(sqlDeptUpdate);
            pstm.executeUpdate(sqlDeptUpdate);
            sort++;
        }
        resultClose(rs);
        String sqlList = "SELECT id, author, title, todate, indent from board where sort >= " + start + " and sort <= " + end + " order by sort ASC"; // sort 값 기준으로 페이징 갯수 많큼 oder by 하여 오름차순 정렬
        pstm = conn.prepareStatement(sqlList);
        rs = pstm.executeQuery(sqlList);
%>
<table width="100%" cellpadding="0" cellspacing="0" border="0">
    <tr height="5">Welcome to <%=cookieValue%>
        <td width="5"></td>
    </tr>
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
            String author = rs.getString(2);
            String checkTitle = rs.getString(3);
            String todateBefore = rs.getString(4);
            String todate = todateBefore.substring(0, todateBefore.length() - 2); // 소수점 자르기 추후 데이터 타입 나오게 할 예정
            int indent = rs.getInt(5);

            // checkTitle 에 200자 이상인 경우 ... 을 붙인다.
            String title = ""; // 실제 제목을 넣을 변수
            int titleLen = checkTitle.length(); //
            System.out.println("Length : " + titleLen);

            if (titleLen > 200) { // 200 이상인 경우 titlelen 숫자에서 - 10 을 한후 뒤에 ... 을 붙인다.
                title = checkTitle.substring(0, titleLen - 10) + "...";
            } else {
                title = checkTitle;
            }
    %>
    <tr height="25" align="center">
        <td>&nbsp;</td>
        <td><%=id %></td>
        <td align="left">
            <%
                for (int j = 0; j < indent; j++) {
            %>
            &nbsp;&nbsp;&nbsp;
            <%
                }
                if (indent != 0) {
                }
            %>
            <!-- get 방식으로 주소 뒤에 ?를 붙인 변수명=변수값 이 해당 주소에 입력 -->
            <a href="detail.jsp?id=<%=id%>&pg=<%=pg%>"><%=title %>
        </td>
        <td align="center"><%=author %></td>
        <td align="center"><%=todate %></td>
        <td>&nbsp;</td>
    </tr>
    <tr height="1" bgcolor="#D2D2D2"><td colspan="6"></td></tr>
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
    <tr height="1" bgcolor="#82B5DF"><td colspan="6" width="752"></td></tr>
</table>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
    <tr><td colspan="4" height="5"></td></tr>
    <tr>
        <td align="center">
            <%
                if(pg > countPage) {  //  기본 페이지수
            %>
            [<a href="lists.jsp?pg=1">◀◀</a>]
            [<a href="lists.jsp?pg=<%=startPage-1%>">◀</a>]
            <%
                }
            %>

            <%
                for(int i=startPage; i<= endPage; i++){ // 시작페이지부터 마지막페이지까지 하나씩 증가를 하고 출력 하고 해당 숫자의 페이징을 호출하여 해당 게시물로 동
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
                if(endPage < allPage){  // 마지막 페이지가 모든 페이지보다 낮을 경우에는 다음을 눌렀을때 마지막 페이지 + 1을 값으로 페이징을 호출,
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
</table>
</body>
</html>

