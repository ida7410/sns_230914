<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-5 p-0">
	
	<c:if test="${not empty userId}">
	<div id="inputArea" class="rounded bg-white mb-5">
		<textarea id="content" class="form-control border-0" placeholder="내용을 입력하세요"></textarea>
		<div class="d-flex justify-content-between">
			<div class="file-upload d-flex">
				<%-- file 태그를 숨겨두고 이미지를 클릭하면 file tag를 클릭한 것과 같은 효과 --%>
				<input type="file" id="file" accept=".jpg, .jpeg, .gif, .png" class="d-none">
				
				<%-- 이미지에 마우스를 올리면 마우스 커서가 변하도록 적용 --%>
				<a href="" id="fileUploadBtn"><img src="/static/img/image.jpg" width="50"></a>
				
				<%-- 업로드 된 임시 이미지 파일 이름이 나타나는 곳 --%>
				<div id="fileName" class="ml-2"></div>
			</div>
			
			<button type="button" id="writeBtn" class="btn btn-info p-1 px-2"><small>게시</small></button>
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
			<img src="${post.imagePath}" alt="img" class="w-100">
		</div>
		
		<div class="likes d-flex align-items-center my-2 ml-3">
			<a href="" class="like-btn d-flex align-items-center">
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
			<input type="text" class="border-0 form-control comment" placeholder="댓글 달기">
			<div class="input-group-append addCommentBox">
				<button type="button" class="btn addCommentBtn" value="${post.id}">
					<small>게시</small>
				</button>
			</div>		
		</div>
	</div>
	</c:forEach>
</div>


<script>
	$(document).ready(function() {
		$("#fileUploadBtn").on("click", function(e) {
			e.preventDefault(); // a tag의 기본 동작(스크롤 위로 올라감) 멈추기
			$("#file").click(); // input file을 클릭한 효과
		})
		
		$("#file").on("change", function(e) {
			// 취소를 누를 때 비어 있는 경우, 전에 선택한 파일도 선택 취소
			let file = e.target.files[0];
			if (file == null) {
				$(this).val(""); // file in file tag 제거
				$("#fileName").text(""); // 파일명 비우기
				return;
			}
			
			let fileName = e.target.files[0].name;
			
			// validation check
			let extension = fileName.split(".").pop().toLowerCase();
			
			if (extension != "jpg" && extension != "jpeg" && extension != "png" && extension != "gif") {
				alert("이미지 파일만 업로드 할 수 있습니다.");
				$(this).val(""); // file in file tag 제거
				$("#fileName").text(""); // 파일명 비우기
				return;
			}
			
			$("#fileName").text(fileName);
		})
		
		$("#writeBtn").on("click", function() {
			let fileName = $("#file").val();
			let content = $("#content").val();
			
			if (!fileName) {
				alert("이미지를 선택해주세요.");
				return;
			}
			
			let extension = fileName.split(".").pop().toLowerCase();
			if (extension != "jpg" && extension != "jpeg" && extension != "png" && extension != "gif") {
				alert("이미지 파일만 업로드 할 수 있습니다.");
				$(this).val(""); // file in file tag 제거
				$("#fileName").text(""); // 파일명 비우기
				return;
			}
			
			let formData = new FormData();
			formData.append("file", $("#file")[0].files[0]);
			formData.append("content", content);
			
			$.ajax({
				type:"post"
				, url:"/post/create"
				, data:formData
				, enctype:"multipart/form-data"
				, processData:false
				, contentType:false
				
				, success:function(data) {
					if (data.code == 200) {
						alert("포스트를 올렸습니다.");
						location.href="/timeline/list-view"
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
		
		$(".addCommentBtn").on("click", function() {
			let content = $(this).parent().prev().val();
			let postId = $(this).val();
			
			if (!content) {
				alert("댓글을 입력해주세요.");
				return;
			}
			
			$.ajax({
				type:"post"
				, url:"/comment/create"
				, data:{"content":content, "postId":postId}
				
				, success:function(data) {
					if (data.code == 200) {
						alert("성공");
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
	});
</script>