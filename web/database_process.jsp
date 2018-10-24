<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 10. 1.
  Time: AM 9:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%!
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

    public int sqlCount() {
        PreparedStatement pstm = null;
        ResultSet rs = null;
        Connection conn = connDb();
        int total = 0;
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
        return total;
    }

    /**
     * 게시판 글 패스워드를 확인 하기위한 메소드
     */
    public String sqlPasswd(int idx) {
        PreparedStatement pstm = null;
        ResultSet rs = null;
        Connection conn = connDb();
        String password = "";
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
        return password;
    }

    public void sqlDelete(int idx) {
        PreparedStatement pstm = null;
        Connection conn = connDb();
        try {
            String sqlDelete = "DELETE FROM board WHERE id=" + idx;
            System.out.println(sqlDelete);
            pstm = conn.prepareStatement(sqlDelete);
            pstm.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            close(pstm, conn);
        }
    }

    /**
     * 게시판 정보를 읽어드리기위한 메소드
     */
    public void sqlSelect(int idx) {
        PreparedStatement pstm = null;
        ResultSet rs = null;
        Connection conn = connDb();
        String authorSelect = "";
        String titleSelect = "";
        String contentSelect = "";
        String todateSelect = "";
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
        return;
    }

    /**
     * sqlList를 리턴하기 위한 class
     */
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
        int id = 0;
        String author = "";
        String todate = "";
        String title = "";
        String todateBefore = "";
        String checkTitle = "";
        try {
            String sqlList = "SELECT id, author, title, todate from board where id >=" + start + " and id <= " + end + " order by id DESC";
            pstm = conn.prepareStatement(sqlList);
            rs = pstm.executeQuery(sqlList);

            while (rs.next()) {
                id = rs.getInt(1);
                author = rs.getString(2);
                checkTitle = rs.getString(3);
                todateBefore = rs.getString(4);
                todate = todateBefore.substring(0, todateBefore.length() - 2); // 소수점 자르기 추후 데이터 타입 나오게 할 예정

                // checkTitle 에 200자 이상인 경우 ... 을 붙인다.
                int titleLen = checkTitle.length();

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
    public void sqlUpdate(String title, String content, int idx) {
        PreparedStatement pstm = null;
        Connection conn = connDb();
        try {
            String sqlUpdate = "UPDATE board SET title='" + title + "' ,content='" + content + "' WHERE id=" + idx;
            pstm = conn.prepareStatement(sqlUpdate);
            pstm.executeUpdate(sqlUpdate);
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            close(pstm, conn);
        }
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
    public void sqlInsert(String authorInsert, String passwordInsert, String titleInsert, String contentInsert, String kindType, int parentInsert) {
        PreparedStatement pstm = null;
        Connection conn = connDb();
        try {
            String sqlInsert = "INSERT INTO board(author,passwd,title,content,type,parent,todate) VALUES(?,?,?,?,?,?,NOW())";
            System.out.println(sqlInsert);
            pstm = conn.prepareStatement(sqlInsert);
            pstm.setString(1, authorInsert);
            pstm.setString(2, passwordInsert);
            pstm.setString(3, titleInsert);
            pstm.setString(4, contentInsert);
            if (kindType == "post") {
                pstm.setString(5, kindType);
            } else if (kindType == "comment") {
                pstm.setString(5, kindType);
            }
            pstm.setInt(6, parentInsert + 1);
            pstm.execute();
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            close(pstm, conn);
        }
    }

    public void sqlReplyInsert(String authorInsert, String passwordInsert, String titleInsert, String contentInsert, String kindType, int parentInsert, int indentInsert, int stepInsert) {
        PreparedStatement pstm = null;
        Connection conn = connDb();
        try {
            String sqlInsert = "INSERT INTO board(author,passwd,title,content,type,parent,indent,step,todate) VALUES(?,?,?,?,?,?,?,?,NOW())";
            System.out.println(sqlInsert);
            pstm = conn.prepareStatement(sqlInsert);
            pstm.setString(1, authorInsert);
            pstm.setString(2, passwordInsert);
            pstm.setString(3, titleInsert);
            pstm.setString(4, contentInsert);
            if (kindType == "post") {
                pstm.setString(5, kindType);
            } else if (kindType == "comment") {
                pstm.setString(5, kindType);
            }
            pstm.setInt(6, parentInsert);
            pstm.setInt(7, indentInsert + 1);
            pstm.setInt(8, stepInsert + 1);
            pstm.execute();

        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            close(pstm, conn);
        }
    }

    /**
     *
     * @param accountid
     * @return
     * 로그인시 필요한 유저 계정을 읽어오는 메소드
     */
    public String sqlUserId(int accountid) {
        PreparedStatement pstm = null;
        ResultSet rs = null;
        Connection conn = connDb();
        String userid = null;
        try {
            String sqluserid = "SELECT userid FROM account WHERE id=" + accountid;
            pstm = conn.prepareStatement(sqluserid);
            rs = pstm.executeQuery(sqluserid);

            if (rs.next()) {
                userid = rs.getString(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            close(pstm, conn);
            resultClose(rs);
        }
        return userid;
    }

    /**
     *
     * @param accountid
     * @return
     * 로그인시 필요한 유저 패스워드 계정을 읽어오는 메소드
     */
    public String sqlUserPass(int accountid) {
        PreparedStatement pstm = null;
        ResultSet rs = null;
        Connection conn = connDb();
        String userpass = null;
        try {
            String sqluserpass = "SELECT userpass FROM account WHERE id=" + accountid;
            pstm = conn.prepareStatement(sqluserpass);
            rs = pstm.executeQuery(sqluserpass);

            if (rs.next()) {
                userpass = rs.getString(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            close(pstm, conn);
            resultClose(rs);
        }
        return userpass;
    }

    /**
     * 댓글 수에 대한 전체 갯수 확인하기 위한 메소드
     * @return
     */
    public int sqlCountComment(int idx) {
        PreparedStatement pstm = null;
        ResultSet rs = null;
        Connection conn = connDb();
        int total = 0;
        try {
            String sqlCount = "SELECT COUNT(*) FROM comment where parent=" + idx;
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
        return total;
    }

    /**
     * 회원이 댓글을 쓰기 위한 쿼리 매소드
     * @param authorInsert
     * @param contentInsert
     * @param parentInsert
     */
    public void sqlInsertAcoountCommnet(String authorInsert, String contentInsert, int parentInsert) {
        PreparedStatement pstm = null;
        Connection conn = connDb();
        try {
            String sqlInsert = "INSERT INTO comment(author,content,parent,todate) VALUES(?,?,?,NOW())";
            System.out.println(sqlInsert);
            pstm = conn.prepareStatement(sqlInsert);
            pstm.setString(1, authorInsert);
            pstm.setString(2, contentInsert);
            pstm.setInt(3, parentInsert);
            pstm.execute();
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            close(pstm, conn);
        }
    }

    /**
     * 방문자가 댓글을 쓰기 위한 쿼리 메소드
     * @param authorInsert
     * @param passwordInsert
     * @param contentInsert
     * @param parentInsert
     */
    public void sqlInsertVistorCommnet(String authorInsert, String passwordInsert, String contentInsert, int parentInsert) {
        PreparedStatement pstm = null;
        Connection conn = connDb();
        try {
            String sqlInsert = "INSERT INTO comment(author,passwd,content,parent,todate) VALUES(?,?,?,?,NOW())";
            System.out.println(sqlInsert);
            pstm = conn.prepareStatement(sqlInsert);
            pstm.setString(1, authorInsert);
            pstm.setString(2, passwordInsert);
            pstm.setString(3, contentInsert);
            pstm.setInt(4, parentInsert);
            pstm.execute();
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            close(pstm, conn);
        }
    }

    /**
     * Comment를 수정하기위한 메소드
     * @param content
     * @param idx
     */
    public void sqlCommentUpdate(String content, int idx) {
        PreparedStatement pstm = null;
        Connection conn = connDb();
        try {
            String sqlUpdate = "UPDATE comment SET content=" + "'" + content + "'" + ", todate=NOW() WHERE id=" + idx;
            System.out.println(sqlUpdate);
            pstm = conn.prepareStatement(sqlUpdate);
            pstm.executeUpdate(sqlUpdate);
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            close(pstm, conn);
        }
    }

    /**
     * 해당되는 comment ID값을 가져오기 위한 메소드
     * @param content
     * @param parent
     * @return
     */
    public int sqlSelectCommentId(String content, int parent) {
        PreparedStatement pstm = null;
        ResultSet rs = null;
        Connection conn = connDb();
        int id = 0;
        try {
            String sqlSelect = "SELECT id from comment where content=" + "'" + content + "'" + " and parent=" + parent;
            pstm = conn.prepareStatement(sqlSelect);
            rs = pstm.executeQuery(sqlSelect);
            if (rs.next()) {
                id = rs.getInt(1); // select문 count 값
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            close(pstm, conn);
            resultClose(rs);
        }
        return id;
    }

    /**
     * Comment 패스워드를 체크하기위한 메소드
     * @param idx
     * @return
     */
    public String sqlCommentPasswd(int idx) {
        PreparedStatement pstm = null;
        ResultSet rs = null;
        Connection conn = connDb();
        String password = "";
        try {
            String sqlPasswd = "SELECT passwd FROM comment WHERE id=" + idx;
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
        return password;
    }

    /**
     * Comment를 삭제하기위한 메소드
     * @param idx
     */
    public void sqlCommentDelete(int idx) {
        PreparedStatement pstm = null;
        Connection conn = connDb();
        try {
            String sqlDelete = "DELETE FROM comment WHERE id=" + idx;
            System.out.println(sqlDelete);
            pstm = conn.prepareStatement(sqlDelete);
            pstm.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            close(pstm, conn);
        }
    }

    /**
     * 계정에 대한 패스워드 확인하는 메소드
     * @param userId
     * @return
     */
    public String sqlGetPasswd(String userId) {
        PreparedStatement pstm = null;
        ResultSet rs = null;
        Connection conn = connDb();
        String password = "";
        try {
            String sqlPasswd = "SELECT userpasswd FROM account WHERE userid=" + "'" + userId + "'";
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
        return password;
    }

%>
