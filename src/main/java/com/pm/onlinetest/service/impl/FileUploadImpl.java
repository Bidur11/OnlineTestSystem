package com.pm.onlinetest.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pm.onlinetest.domain.FileUpload;
import com.pm.onlinetest.repository.FileUploadRepository;
import com.pm.onlinetest.repository.HelpDescriptionRepository;
import com.pm.onlinetest.service.FileUploadService;

@Service
public class FileUploadImpl implements FileUploadService {
	
	@Autowired
	FileUploadRepository fileUploadRepository;
	


	@Override
	public FileUpload save(FileUpload fileUpload) {
		 return fileUploadRepository.save(fileUpload);
		
	}

	@Override
	public FileUpload getFileByFileId(Integer fileId) {
		return this.fileUploadRepository.findOne(fileId);
	}

	@Override
	public FileUpload findByHelpLink(String helpLink) {

		return this.fileUploadRepository.findByHelpLink(helpLink) ;
	}
	
	@Override
	public List<FileUpload> findAllEnabled() {
		List<FileUpload> helps = fileUploadRepository.findAllEnabled();
		return helps;
	}
	
	@Override
	public void softDelete(Integer fileId) {
		fileUploadRepository.softDelete(fileId);
	}

	

}
