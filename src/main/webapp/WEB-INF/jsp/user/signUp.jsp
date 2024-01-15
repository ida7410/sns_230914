<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="d-flex justify-content-center">
	<div class="sign-up-box p-4">
		<h1 class="font-weight-bold mb-3">회원가입</h1>
		<form id="signUpForm" method="post" action="/user/sign-up">
			<span class="sign-up-subject">ID</span>
			<div class="d-flex">
				<input type="text" id="loginId" name="loginId" class="form-control col-6" placeholder="ID를 입력해주세요">
				<button type="button" id="loginIdCheckBtn" class="btn btn-info ml-2">중복확인</button>
			</div>
			
			<%-- 아이디 체크 결과 --%>
			<div class="mb-2">
				<div id="idCheckLength" class="small text-danger d-none">ID를 4자 이상 입력해주세요.</div>
				<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
				<div id="idCheckOk" class="small text-success">사용 가능한 ID 입니다.</div>
			</div>
			
			<span class="sign-up-subject mt-4">Password</span>
			<div class="mb-2">
				<input type="password" name="password" class="form-control col-8" placeholder="비밀번호를 입력하세요">
			</div>

			<span class="sign-up-subject">Confirm password</span>
			<div class="mb-2">
				<input type="password" name="confirmPassword" class="form-control col-8" placeholder="비밀번호를 입력하세요">
			</div>

			<span class="sign-up-subject">Name</span>
			<div class="mb-2">
				<input type="text" name="name" class="form-control col-6" placeholder="이름을 입력하세요">
			</div>

			<span class="sign-up-subject">이메일</span>
			<div class="mb-2">
				<input type="text" name="email" class="form-control col-12" placeholder="이메일을 입력하세요">
			</div>
			
			<button type="submit" id="joinBtn" class="btn btn-primary float-right mt-4">회원가입</button>
		</form>
		
	</div>
</div>