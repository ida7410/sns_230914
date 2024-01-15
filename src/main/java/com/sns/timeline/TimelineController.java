package com.sns.timeline;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sns.post.bo.PostBO;
import com.sns.post.domain.Post;

@RequestMapping("/timeline")
@Controller
public class TimelineController {
	
	@Autowired
	private PostBO postBO;
	
	@GetMapping("/list-view")
	public String listView (Model model) {
		
		List<Post> posts = postBO.getPostList();
		
		model.addAttribute("viewName", "timeline/timeline");
		model.addAttribute("isLoggedIn", true);
		model.addAttribute("posts", posts);
		return "template/layout";
	}
	
}