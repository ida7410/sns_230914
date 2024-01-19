<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-5 p-0">
	<div class="profile-box d-flex mb-5">
		<div class="profile-img-box col-4 p-0">
			<img src="/static/img/man.jpg" alt="profile image" class="w-100 h-100">
		</div>
		<div class="profile-desc-box col-8 pl-3">
			<div class="d-flex align-items-center mb-3">
				<h3 class="m-0 mr-4">${user.name}</h3>
				<div class="mr-4">${user.loginId}</div>
				<c:choose>
					<c:when test="${user.id == userId}">
						<a href="/user/update-profile-view?userLoginId=${user.loginId}" id="editProfileBtn" class="btn btn-secondary profileBtn">프로필 수정</a>
					</c:when>
					<c:when test="${not empty userId}">
						<a href="#" id="followToggleBtn" class="btn btn-primary profileBtn">follow</a>
					</c:when>
				</c:choose>
			</div>
			
			<div class="follow-box d-flex text-center">
				<div class="mr-3">
					<div><b>following</b></div>
					<div>10</div>
				</div>
				<div class="mr-3">
					<div><b>followers</b></div>
					<div>15</div>
				</div>
			</div>
			
			<div class="info-box w-75 h-100"></div>
		</div>
	</div>
	
	<jsp:include page="../cardViewList/cardViewList.jsp" />
</div>
