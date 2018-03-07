package com.pm.onlinetest.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import com.pm.onlinetest.domain.FileUpload;
import com.pm.onlinetest.domain.HelpDescription;

@Repository
public interface HelpDescriptionRepository extends CrudRepository<HelpDescription, Integer> {
	
	@Query("SELECT d FROM HelpDescription d WHERE d.descriptionId =:descriptionId")
	HelpDescription findByDescriptionId(@Param("descriptionId") Integer descriptionId);
	
	HelpDescription findByImgName(String imgName);
	
	@Modifying(clearAutomatically = true)
	@Transactional
	@Query("UPDATE HelpDescription d SET d.enabled = false WHERE d.descriptionId =:descriptionId")
	void softDelete(@Param("descriptionId") Integer descriptionId);
	
	
	@Query("FROM HelpDescription d WHERE d.enabled = true")
	public List<HelpDescription> findAllEnabled();
	
	@Query("SELECT sc FROM HelpDescription sc WHERE sc.fileUpload =:fileUpload and sc.enabled = true")
	public List<HelpDescription> findAllEnabledByFileId(@Param("fileUpload") FileUpload fileUpload);
	
	
	@Modifying(clearAutomatically = true)
	@Transactional
	@Query("UPDATE HelpDescription d SET d.enabled = false WHERE d.fileUpload.fileId =:fileId")
	public void softDeleteChild(@Param("fileId") int fileId);
	

}
