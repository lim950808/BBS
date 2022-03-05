<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><!-- %@는 페이지의 속성을 정의함 -->
<%@ page import="user.UserDAO" %> <!-- user패키지 안에 있는 UserDAO를 갖고옴 -->
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		session.invalidate(); //현재 session을 벗어남
	%>
	<script>
		location.href = 'main.jsp';
	</script>
</body>
</html>