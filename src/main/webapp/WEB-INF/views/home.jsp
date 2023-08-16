<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/home.jsp</title>
</head>
<body>
	<div class="container">
		<c:choose>
			<c:when test="${empty sessionScope.id }">
				<a href="${pageContext.request.contextPath}/users/loginform">로그인</a>
				<a href="${pageContext.request.contextPath}/users/signup_form">회원가입</a>
			</c:when>
			<c:otherwise>
				<p>
					<a href="${pageContext.request.contextPath}/users/info">${id }</a> 님 반갑습니다 !
					<a href="${pageContext.request.contextPath}/users/logout">로그아웃</a>
				</p>
			</c:otherwise>
		</c:choose>
		<h1></h1>
		<ul>
			<li><a href="${pageContext.request.contextPath }/cafe/list">카페 글 목록 보기</a></li>
			<li><a href="${pageContext.request.contextPath }/file/list">자료실 목록 보기</a></li>
			<li><a href="${pageContext.request.contextPath }/gallery/list">겔러리 목록 보기</a></li>
		</ul>
	</div>
</body>
</html>