package com.sns.like;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sns.like.bo.LikeBO;

import jakarta.servlet.http.HttpSession;

@RestController
public class LikeRestController {
	
	@Autowired
	private LikeBO likeBO;
	
	// original method
	// GET: /like?postId=13  =  @RequestParam("postId")의 방식
	
	// Restful API
	// GET: /like/13  =  @PathVariable
	@RequestMapping("/like/{postId}")
	public Map<String, Object> likeToggle(
			@PathVariable("postId") int postId,
			HttpSession session) {
		
		Map<String, Object> result = new HashMap<>();
		// check login
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null) {
			result.put("code", 300);
			result.put("error_message", "좋아요를 누르기 위해선 로그인해야 합니다.");
		}
		
		// db select like Toggle
		likeBO.likeToggle(postId, userId);
		
		// response
		result.put("code", 200);
		result.put("result", "success");
		
		return result;
	}
	
}
