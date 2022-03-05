<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><!-- %@는 페이지의 속성을 정의함 -->
<%@ page import="user.UserDAO" %> <!-- user패키지 안에 있는 UserDAO를 갖고옴 -->
<%@ page import="java.io.PrintWriter" %><!-- 자바스크립트 문장을 작성하기 위해 사용 -->
<% request.setCharacterEncoding("UTF-8"); %><!-- 건너오는 데이터를 UTF-8로 받을 수 있도록 작성 -->
<jsp:useBean id="user" class="user.User" scope="page" /><!-- 요청된 page 내부에서  bean이 사용됨, 지역변수처럼 user가 사용됨 --><!-- bean은 데이터를 읽어오거나 저장하는 역할을 반복적으로 수행하기 위해 사용됨. -->
<jsp:setProperty name="user" property="userID" /><!-- setProperty에서는 user값을 설정함. -->
<jsp:setProperty name="user" property="userPassword" /><!-- JSP에서는 field를 property라고 부른다. -->
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		if (user.getUserID() == null || user.getUserPassword() == null 
									 || user.getUserName() == null 
									 || user.getUserGender() == null 
									 || user.getUserEmail() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()"); //history.back = 이전 페이지로 돌아감
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO(); //데이터베이스에 접근할 수 있는 객체를 만듬
			int result = userDAO.join(user); //user라는 인스턴스가 join함수를 실행하도록 매개변수로 들어감.
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()"); //history.back = 이전 페이지로 돌아감
				script.println("</script>");
			}
			else {
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>