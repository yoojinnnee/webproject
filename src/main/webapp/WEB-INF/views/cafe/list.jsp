<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/cafe/list.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</head>
<body>
	<div class="container">
		<p style="text-align: right; margin-top: 20px">
		<a href="${pageContext.request.contextPath }/cafe/insertform"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
			<path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
			<path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
		</svg></a>
		<table class="table table-striped">
			<thead class="table-dark">
				<tr>
					<th style="text-align: center;">글번호</th>
					<th style="text-align: center;">작성자</th>
					<th style="text-align: center;">제목</th>
					<th style="text-align: center;">조회수</th>
					<th style="text-align: center;">작성일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="tmp" items="${list }">
					<tr>
						<td style="text-align: center;">${tmp.num }</td>
						<td style="text-align: center;">${tmp.writer }</td>
						<td style="text-align: center;">
							<a href="detail?num=${tmp.num }&condition=${condition}&keyword=${encodedK}">${tmp.title }</a>
						</td>
						<td style="text-align: center;">${tmp.viewCount }</td>
						<td style="text-align: center;">${tmp.regdate }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<nav>
			<ul class="pagination">
				<%--
					startPageNum 이 1 이 아닌 경우에만 Prev 링크를 제공한다. 
					&condition=${condition}&keyword=${encodedK}
				 --%>
				<c:if test="${startPageNum ne 1 }">
					<li class="page-item">
						<a class="page-link animate__animated" href="list?pageNum=${startPageNum-1 }&condition=${condition}&keyword=${encodedK}">Prev</a>
					</li>
				</c:if>
				<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
					<li class="page-item ${pageNum eq i ? 'active' : '' }">
						<a class="page-link animate__animated" href="list?pageNum=${i }&condition=${condition}&keyword=${encodedK}">${i }</a>
					</li>
				</c:forEach>
				<%--
					마지막 페이지 번호가 전체 페이지의 갯수보다 작으면 Next 링크를 제공한다. 
				 --%>
				<c:if test="${endPageNum lt totalPageCount }">
					<li class="page-item">
						<a class="page-link animate__animated" href="list?pageNum=${endPageNum+1 }&condition=${condition}&keyword=${encodedK}">Next</a>
					</li>
				</c:if>				
			</ul>
		</nav>
		<script>
			document.querySelectorAll(".pagination a").forEach(function(item){
				//item 은 a 의 참조값이다 모든 a 요소에 mouseover 이벤트가 발생했을때 실행할 함수 등록
				item.addEventListener("mouseover", function(e){
					//애니메이션 클래스를 추가해서 애니메이션이 동작하도록한다.
					e.target.classList.add("animate__swing");
				});
				//item 은 a 의 참조값이다 모든 a 요소에 animationend 이벤트가 발생했을때 실행할 함수 등록
				item.addEventListener("animationend", function(e){
					//애니메이션 클래스를 제거해서 다음번에 추가 되면 다시 애니매이션이 동작 되도록한다.
					e.target.classList.remove("animate__swing");
				});
			});
		</script>
		
		<!-- 검색 폼 -->
		<form action="list" method="get">
			<label for="condition"></label>
			<select name="condition" id="condition">
				<option value="title_content" ${condition eq 'title_content' ? 'selected' : '' }>제목 + 내용</option>
				<option value="title" ${condition eq 'title' ? 'selected' : '' }>제목</option>
				<option value="writer" ${condition eq 'writer' ? 'selected' : '' }>작성자</option>
			</select>
			<input type="text" name="keyword" placeholder="검색어..." value="${keyword }"/>
			<button type="submit">검색</button>
		</form>
		<c:if test="${not empty condition }">
			<p>
				<strong>${totalRow }</strong> 개의 자료가 검색 되었습니다.
				<a href="list">리셋</a>
			</p>
		</c:if>
	</div>
</body>
</html>





