package com.sns.like.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.like.domain.Like;
import com.sns.like.mapper.LikeMapper;

@Service
public class LikeBO {
	
	@Autowired
	private LikeMapper likeMapper;
	
	public void likeToggle(int postId, int userId) {
		int count = likeMapper.selectLikeCountByPostIdOrUserId(postId, userId);
		
		if (count == 0) {
			likeMapper.insertLike(postId, userId);
		}
		else {
			likeMapper.deleteLike(postId, userId);
		}
	}

	public Like getLikeByPostIdUserId(int postId, int userId) {
		return likeMapper.selectLikeByPostIdUserId(postId, userId);
	}
	
	public List<Like> getLikeByUserId(int userId) {
		return likeMapper.selectLikeListByUserId(userId);
	}
	
	public int getLikeCountByPostId(int postId) {
		return likeMapper.selectLikeCountByPostIdOrUserId(postId, null);
	}
	
	public boolean getLikeCountByPostIdUserId(int postId, Integer userId) {
		if(userId == null) {
			return false;
		}
		
		int likeCount = likeMapper.selectLikeCountByPostIdOrUserId(postId, userId);
		return likeCount > 0;
	}

	public void deleteLikeByPostId(int postId) {
		likeMapper.deleteLike(postId, null);
	}
	
}
