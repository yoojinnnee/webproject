<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/users/loginform.jsp</title>
	<style>
		body {
			margin: 0;
		}
		.container {
			position: relative;
			display: flex;
			justify-content: center;
			align-items: center;
			height: 100vh;
			flex-direction: column;
		}
		.container img {
			width: 100%;
			height: 100%;
			object-fit: cover; /* 이미지 비율을 유지하면서 꽉 차게 설정 */
			position: absolute;
			z-index: -1; /* 이미지 뒤로 보내기 */
		}
		.container p {
			position: relative;
			z-index: 1; /* 텍스트 앞으로 가져오기 */
		}
	</style>
</head>
<body>
	<div class="container">
		<img src="${pageContext.request.contextPath}/resources/images/star.png">
		<h1>로그인 폼 입니다.</h1>
		<form action="${pageContext.request.contextPath}/users/login" method="post">
			<c:choose>
				<c:when test="${ empty param.url }">
					<input type="hidden" name="url" value="${pageContext.request.contextPath}/"/>
				</c:when>
				<c:otherwise>
					<input type="hidden" name="url" value="${param.url }"/>
				</c:otherwise>
			</c:choose>
			<div>
				<label for="id">아이디</label>
				<input type="text" name="id" id="id"/>
			</div>
			<div>
				<label for="pwd">비밀번호</label>
				<input type="password" name="pwd" id="pwd"/>
			</div>
			<button type="submit">로그인</button>
		</form>
	</div>
</body>
</html>