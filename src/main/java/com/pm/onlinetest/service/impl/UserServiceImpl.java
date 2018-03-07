package com.pm.onlinetest.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pm.onlinetest.domain.Authority;
import com.pm.onlinetest.domain.User;
import com.pm.onlinetest.repository.UserRepository;
import com.pm.onlinetest.repository.AuthorityRepository;
import com.pm.onlinetest.service.UserService;

@Service
@Transactional
public class UserServiceImpl implements UserService {
	@Autowired
	private UserRepository userRepository;
	@Autowired
	private AuthorityRepository authorityRepository;

	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void save(User user) {

		PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String encodedPassword = passwordEncoder.encode(user.getPassword());
		String role = user.getAuthorities().get(0).getAuthority();
		user.setAuthorities(null);
		user.setPassword(encodedPassword);
		user.setEnabled(true);
		userRepository.save(user);
		Authority authority = new Authority();
		authority.setUserId(user.getUserId());
		authority.setAuthority(role);
		authorityRepository.save(authority);

	}

	@Override
	public List<User> findAllEnabled() {
		List<User> user1 = new ArrayList();
		List<User> users = userRepository.findAllEnabled();
		for (User user : users) {
			if (user.getAuthorities().size() != 0) {
				user1.add(user);
			}

		}
		return user1;

	}

	@Override
	public List<User> findAllDisabled() {
		// TODO Auto-generated method stub

		List<User> user1 = new ArrayList();
		List<User> users = userRepository.findAllDisabled();
		;
		for (User user : users) {
			if (user.getAuthorities().size() != 0) {
				user1.add(user);
			}

		}
		return user1;
	}

	@Override
	public List<User> findAll() {
		// TODO Auto-generated method stub
		List<User> user1 = new ArrayList();
		List<User> users = userRepository.findAll();
		for (User user : users) {
			if (user.getAuthorities().size() != 0) {
				user1.add(user);
			}

		}

		return user1;
	}

	@Override
	public User findByUsername(String username) {
		// TODO Auto-generated method stub
		return userRepository.findByUsername(username);
	}

	@Override
	public User findByUserId(Integer userId) {
		// TODO Auto-generated method stub
		return userRepository.findByUserId(userId);
	}

	@Override
	public void delete(User user) {
		// TODO Auto-generated method stub
		userRepository.delete(user);
	}

	@Override
	public List<User> findByAuthority(String authority) {
		// TODO Auto-generated method stub
		return userRepository.findByAuthority(authority);
	}

	@Override
	public void softDelete(Integer userId) {
		// TODO Auto-generated method stub
		userRepository.softDelete(userId);
	}
	
	@Override
	public void softUnDelete(Integer userId) {
		// TODO Auto-generated method stub
		userRepository.softUnDelete(userId);
	}

	@Override
	public User findByUsernameExceptThis(String username, Integer userId) {
		return userRepository.findByUsernameExceptThis(username, userId);
	}
	
	@Override
	public User findByEmailExceptThis(String email, Integer userId) {
		return userRepository.findByEmailExceptThis(email, userId);
	}

	public void saveProfile(User user) {
		
		PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String encodedPassword = passwordEncoder.encode(user.getPassword());
		user.setPassword(encodedPassword);
		user.setEnabled(true);
		userRepository.save(user);
	}

	@Override
	public boolean emailExists(String email) {
		// TODO Auto-generated method stub
		if (userRepository.isEmailExists(email) != null) {
			return true;
		}
		return false;
	}

	@Override
	public int findByUseremail(String email) {
		// TODO Auto-generated method stub
		return userRepository.findByUseremailid(email);

	}

	@Override
	public void setAccessCodeInPasswordField(String email, String accessCode) {
		// TODO Auto-generated method stub
		userRepository.passwordUpdate(email, accessCode);

	}

	@Override
	public User findUserByAccessCode(String accessCode) {
		// TODO Auto-generated method stub
		return userRepository.findUserByAccessCode(accessCode);

	}
	
	@Override
	public void updateProfile(User user) {
		userRepository.save(user);
	}

}
