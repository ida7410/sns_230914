<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="d-flex justify-content-center">
	<div class="update-profile-box p-4">
		<form id="updateProfileForm" method="post" action="/user/sign-up">
			<span class="update-profile-subject">프로필 사진 업로드</span>
			<div class="mb-2">
				<input type="file" id="file" class="" accept=".jpg, .png, .jpeg, .gif">
			</div>
			
			<span class="update-profile-subject">ID</span>
			<div class="d-flex">
				<input type="text" id="loginId" name="loginId" class="form-control col-6" placeholder="ID를 입력해주세요">
				<button type="button" id="checkDuplicatedIdBtn" class="btn btn-info ml-2">중복확인</button>
			</div>
			
			<%-- 아이디 체크 결과 --%>
			<div class="mb-2">
				<div id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
				<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
				<div id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
			</div>
			
			<span class="update-profile-subject">Name</span>
			<div class="mb-2">
				<input type="text" id="name" name="name" class="form-control col-6" placeholder="이름을 입력하세요">
			</div>

			<span class="update-profile-subject">이메일</span>
			<div class="mb-2">
				<input type="text" id="email" name="email" class="form-control col-12" placeholder="이메일을 입력하세요">
			</div>
			
			<button type="submit" id="saveBtn" class="btn btn-primary float-right mt-4">저장</button>
		</form>
		
	</div>
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
		});

		// 아이디 중복 확인
		$("#checkDuplicatedIdBtn").on("click", function() {
			// 경고 문구 초기화
			$("#idCheckLength").addClass("d-none");
			$("#idCheckDuplicated").addClass("d-none");
			$("#idCheckOk").addClass("d-none");
			
			let loginId = $("#loginId").val().trim();
			
			if (loginId.length < 4) {
				$("#idCheckLength").removeClass("d-none");
				return;
			}
			
			// AJAX - 중복 확인
			$.get("/user/is-duplicated-id", {"loginId":loginId}) // request
			.done(function(data) { //response
				if (data.code == 200) {
					if (data.is_duplicated_id) { // 중복
						$("#idCheckDuplicated").removeClass("d-none");
					}
					else { // 사용 가능
						$("#idCheckOk").removeClass("d-none");
					}
				}
				else {
					alert(data.error_message);
				}
			}); 
			
			
		});
		
		// 회원가입을 눌렀을 때
		$("#updateProfileForm").on("submit", function(e) {
			e.preventDefault(); // submit 기능 막음

			// validation check
			let loginId = $("#loginId").val().trim();
			let name = $("#name").val().trim();
			let email = $("#email").val().trim();
			
			if (!loginId) {
				alert("아이디를 입력하세요.");
				return false;
			}
			if (!name) {
				alert("이름을 입력하세요.");
				return false;
			}
			if (!email) {
				alert("이메일을 입력하세요.");
				return false;
			}
			// 중복 확인 후 사용 가능한 아이디인지 확인
			// => idCheckOk class x have d-none
			if ($("#idCheckOk").hasClass("d-none")){
				alert("아이디 중복 확인을 다시 해주세요.");
				return false;
			}
			
			
			// AJAX
			let url = $(this).attr("action");
			let params = $(this).serialize(); // form tag에 있는 name attri의 val로 parameter로 구성
			
			$.post(url, params) // requst
			.done(function(data) {
				if (data.code == 200) {
					alert("프로필 수정을 완료했습니다.");
					location.href = "/user/profile-view?userLoginId=" + ${user.loginId};
				}
				else {
					// logic failure
					alert(data.error_message);
				}
			});
		});
		
	});
</script>