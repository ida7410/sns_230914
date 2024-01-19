package com.sns.timeline.bo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.comment.bo.CommentBO;
import com.sns.post.bo.PostBO;
import com.sns.post.entity.PostEntity;
import com.sns.timeline.domain.CardView;
import com.sns.user.bo.UserBO;
import com.sns.user.entity.UserEntity;

@Service
public class TimelineBO {
	
	@Autowired
	private PostBO postBO;
	
	@Autowired
	private UserBO userBO;
	
	@Autowired
	private CommentBO commentBO;
	
	public List<CardView> generateCardViewList() {
		List<CardView> cardViewList = new ArrayList<>();
		
		// 글 목록 List<PostEntity>
		List<PostEntity> postList = postBO.getPostList();
		
		// user 목록
		List<UserEntity> userList = userBO.getUserList();
		
		Map<String, UserEntity> userMap = new HashMap<>();
		for (UserEntity user : userList) {
			userMap.put(user.getId() + "", user);
		}
		
		
		CardView cardView = new CardView();
		for (PostEntity post : postList) {
			cardView.setPost(post);
			cardView.setUser(userMap.get(post.getUserId() + ""));
			
			cardViewList.add(cardView);
			
			cardView = new CardView();
		}

		return cardViewList;
	}
	
	public List<CardView> generateCardViewListByUserId(String LoginId) {
		List<CardView> cardViewList = new ArrayList<>();

		// user 목록
		UserEntity user = userBO.getUserByLoginId(LoginId);
		int userId = user.getId();
		
		// 글 목록 List<PostEntity>
		List<PostEntity> postList = postBO.getPostListByUserId(userId);
		
		
		CardView cardView = new CardView();
		for (PostEntity post : postList) {
			cardView.setPost(post);
			cardView.setUser(user);
			
			cardViewList.add(cardView);
			
			cardView = new CardView();
		}

		return cardViewList;
	}
	
}
