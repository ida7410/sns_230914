package com.sns.like.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sns.like.domain.Like;

@Mapper
public interface LikeMapper {
	
	public List<Like> selectLikeList();
	
	public Like selectLikeByPostIdUserId(
			@Param("postId") int postId,
			@Param("userId") int userId);
	
//	public int selectLikeCountByPostId(int postId);
//
//	public int selectLikeCountByPostIdUserId(
//			@Param("postId") int postId,
//			@Param("userId") int userId);
	
	// likeCount query 하나로 합치기
	public int selectLikeCountByPostIdOrUserId(
			@Param("postId") int postId,
			@Param("userId") Integer userId);
	
	public void insertLike(
			@Param("postId") int postId,
			@Param("userId") int userId);
	
	public void deleteLike(
			@Param("postId") int postId,
			@Param("userId") int userId);

}
