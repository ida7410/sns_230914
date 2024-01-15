<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="col-5">
	
	<c:if test="${isLoggedIn}">
	<div id="inputArea" class="rounded bg-white">
		<input type="text" id="content" class="form-control" placeholder="내용을 입력하세요"> 
	</div>
	</c:if>
	
	<c:forEach items="${posts}" var="post">
	<div class="posts mb-5">
		<div class="head d-flex align-items-center px-2">
			<span class="font-weight-bold">${post.userId}</span>
		</div>
			
		<div class="image">
			<img src="#" alt="img" width="400" height="400">
		</div>
		<div class="likes d-flex">
			<img src="#" alt="like">
			<span class="ml-1 font-weight-bold">좋아요 11개</span>
		</div>
		<div class="postContent">
			${post.content}
		</div>
		
		<div class="comments">
			<table class="w-100">
				<tr>
					<th>hagulu</th>
					<td>분류가 잘 되었군요~</td>
				</tr>
			</table>
		</div>
	</div>
	</c:forEach>
</div>