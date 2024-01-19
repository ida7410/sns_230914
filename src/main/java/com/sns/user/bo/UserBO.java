package com.sns.user.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.user.entity.UserEntity;
import com.sns.user.repository.UserRepository;

@Service
public class UserBO {
	
	@Autowired
	private UserRepository userRepository;
	
	public List<UserEntity> getUserList() {
		return userRepository.findAll();
	}
	
	/**
	 * Get UserEntity using loginId
	 * @param loginId
	 * @return UesrEntity or null
	 */
	public UserEntity getUserByLoginId(String loginId) {
		return userRepository.findByLoginId(loginId);
	}
	

	public UserEntity getUserByLoginIdPassword(String loginId, String password) {
		return userRepository.findByLoginIdAndPassword(loginId, password);
	}
	
	/**
	 * Add user
	 * @param loginId
	 * @param password
	 * @param name
	 * @param email
	 * @return Integer id
	 */
	public Integer addUser(String loginId, String password, String name, String email) {
		UserEntity userEntity = userRepository.save(
					UserEntity.builder()
						.loginId(loginId)
						.password(password)
						.name(name)
						.email(email)
						.build()
				);
		
		return userEntity == null ? null : userEntity.getId();
	}
	
}
