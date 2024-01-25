package com.sns.comment.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.comment.domain.Comment;
import com.sns.comment.domain.CommentView;
import com.sns.comment.mapper.CommentMapper;
import com.sns.user.bo.UserBO;
import com.sns.user.entity.UserEntity;

@Service
public class CommentBO {
	
	@Autowired
	private CommentMapper commentMapper;
	
	@Autowired
	private UserBO userBO;

	public List<CommentView> generateCommentViewListByPostId(int postId) {
		// comment view list
		List<CommentView> commentViewList = new ArrayList<>();
		
		// 글에 해당하는 댓글 목록 가져오기 = List<Comment>
		List<Comment> commentList = commentMapper.selectCommentListByPostId(postId);
		
		// for loop comment -> CommentView => put in the list
		for (Comment comment : commentList) {
			CommentView commentView = new CommentView();
			commentView.setComment(comment);
			
			UserEntity user = userBO.getUserById(comment.getUserId());
			commentView.setUser(user);
			
			commentViewList.add(commentView);
		}
		
		// return comment view list
		return commentViewList;
	}
	
	public List<Comment> getCommentList() {
		return commentMapper.selectCommentList();
	}
	
	public List<Comment> getCommentListByPostId(int postId) {
		return commentMapper.selectCommentListByPostId(postId);
	}
	
	public void addComment(int userId, int postId, String content) {
		commentMapper.insertComment(userId, postId, content);
	}
	
	public void deleteCommentById(int id) {
		commentMapper.deleteCommentById(id);
	}
	
	public void deleteCommentByPostId(int postId) {
		commentMapper.deleteCommentByPostId(postId);
	}
	
}
