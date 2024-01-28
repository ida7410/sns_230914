package com.sns.comment;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sns.comment.bo.CommentBO;

@RequestMapping("/comment")
@RestController
public class CommentRestController {
	
	@Autowired
	private CommentBO commentBO;
	
	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam("userId") int userId,
			@RequestParam("postId") int postId,
			@RequestParam("content") String content) {
		
		Map<String, Object> result = new HashMap<>();
		
		// DB insert
		commentBO.addComment(userId, postId, content);
		
		result.put("code", 200);
		result.put("result", "success");
		
		return result;
	}
	
	@DeleteMapping("/delete")
	public Map<String, Object> delete(
			@RequestParam("commentId") int id) {
		
		Map<String, Object> result = new HashMap<>();
		
		// DB delete
		commentBO.deleteCommentById(id);
		
		result.put("code", 200);
		result.put("result", "success");
		
		return result; 
	}
	
}
