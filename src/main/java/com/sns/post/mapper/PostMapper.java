package com.sns.post.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface PostMapper {
	
	public void insertPost(
			@Param("userId") int userId,
			@Param("imagePath") String imagePath,
			@Param("content") String content);
	
}
