package com.sns.timeline.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.comment.bo.CommentBO;
import com.sns.comment.domain.CommentView;
import com.sns.like.bo.LikeBO;
import com.sns.like.domain.Like;
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
	
	@Autowired
	private LikeBO likeBO;
	
	public List<CardView> generateCardViewList(Integer loginUserId) {
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
			int likeCount = likeBO.getLikeCountByPostId(post.getId());
			cardView.setLikeCount(likeCount);
			
			// 로그인된 사람이 좋아요를 했는지 여부 (!!!비로그인 경우도 고려해야 함!!!)
			
			boolean filledLike = likeBO.getLikeCountByPostIdUserId(post.getId(), loginUserId);
			cardView.setFilledLike(filledLike);
			
			// add cardview into cardviewList
			cardViewList.add(cardView);
		}

		return cardViewList;
	}
	
	public List<CardView> generateCardViewListByLoginUserIdProfileUserId(Integer loginUserId, int profileUserId) {
		List<CardView> cardViewList = new ArrayList<>();

		// user 목록
		UserEntity profileUser = userBO.getUserById(profileUserId);
		
		// 글 목록 List<PostEntity>
		List<PostEntity> postList = postBO.getPostListByUserId(profileUserId);
		
		
		for (PostEntity post : postList) {
			// post 당 새로운 cardview 생성
			CardView cardView = new CardView();
			// add post into cardview
			cardView.setPost(post);
			
			// post에 해당하는 userId
			cardView.setUser(profileUser);
			
			// comments
			List<CommentView> commentList = commentBO.generateCommentViewListByPostId(post.getId());
			cardView.setCommentList(commentList);
			
			// count of like
			int likeCount = likeBO.getLikeCountByPostId(post.getId());
			cardView.setLikeCount(likeCount);
			
			// 로그인된 사람이 좋아요를 했는지 여부 (!!!비로그인 경우도 고려해야 함!!!)
			
			if (loginUserId == null || likeBO.getLikeByPostIdUserId(post.getId(), loginUserId) == null) {
				cardView.setFilledLike(false);
			}
			else {				
				cardView.setFilledLike(true);
			}
			
			// add cardview into cardviewList
			cardViewList.add(cardView);
		}

		return cardViewList;
	}
	
	
	public List<CardView> generateCardViewList(String profileUserLoginId, Integer loginUserId, String type) {
		List<CardView> cardViewList = new ArrayList<>();

		// user 목록
		UserEntity profileUser = userBO.getUserByLoginId(profileUserLoginId);
		int profileUserId = profileUser.getId();
		
		// 글 목록 List<PostEntity>
		List<PostEntity> postList = new ArrayList<>();
		if (type.equals("posts")) {
			postList = postBO.getPostListByUserId(profileUserId);
		}
		else if (type.equals("likes")) {
			List<Like> likeList = likeBO.getLikeByUserId(profileUserId);
			
			for (Like like : likeList) {
				PostEntity post = postBO.getPostById(like.getPostId());
				postList.add(post);
			}
		}
		
		
		for (PostEntity post : postList) {
			// post 당 새로운 cardview 생성
			CardView cardView = new CardView();
			// add post into cardview
			cardView.setPost(post);
			
			// post에 해당하는 userId
			cardView.setUser(profileUser);
			
			// comments
			List<CommentView> commentList = commentBO.generateCommentViewListByPostId(post.getId());
			cardView.setCommentList(commentList);
			
			// count of like
			int likeCount = likeBO.getLikeCountByPostId(post.getId());
			cardView.setLikeCount(likeCount);
			
			// 로그인된 사람이 좋아요를 했는지 여부 (!!!비로그인 경우도 고려해야 함!!!)
			
			if (loginUserId == null || likeBO.getLikeByPostIdUserId(post.getId(), loginUserId) == null) {
				cardView.setFilledLike(false);
			}
			else {				
				cardView.setFilledLike(true);
			}
			
			// add cardview into cardviewList
			cardViewList.add(cardView);
		}
		
		return cardViewList;
	}
}
