package com.pm.onlinetest.service;

import java.util.List;

import com.pm.onlinetest.domain.FileUpload;

public interface FileUploadService {

	public FileUpload save(FileUpload fileUpload);
	public FileUpload getFileByFileId(Integer fileId);
	public FileUpload findByHelpLink(String helpLink);
	public List<FileUpload> findAllEnabled();
	public void softDelete(Integer fileId);

}
