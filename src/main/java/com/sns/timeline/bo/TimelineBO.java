package com.sns.timeline.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.comment.bo.CommentBO;
import com.sns.comment.domain.CommentView;
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
		
		for (PostEntity post : postList) {
			// post 당 새로운 cardview 생성
			CardView cardView = new CardView();
			// add post into cardview
			cardView.setPost(post);
			
			// post에 해당하는 userId
			UserEntity user = userBO.getUserById(post.getUserId());
			// add user into card view
			cardView.setUser(user);
			
			// comments
			List<CommentView> commentList = commentBO.generateCommentViewListByPostId(post.getId());
			cardView.setCommentList(commentList);
			
			// count of like
			
			// add cardview into cardviewList
			cardViewList.add(cardView);
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
