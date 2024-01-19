<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach items="${cardViewList}" var="cardView">
	<div class="card mb-5 border">
		<div class="d-flex align-items-center p-2 justify-content-between">
			<a href="/user/profile-view?userId=${cardView.user.loginId}" class="font-weight-bold">${cardView.user.loginId}</a>
			<a href=""><img src="/static/img/more-icon.png" width="20"></a>
		</div>

		<div class="image">
			<img src="${cardView.post.imagePath}" alt="img" class="w-100">
		</div>

		<div class="likes d-flex align-items-center my-2 ml-3">
			<a href="" class="like-btn d-flex align-items-center"> <img
				src="/static/img/empty-heart-icon.png" alt="like" width="17"
				height="17">
			</a> <span class="ml-2">좋아요 11개</span>
		</div>

		<div class="postContent my-1 ml-3">${cardView.post.content}</div>

		<hr>

		<div class="comment-box ml-3">
			<div class="mb-2">댓글</div>

			<%-- <c:forEach items="${comments}" var="comment">
			<c:if test="${comment.postId == post.id}"> --%>
			<div class="comment">
				<b>${comment.userId} : </b> <span>${comment.content}</span>
				<a href=""><img src="/static/img/x-icon.png" width="10" class="ml-1"></a>
			</div>
			<%-- </c:if>
			</c:forEach> --%>
		</div>

		<hr class="mb-0">

		<div class="input-group">
			<input type="text" class="border-0 form-control comment"
				placeholder="댓글 달기">
			<div class="input-group-append addCommentBox">
				<button type="button" class="btn addCommentBtn"
					data-post-id="${post.id}" data-user-id="${userId}">
					<small>게시</small>
				</button>
			</div>
		</div>
	</div>
</c:forEach>