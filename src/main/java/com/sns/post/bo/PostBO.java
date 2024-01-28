package com.sns.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sns.comment.bo.CommentBO;
import com.sns.common.FileManagerService;
import com.sns.like.bo.LikeBO;
import com.sns.post.entity.PostEntity;
import com.sns.post.mapper.PostMapper;
import com.sns.post.repository.PostRepository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PostBO {
	
	@Autowired
	private PostRepository postRepository;
	
	@Autowired
	private PostMapper postMapper;
	
	@Autowired
	private CommentBO commentBO;
	
	@Autowired
	private LikeBO likeBO;
	
	@Autowired
	private FileManagerService fileManagerService;
	
	public PostEntity getPostById(int id) {
		return postRepository.findById(id).orElse(null);
	}
	
	public List<PostEntity> getPostList() {
		return postRepository.findAllByOrderByIdDesc();
	}
	
	public List<PostEntity> getPostListByUserId(int userId) {
		return postRepository.findAllByUserIdOrderByIdDesc(userId);
	}
	
	public void addPost(int userId, String userLoginId, MultipartFile file, String content) {
		String imagePath = null;
		
		// upload image if there is
		if (file != null) {
			imagePath = fileManagerService.saveFile(userLoginId, file);
		}
		
		postMapper.insertPost(userId, content, imagePath);
	}
	
	public void deletePostByPostId(int postId) {
		// post 존재 확인
		PostEntity post = postRepository.findById(postId).orElse(null);
		if (post == null) {
			log.info("[deletePost] post is null. postId:{}", postId);
			return;
		}

		// post 삭제
		postRepository.deleteById(postId);
		fileManagerService.deleteFile(post.getImagePath());
		
		// 댓글들 삭제
		commentBO.deleteCommentByPostId(postId);
		
		// 좋아요 삭제
		likeBO.deleteLikeByPostId(postId);
		
	}
}
