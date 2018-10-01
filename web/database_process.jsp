<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 10. 1.
  Time: AM 9:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@include file="write.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>


<%!
    request.setCharacterEncoding("UTF-8");

    int idx = Integer.parseInt(request.getParameter("id"));
    int total = 0;

    String authorSelect = "";
    String titleSelect = "";
    String contentSelect = "";
    String todateSelect = "";
    String password = "";

    int start = request.getParameter("start");
    int end = request.getParameter("end");


    String titleUpdate = "";
    String contentUpdate = "";

    String authorInsert = request.getParameter("author"); //write.jsp에서 author에 입력한 데이터값
    String passwordInsert = request.getParameter("password"); //write.jsp에서 password에 입력한 데이터값
    String titleInsert = request.getParameter("title"); //write.jsp에서 title에 입력한 데이터값
    String contentInsert = request.getParameter("content"); //write.jsp에서 content에 입력한 데이터값


    public Connection connDb() {
        Connection conn = null;
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            String url = "jdbc:mariadb://localhost:3306/boards";
            String userid = "root";
            String passwd = "qwer0987";
            conn = DriverManager.getConnection(url, userid, passwd);
        } catch (SQLException e) {
            System.out.println(e);
        } catch (ClassNotFoundException c) {
            System.out.println(c);
        }
        return conn;
    }

    /**
     *
     * @param pstmt
     * @param rs
     * @param conn
     * PrepareStatement, ResultSet, Connection 종료를 위한 메소드
     */
    public void close(PreparedStatement pstmt, Connection conn) {
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException e) {
                System.out.println(e);
            }
        } else if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.out.println(e);
            }
        }

    }

    public void resultClose(ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                System.out.println(e);
            }
        }
    }

    /**
     * SQLCount 쿼리를 위한 메소드
     */
    public void sqlCount() {
        PreparedStatement pstm = null;
        ResultSet rs = null;
        Connection conn = connDb();
        try {
            String sqlCount = "SELECT COUNT(*) FROM board";
            pstm = conn.prepareStatement(sqlCount);
            rs = pstm.executeQuery(sqlCount);

            if (rs.next()) {
                total = rs.getInt(1); // select문 count 값
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            close(pstm, conn);
            resultClose(rs);
        }
    }

    /**
     * 게시판 글 패스워드를 확인 하기위한 메소드
     */
    public void sqlPasswd() {
        PreparedStatement pstm = null;
        ResultSet rs = null;
        Connection conn = connDb();
        try {
            String sqlPasswd = "SELECT passwd FROM board WHERE id=" + idx;
            pstm = conn.prepareStatement(sqlPasswd);
            rs = pstm.executeQuery(sqlPasswd);

            if (rs.next()) {
                password = rs.getString(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            close(pstm, conn);
            resultClose(rs);
        }
    }

    /**
     * 게시판 정보를 읽어드리기위한 메소드
     */
    public void sqlSelect() {
        PreparedStatement pstm = null;
        ResultSet rs = null;
        Connection conn = connDb();
        try {
            String sqlSelect = "SELECT author, title, content, todate FROM board WHERE id=" + idx;
            pstm = conn.prepareStatement(sqlSelect);
            rs = pstm.executeQuery(sqlSelect);

            if (rs.next()) {
                authorSelect = rs.getString(1);
                titleSelect = rs.getString(2);
                contentSelect = rs.getString(3);
                todateSelect = rs.getString(4);
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            close(pstm, conn);
            resultClose(rs);
        }
    }

    /**
     *
     * @param start
     * @param end
     * 게시판 글 리스트를 읽어드리기 위한 메소드
     */
    public void sqlList(int start, int end) {
        PreparedStatement pstm = null;
        ResultSet rs = null;
        Connection conn = connDb();
        try {
            String sqlList = "SELECT id, author, title, todate from board where id >=" + start + " and id <= " + end + " order by id DESC";
            pstm = conn.prepareStatement(sqlList);
            rs = pstm.executeQuery(sqlList);

            while (rs.next()) {
                int id = rs.getInt(1);
                String author = rs.getString(2);
                String checkTitle = rs.getString(3);
                String todateBefore = rs.getString(4);
                String todate = todateBefore.substring(0, todateBefore.length() - 2); // 소수점 자르기 추후 데이터 타입 나오게 할 예정

                // checkTitle 에 200자 이상인 경우 ... 을 붙인다.
                String title = ""; // 실제 제목을 넣을 변수
                int titleLen = checkTitle.length(); //

                if (titleLen > 200) { // 200 이상인 경우 titlelen 숫자에서 - 10 을 한후 뒤에 ... 을 붙인다.
                    title = checkTitle.substring(0, titleLen - 10) + "...";
                } else {
                    title = checkTitle;
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            close(pstm, conn);
            resultClose(rs);
        }
    }

    /**
     *
     * @param title
     * @param content
     * 게시판 글 제목 및 내용을 수정하기위한 메소드
     */
    public void sqlUpdate(String title, String content) {
        PreparedStatement pstm = null;
        Connection conn = connDb();
        try {
            String sqlUpdate = "UPDATE board SET title='" + title + "' ,content='" + content + "' WHERE id=" + idx;
            pstm = conn.prepareStatement(sqlUpdate);
            pstm.executeUpdate(sqlUpdate);
        } catch (SQLException e) {
            System.out.println(e);
        }
        close(pstm, conn);
    }

    /**
     *
     * @param authorInsert
     * @param passwordInsert
     * @param titleInsert
     * @param contentInsert
     *
     * 게시판 글을 쓰기 위한 메소드
     */
    public void sqlInsert(String authorInsert, String passwordInsert, String titleInsert, String contentInsert) {
        PreparedStatement pstm = null;
        Connection conn = connDb();
        try {
            String sqlInsert = "INSERT INTO board(author,passwd,title,content,todate) VALUES(?,?,?,?,NOW())";
            pstm = conn.prepareStatement(sqlInsert);

            pstm.setString(1, authorInsert);
            pstm.setString(2, passwordInsert);
            pstm.setString(3, titleInsert);
            pstm.setString(4, contentInsert);
            pstm.execute();
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            close(pstm, conn);
        }
    }

%>
