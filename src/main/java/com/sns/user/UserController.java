package com.sns.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sns.timeline.bo.TimelineBO;
import com.sns.timeline.domain.CardView;
import com.sns.user.bo.UserBO;
import com.sns.user.entity.UserEntity;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/user")
@Controller
public class UserController {
	
	@Autowired
	private UserBO userBO;
	
	@Autowired TimelineBO timelineBO;
	
	// 회원가입 화면
	@GetMapping("/sign-up-view")
	public String signUpView(Model model) {
		model.addAttribute("viewName", "user/signUp");
		return "template/layout";
	}
	
	// 로그인 화면
	@GetMapping("/sign-in-view")
	public String signInView(Model model) {
		model.addAttribute("viewName", "user/signIn");
		return "template/layout";
	}
	
	// 로그아웃
	@RequestMapping("/sign-out")
	public String signOut(HttpSession session) {
		session.removeAttribute("userId");
		session.removeAttribute("userLoginId");
		session.removeAttribute("userName");
		session.removeAttribute("userProfileImagePath");
		
		return "redirect:/timeline/list-view";
	}
	
	@RequestMapping("/profile-view")
	public String profileView(
			@RequestParam("userId") String userId,
			HttpSession session,
			Model model) {
		
		// DB select
		UserEntity user = userBO.getUserByLoginId(userId);
		
		// login
		Integer loginUserId = (Integer)session.getAttribute("userId");
		
		// select timeline
		List<CardView> cardViewList = timelineBO.generateCardViewListByLoginUserIdProfileUserId(loginUserId, user.getId());
		
		model.addAttribute("viewName", "user/profile");
		model.addAttribute("user", user);
		model.addAttribute("cardViewList", cardViewList);
		return "template/layout";
	}
	
	@GetMapping("/update-profile-view")
	public String updateProfileView(
			@RequestParam("userLoginId") String userLoginId,
			Model model) {
		
		
		UserEntity user = userBO.getUserByLoginId(userLoginId);
		
		model.addAttribute("viewName", "user/updateProfile");
		model.addAttribute("user", user);
		return "template/layout";
	}
	
}
