<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="col-5 p-0">
	
	<c:if test="${isLoggedIn}">
	<div id="inputArea" class="rounded bg-white mb-5">
		<textarea id="content" class="form-control border-0" placeholder="내용을 입력하세요"></textarea>
		<div class="d-flex justify-content-between">
			<a href=""><img src="/static/img/image.jpg" width="50"></a>
			<button type="submit" id="postBtn" class="btn btn-info p-1 px-2"><small>게시</small></button>
		</div>
	</div>
	</c:if>
	
	<c:forEach items="${posts}" var="post">
	<div class="card mb-5 border">
		<div class="d-flex align-items-center p-2 justify-content-between">
			<span class="font-weight-bold">${post.userId}</span>
			<a href=""><img src="/static/img/more-icon.png" width="20"></a>
		</div>
			
		<div class="image">
			<img src="/static/img/man.jpg" alt="img" width="420" height="420">
		</div>
		
		<div class="likes d-flex align-items-center my-2 ml-3">
			<a href="" class="d-flex align-items-center">
				<img src="/static/img/empty-heart-icon.png" alt="like" width="17" height="17">
			</a>
			<span class="ml-2">좋아요 11개</span>
		</div>
		
		<div class="postContent my-1 ml-3">
			${post.content}
		</div>
		
		<hr>
		
		<div class="comment-box ml-3">
			<div class="mb-2">댓글</div>
			<div class="comment">
				<b>hagulu : </b>
				<span>재밌었겠네</span>
				<a href=""><img src="/static/img/x-icon.png" width="10" class="ml-1"></a>
			</div>
		</div>
		
		<hr class="mb-0">
		
		<div class="input-group">
			<input type="text" class="border-0 form-control" placeholder="댓글 달기">
			<div class="input-group-append">
				<button type="button" id="addCommentBtn" class="btn">
					<small>게시</small>
				</button>
			</div>		
		</div>
	</div>
	</c:forEach>
</div>