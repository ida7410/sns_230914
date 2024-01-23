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
			<c:if test="${cardView.filledLike == true}">
			<a href="/like/${cardView.post.id}" class="like-btn d-flex align-items-center">
				<img src="/static/img/heart-icon.png" alt="like" width="17" height="17">
			</a>				
			</c:if>
			
			<c:if test="${cardView.filledLike == false}">
			<a href="/like/${cardView.post.id}" class="like-btn d-flex align-items-center">
				<img src="/static/img/empty-heart-icon.png" alt="like" width="17" height="17">
			</a>
			</c:if>
			<span class="ml-2">좋아요 ${cardView.likeCount}개</span>
		</div>

		<div class="postContent my-1 ml-3">${cardView.post.content}</div>

		<hr>

		<div class="comment-box ml-3">
			<div class="mb-2">댓글</div>

			<c:forEach items="${cardView.commentList}" var="commentView">
			<div class="comment">
				<b>${commentView.user.loginId} : </b> <span>${commentView.comment.content}</span>
				<c:if test="${commentView.user.id == userId}">
				<a href="/comment/delete" class="comment-del-btn" data-comment-id="${commentView.comment.id}">
					<img src="/static/img/x-icon.png" width="10" class="ml-1">
				</a>
				</c:if>
			</div>
			</c:forEach>
		</div>

		<hr class="mb-0">

		<div class="input-group">
			<input type="text" class="border-0 form-control content"
				placeholder="댓글 달기">
			<div class="input-group-append add-comment-box">
				<button type="button" class="btn add-comment-btn" data-post-id="${cardView.post.id}" data-user-id="${userId}">
					<small>게시</small>
				</button>
			</div>
		</div>
	</div>
</c:forEach>


<script>
	$(document).ready(function() {

		$(".add-comment-btn").on("click", function() {
			let userId = $(this).data("user-id");
			let postId = $(this).data("post-id");
			let content = $(this).parent().prev().val();
			// let content = $(this).parent().siblings("input").val();
			
			if (!userId) {
				alert("댓글을 달기 위해선 로그인해야 합니다.");
				location.href = "/user/sign-in-view";
				return;
			}
			if (!content) {
				alert("댓글을 입력해주세요.");
				return;
			}
			
			$.ajax({
				type:"post"
				, url:"/comment/create"
				, data:{"userId":userId, "postId":postId, "content":content}
				
				, success:function(data) {
					if (data.code == 200) {
						alert("성공");
						location.reload();
					}
					else {
						alert(data.error_message);
					}
				}
				, error:function(request, status, error) {
					alert("포스트에 실패했습니다. 관리자에게 문의해주세요.");
				}
			});
		});
		
		$(".comment-del-btn").on("click", function(e) {
			e.preventDefault();
			
			let commentId = $(this).data("comment-id");
			let url = $(this).attr("href");
			
			$.ajax({
				type:"delete"
				,url:url
				,data:{"commentId":commentId}
				
				,success:function(data) {
					if (data.code == 200) {
						alert("댓글을 삭제했습니다.");
						location.reload();
					}
					else {
						alert(error_message);
					}
				}
				,error:function(request, status, error) {
					alert("댓글 삭제에 실패했습니다. 관리자에게 문의해주세요.");
				}
			});
		});
		
		$(".like-btn").on("click", function(e) {
			e.preventDefault();
			let url = $(this).attr("href");
			
			$.ajax({
				url:url
				
				,success:function(data) {
					if (data.code == 200) {
						location.reload();
					}
					else {
						alert(data.error_message);
						if (data.code == 300) {
							location.href = "/user/sign-in-view";
						}
					}
				}
				,error:function(request, status, error) {
					alert("좋아요에 실패했습니다. 관리자에게 문의해주세요.");
				}
			});
		});
	});
</script>