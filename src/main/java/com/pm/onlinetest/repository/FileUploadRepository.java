package com.pm.onlinetest.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.pm.onlinetest.domain.FileUpload;

@Repository
public interface FileUploadRepository extends CrudRepository<FileUpload, Integer>  {
	
	@Query("SELECT f FROM FileUpload f WHERE f.fileId =:fileId")
	FileUpload findByFileUploadId(@Param("fileId") Integer fileId);
	
	FileUpload findByHelpLink(String helpLink);
	
	@Modifying(clearAutomatically = true)
	@Transactional
	@Query("UPDATE FileUpload d SET d.enabled = false WHERE d.fileId =:fileId")
	void softDelete(@Param("fileId") Integer fileId);
	
	/**/
	
	@Query("FROM FileUpload c WHERE c.enabled = true")
	public List<FileUpload> findAllEnabled();
}
