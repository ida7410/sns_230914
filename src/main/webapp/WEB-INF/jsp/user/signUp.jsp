<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="d-flex justify-content-center">
	<div class="sign-up-box p-4">
		<h1 class="font-weight-bold mb-3">회원가입</h1>
		<form id="signUpForm" method="post" action="/user/sign-up">
			<span class="sign-up-subject">ID</span>
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
			
			<span class="sign-up-subject mt-4">Password</span>
			<div class="mb-2">
				<input type="password" id="password" name="password" class="form-control col-8" placeholder="비밀번호를 입력하세요">
			</div>

			<span class="sign-up-subject">Confirm password</span>
			<div class="mb-2">
				<input type="password" id="confirmPassword" name="confirmPassword" class="form-control col-8" placeholder="비밀번호를 입력하세요">
			</div>

			<span class="sign-up-subject">Name</span>
			<div class="mb-2">
				<input type="text" id="name" name="name" class="form-control col-6" placeholder="이름을 입력하세요">
			</div>

			<span class="sign-up-subject">이메일</span>
			<div class="mb-2">
				<input type="text" id="email" name="email" class="form-control col-12" placeholder="이메일을 입력하세요">
			</div>
			
			<button type="submit" id="joinBtn" class="btn btn-primary float-right mt-4">회원가입</button>
		</form>
		
	</div>
</div>


<script>
$(document).ready(function() {
	
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
	$("#signUpForm").on("submit", function(e) {
		e.preventDefault(); // submit 기능 막음

		// validation check
		let loginId = $("#loginId").val().trim();
		let password = $("#password").val().trim();
		let confirmPassword = $("#confirmPassword").val().trim();
		let name = $("#name").val().trim();
		let email = $("#email").val().trim();
		
		if (!loginId) {
			alert("아이디를 입력하세요.");
			return false;
		}
		if (!password || !confirmPassword) {
			alert("비밀번호를 입력하세요.");
			return false;
		}
		if (password != confirmPassword) {
			alert("비밀번호가 일치하지 않습니다.");
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
		
		
		// 1) 서버 전송: submit을 js에서 동작
		// $(this)[0].submit(); // 화면 이동
		
		// 2) AJAX: 화면 이동 x(call back 함수에서), response = json
		let url = $(this).attr("action");
		let params = $(this).serialize(); // form tag에 있는 name attri의 val로 parameter로 구성
		
		$.post(url, params) // requst
		.done(function(data) {
			if (data.code == 200) {
				alert("가입을 환영합니다. 로그인 해주세요.");
				location.href = "/user/sign-in-view";
			}
			else {
				// logic failure
				alert(data.error_message);
			}
		});
	});
	
});
</script>