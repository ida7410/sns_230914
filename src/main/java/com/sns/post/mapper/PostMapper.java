package com.sns.post.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sns.post.domain.Post;

@Mapper
public interface PostMapper {
	
	public List<Post> selectPostList();
	
}
