package com.sns.post.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.sns.post.entity.PostEntity;

@Repository
public interface PostRepository extends JpaRepository<PostEntity, Integer> {
	
	public List<PostEntity> findAllByOrderByIdDesc();
	public List<PostEntity> findAllByUserIdOrderByIdDesc(int userId);
	
}
