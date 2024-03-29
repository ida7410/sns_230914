<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach items="${cardViewList}" var="card">
	<div class="card mb-5 border">
		<div class="d-flex align-items-center p-2 justify-content-between">
			<a href="/user/${card.user.loginId}/posts" class="font-weight-bold">${card.user.loginId}</a>
			
			<!-- 로그인한 사람이 한 포스트에만 ... 노출 -->
			<c:if test="${userId eq card.user.id}">
			<a href="#" class="more-btn" data-toggle="modal" data-target="#modal" data-post-id="${card.post.id}">
				<img src="/static/img/more-icon.png" width="20">
			</a>
			</c:if>
		</div>

		<div class="image">
			<img src="${card.post.imagePath}" alt="img" class="w-100">
		</div>

		<div class="likes d-flex align-items-center my-2 ml-3">
			<c:if test="${card.filledLike == true}">
			<a href="/like/${card.post.id}" class="like-btn d-flex align-items-center">
				<img src="/static/img/heart-icon.png" alt="like" width="17" height="17">
			</a>				
			</c:if>
			
			<c:if test="${card.filledLike == false}">
			<a href="/like/${card.post.id}" class="like-btn d-flex align-items-center">
				<img src="/static/img/empty-heart-icon.png" alt="like" width="17" height="17">
			</a>
			</c:if>
			<span class="ml-2">좋아요 ${card.likeCount}개</span>
		</div>

		<div class="postContent my-1 ml-3">${card.post.content}</div>

		<hr>

		<div class="comment-box ml-3">
			<div class="mb-2">댓글</div>

			<c:forEach items="${card.commentList}" var="commentView">
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
				<button type="button" class="btn add-comment-btn" data-post-id="${card.post.id}" data-user-id="${userId}">
					<small>게시</small>
				</button>
			</div>
		</div>
	</div>
</c:forEach>


<!-- Modal -->
<div class="modal fade" id="modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<%-- 
		modal-sm: 작은 modal
		modal-dialog-centered: 수직 기준 가운데
	 --%>
	<div class="modal-dialog modal-sm modal-dialog-centered">
		<div class="modal-content text-center">
			<div class="border-bottom py-3">
				<a href="#" id="del-post-btn">삭제하기</a>			
			</div>
			<div class="py-3">
				<a href="#" data-dismiss="modal">취소</a>			
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {
		
		$(".more-btn").on("click", function(e) {
			e.preventDefault();
			
			let postId = $(this).data("post-id"); // getting
			
			// 1개로 존재하는 모달 재활용을 위해 data-post-id를 심는다.
			$("#modal").data("post-id", postId); // setting
		});
		
		// modal 안에 있는 삭제하기 클릭
		$("#modal #del-post-btn").on("click", function(e) {
			e.preventDefault();
			
			let postId = $("#modal").data("post-id");
			alert(postId);
			
			$.ajax({
				type:"delete"
				,url:"/post/delete"
				,data:{"postId":postId}
				
				,success:function(data) {
					if (data.code == 200) {
						alert("포스트를 삭제했습니다.");
						location.reload();
					}
					else {
						alert(data.error_message);
					}
				}
				,error:function(request, status, error) {
					alert("포스트 삭제에 실패했습니다. 관리자에게 문의해주세요.");
				}
			});
		});

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