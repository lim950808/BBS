<!-- userDAO.java를 이용해 실질적으로 로그인을 실행하는 부분 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><!-- %@는 페이지의 속성을 정의함 -->
<%@ page import="user.UserDAO" %> <!-- user패키지 안에 있는 UserDAO를 갖고옴 -->
<%@ page import="java.io.PrintWriter" %><!-- 자바스크립트 문장을 작성하기 위해 사용 -->
<% request.setCharacterEncoding("UTF-8"); %><!-- 건너오는 데이터를 UTF-8로 받을 수 있도록 작성 -->
<jsp:useBean id="user" class="user.User" scope="page" /><!-- 요청된 page 내부에서  bean이 사용됨, 지역변수처럼 user가 사용됨 --><!-- bean은 데이터를 읽어오거나 저장하는 역할을 반복적으로 수행하기 위해 사용됨. -->
<jsp:setProperty name="user" property="userID" /><!-- setProperty에서는 user값을 설정함. -->
<jsp:setProperty name="user" property="userPassword" /><!-- JSP에서는 field를 property라고 부른다. -->
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
		UserDAO userDAO = new UserDAO(); //인스턴스 생성
		int result = userDAO.login(user.getUserID(), user.getUserPassword()); 
		//login.jsp에서 입력된 id와 pw을 가지고 로그인을 실행
		if (result == 1) { //로그인 성공시
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter(); //스크립트 문장을 생성
			script.println("<script>"); //스크립트 문장을 유동적으로 실행시킴
			script.println("location.href = 'main.jsp'"); //로그인이 성공하면 main.jsp로 이동
			script.println("</script>");
		}
		else if(result == 0) { //pw가 틀릴때
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()"); //pw가 틀릴때 이전 페이지로 돌아감
			script.println("</script>");
		}
		else if(result == -1) { //존재하지 않는 아이디일때
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == -2) { //db 오류시
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>