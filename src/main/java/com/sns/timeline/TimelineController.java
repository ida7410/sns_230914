package com.sns.timeline;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sns.timeline.bo.TimelineBO;
import com.sns.timeline.domain.CardView;

@RequestMapping("/timeline")
@Controller
public class TimelineController {
	
	@Autowired
	private TimelineBO timelineBO;
	
	@GetMapping("/list-view")
	public String listView (Model model) {
		
		// 글 목록 조회
//		List<PostEntity> posts = postBO.getPostList();
		
		// 댓글 가져오기
//		List<Comment> comments = commentBO.getCommentList();
//		List<List<Comment>> commentsList = new ArrayList<>();
//		for (int i = 0; i < posts.size(); i++) {
//			comments = commentBO.getCommentListByPostId(posts.get(i).getId());
//			commentsList.add(comments);
//		}
		
		List<CardView> cardViewList = timelineBO.generateCardViewList();
		
		model.addAttribute("viewName", "timeline/timeline");
//		model.addAttribute("posts", posts);
//		model.addAttribute("comments", comments);
		model.addAttribute("cardViewList", cardViewList);
		
		return "template/layout";
	}
	
}
