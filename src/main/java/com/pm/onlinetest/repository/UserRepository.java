package com.pm.onlinetest.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.pm.onlinetest.domain.User;

@Repository
public interface UserRepository extends CrudRepository<User, Integer> {
	
	@Query("SELECT u FROM User u WHERE u.userId =:userId")
	User findByUserId(@Param("userId") Integer userId);
	
	@Query("SELECT u FROM Authority a, User u WHERE u.userId = a.userId AND a.authority =:authority AND u.enabled = true")
	List<User> findByAuthority(@Param("authority") String authority);
	
	@Query("SELECT u FROM User u WHERE u.enabled = true and username IS NOT NULL")
	List<User> findAllEnabled();
	// added code to find disabled users
	@Query("SELECT u FROM User u WHERE u.enabled = false and username IS NOT NULL")
	List<User> findAllDisabled();
	
	// added code to find disabled users
		@Query("SELECT * FROM User u WHERE username IS NOT NULL")
		List<User> findAll();
	
	@Modifying(clearAutomatically = true)
	@Transactional
	@Query("UPDATE User u SET u.enabled = false WHERE u.userId =:userId")
	void softDelete(@Param("userId") Integer userId);
	
	@Modifying(clearAutomatically = true)
	@Transactional
	@Query("UPDATE User u SET u.enabled = true WHERE u.userId =:userId")
	void softUnDelete(@Param("userId") Integer userId);
	
	@Query("SELECT u FROM User u WHERE u.username=:username AND u.enabled = true")
	User findByUsername(@Param("username") String username);
	
	@Query("SELECT u FROM User u WHERE u.username=:username AND u.enabled = true AND u.userId !=:userId")
	User findByUsernameExceptThis(@Param("username") String username, @Param("userId") Integer userId);
	
	@Query("SELECT u FROM User u WHERE u.email=:email AND u.enabled = true AND u.userId !=:userId")
	User findByEmailExceptThis(@Param("email") String email, @Param("userId") Integer userId);
	
	@Query("SELECT u FROM User u WHERE u.email=:email)")
	User isEmailExists(@Param("email") String email);
	
	@Query("SELECT u.userId FROM User u WHERE u.email=:email")
	int findByUseremailid(@Param("email") String email);
	
	@Modifying(clearAutomatically = true)
	@Transactional
	@Query("UPDATE User u SET u.password = :accessCode WHERE u.email =:email")
	void passwordUpdate(@Param("email") String email, @Param("accessCode") String accessCode);
	
	@Query("SELECT u FROM User u WHERE u.password =:userAccessCode")
	User findUserByAccessCode(@Param("userAccessCode") String userAccessCode);
}
