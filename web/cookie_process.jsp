<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 10. 3.
  Time: PM 3:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%!
    public void createCookie(HttpServletResponse response, String userId, String random) {
        Cookie cookie = new Cookie(userId, random);    // 쿠키를 생성한다. 이름:testCookie, 값 : Hello Cookie
        cookie.setMaxAge(365 * 24 * 60 * 60);                                 // 쿠키의 유효기간을 365일로 설정한다.
        cookie.setPath("/");                                                    // 쿠키의 유효한 디렉토리를 "/" 로 설정한다.
        response.addCookie(cookie);
    }

    public String checkLogin(HttpServletRequest request, String userId) {
        String cookieUser = null;
        Cookie[] cookies = request.getCookies(); // 요청정보로부터 쿠키를 가져온다.
        for (Cookie cookie : cookies) {      // 쿠키 배열을 반복문으로 돌린다.
            if (cookie.getName().equals(userId)) {
                cookieUser = cookie.getValue(); // 쿠키값을 가져온다.
            }
        }
        return cookieUser;
    }


    public void deleteCookie(HttpServletRequest request, HttpServletResponse response, String userId) {
        Cookie[] cookies = request.getCookies();                   // 요청에서 쿠키를 가져온다.
        if (cookies != null) {                                            // 쿠키가 Null이 아니라면
            for (int i = 0; i < cookies.length; i++) {                // 쿠키를 반복문으로 돌린다.
                if (cookies[i].getName().equals(userId)) {        // 쿠키의 이름이 userid 일때
                    cookies[i].setMaxAge(0);                    // 쿠키의 유효시간을 0 으로 셋팅한다.
                    response.addCookie(cookies[i]);        // 수정한 쿠키를 응답에 추가(수정) 한다.
                }
            }
        }
    }

    public String generateRandomString(int size) {
        String chars[] = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9".split(",");

        StringBuffer buffer = new StringBuffer();
        Random random = new Random();
        for (int i = 0; i < size; i++) {
            buffer.append(chars[random.nextInt(chars.length)]);
        }
        return buffer.toString();
    }

%>
