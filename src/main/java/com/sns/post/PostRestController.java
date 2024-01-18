package com.sns.post;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
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
			@RequestParam(value = "content") String content,
			HttpSession session) {
		
		// userId + loginCheck
		int userId = (int)session.getAttribute("userId");
		String id = (String)session.getAttribute("userLoginId");
		
		// DB insert
		
		// response
		Map<String, Object> result = new HashMap<>();
		result.put("code", 200);
		result.put("resutl", "success");
		
		return result;
		
	}

}
