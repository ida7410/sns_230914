package com.sns.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.post.entity.PostEntity;
import com.sns.post.mapper.PostMapper;
import com.sns.post.repository.PostRepository;

@Service
public class PostBO {
	
	@Autowired
	private PostMapper postMapper;
	
	@Autowired
	private PostRepository postRepository;
	
	public List<PostEntity> getPostList() {
		return postRepository.findAll();
	}
	
}
