package com.sns.like.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.like.domain.Like;
import com.sns.like.mapper.LikeMapper;

@Service
public class LikeBO {
	
	@Autowired
	private LikeMapper likeMapper;
	
	public void likeToggle(int postId, int userId) {
		Like like = likeMapper.selectLikeByPostIdUserId(postId, userId);
		int count = likeMapper.selectLikeCountByPostIdUserId(postId, userId);
		
		if (count == 0) {
			likeMapper.insertLike(postId, userId);
		}
		else {
			likeMapper.deleteLike(postId, userId);
		}
	}
	
	public int getLikeCountByPostId(int postId) {
		return likeMapper.selectLikeCountByPostId(postId);
	}
	
	public Like getLikeByPostIdUserId(int postId, int userId) {
		return likeMapper.selectLikeByPostIdUserId(postId, userId);
	}
	
}
