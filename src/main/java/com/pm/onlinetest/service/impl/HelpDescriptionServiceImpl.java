package com.pm.onlinetest.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pm.onlinetest.domain.FileUpload;
import com.pm.onlinetest.domain.HelpDescription;
import com.pm.onlinetest.repository.HelpDescriptionRepository;
import com.pm.onlinetest.service.HelpDescriptionService;

@Service
public class HelpDescriptionServiceImpl implements HelpDescriptionService {
	
	@Autowired
	HelpDescriptionRepository helpDescriptionRepository;

	@Override
	public void save(HelpDescription helpDescription) {
		helpDescriptionRepository.save(helpDescription);
	}

	@Override
	public HelpDescription getFileByDescriptionId(Integer descriptionId) {
		return this.helpDescriptionRepository.findOne(descriptionId);
	}

	@Override
	public HelpDescription findByImgName(String imgName) {
		return this.helpDescriptionRepository.findByImgName(imgName) ;
	}

	@Override
	public List<HelpDescription> findAllEnabled() {
		List<HelpDescription> helps = helpDescriptionRepository.findAllEnabled();
		return helps;
	}

	@Override
	public void softDelete(Integer descriptionId) {
		helpDescriptionRepository.softDelete(descriptionId);
		
	}

	@Override
	public List<HelpDescription> findAllEnabledByFileId(FileUpload fileUpload) {
		List<HelpDescription> helps = helpDescriptionRepository.findAllEnabledByFileId(fileUpload);
		return helps;
	}

	@Override
	public void softDeleteChild(Integer fileId) {
		helpDescriptionRepository.softDeleteChild(fileId);
	}

	

}
