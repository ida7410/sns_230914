<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="d-flex justify-content-between align-items-center h-100 p-4">
	<%--logo --%>
	<div>
		<h3 class="font-weight-bold">Marondalgram</h3>
	</div>
	
	<%-- login info --%>
	<div>
		<span class="mr-2"><b>${userName}님 안녕하세요</b></span>
		<a href="/user/sign-out"><u>로그아웃</u></a>
	</div>
</div>