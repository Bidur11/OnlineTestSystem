package com.pm.onlinetest.service;

import java.util.List;

import com.pm.onlinetest.domain.FileUpload;
import com.pm.onlinetest.domain.HelpDescription;

public interface HelpDescriptionService {
	public void save(HelpDescription helpDescription);
	public HelpDescription getFileByDescriptionId(Integer descriptionId);
	public HelpDescription findByImgName(String imgName);
	public List<HelpDescription> findAllEnabled();
	public List<HelpDescription> findAllEnabledByFileId(FileUpload fileUpload);
	public void softDelete(Integer descriptionId);
	public void softDeleteChild(Integer descriptionId);
	

}
