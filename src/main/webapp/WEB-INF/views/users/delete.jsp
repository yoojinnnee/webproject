<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/users/delete.jsp</title>
</head>
<body>
	<div class="container">
		<p>
			<strong>${requestScope.id }</strong> 님 탈퇴 완료
			<a href="${pageContext.request.contextPath}/">인덱스로 가기</a>
		</p>
	</div>
</body>
</html>