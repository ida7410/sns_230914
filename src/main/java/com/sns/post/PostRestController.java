package com.sns.post;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.sns.post.bo.PostBO;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/post")
@RestController
public class PostRestController {
	
	@Autowired
	private PostBO postBO;
	
	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam("file") MultipartFile file,
			@RequestParam(value = "content", required = false) String content,
			HttpSession session) {
		
		Map<String, Object> result = new HashMap<>();
		// userId + loginCheck
		String userLoginId = (String)session.getAttribute("userLoginId");
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null) {
			result.put("code", 300);
			result.put("error_message", "포스트하기 위해선 로그인해야 합니다.");
		}
		
		// DB insert
		postBO.addPost(userId, userLoginId, file, content);
		
		// response
		result.put("code", 200);
		result.put("resutl", "success");
		
		return result;
		
	}
	
	@DeleteMapping("/delete")
	public Map<String, Object> delete(
			@RequestParam("postId") int postId,
			HttpSession session) {
		
		Map<String, Object> result = new HashMap<>();

		Integer userId = (Integer) session.getAttribute("userId");
		String userLoginId = (String) session.getAttribute("userLoginId");
		if (userId == null) {
			result.put("code", 300);
			result.put("error_message", "글을 삭제하려면 로그인해주세요.");
		}
		
		// DB delete
		postBO.deletePostByPostId(postId);
		
		// response
		result.put("code", 200);
		result.put("result", "success");
		
		return result;
	}
}
