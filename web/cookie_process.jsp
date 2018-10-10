<%--
  Created by IntelliJ IDEA.
  User: TRQ1
  Date: 2018. 10. 3.
  Time: PM 3:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%!
    public void createCookie(String userId) {
        Cookie cookie = new Cookie("board", userId);    // 쿠키를 생성한다. 이름:testCookie, 값 : Hello Cookie
        cookie.setMaxAge(365 * 24 * 60 * 60);                                 // 쿠키의 유효기간을 365일로 설정한다.
        cookie.setPath("/");                                                    // 쿠키의 유효한 디렉토리를 "/" 로 설정한다.
        response.addCookie(cookie);
    }

    public String obtainCookie(String userId) {
        Cookie[] cookies = request.getCookies(); // 요청정보로부터 쿠키를 가져온다.
        String cookieValue = null;
        if (cookies != null) {
            for (int i = 0; i < cookies.length; i++) {      // 쿠키 배열을 반복문으로 돌린다.
                if (cookies.getName().equals(userId)) {
                    cookieValue = cookies[i].getValue(); // 쿠키값을 가져온다.
                }
            }
        }
        return cookieValue;
    }

    public void deleteCookie(String userId) {
        Cookie[] cookies = request.getCookies();                    // 요청에서 쿠키를 가져온다.
        if (cookies != null) {                                            // 쿠키가 Null이 아니라면
            for (int i = 0; i < cookies.length; i++) {                // 쿠키를 반복문으로 돌린다.
                if (cookies[i].getName().equals(userId)) {        // 쿠키의 이름이 userid 일때
                    cookies[i].setMaxAge(0);                    // 쿠키의 유효시간을 0 으로 셋팅한다.
                    response.addCookie(cookies[i]);        // 수정한 쿠키를 응답에 추가(수정) 한다.
                }
            }
        }
    }


%>
