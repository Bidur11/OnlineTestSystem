package com.pm.onlinetest.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class HelpDescription {
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer descriptionId;
	
	@Transient
	private Integer fileId;
	
	 @NotNull
	private Integer stepId;
	
	public Integer getFileId() {
		return fileId;
	}
	public void setFileId(Integer fileId) {
		this.fileId = fileId;
	}
	@ManyToOne
    @JoinColumn(name = "fileId")
    private FileUpload fileUpload;
	

	private boolean enabled;
	private String description;
	private String imgName;
	
	@Transient
	@JsonIgnore 
	private MultipartFile file;
	
	public HelpDescription() {
		super();
	}
	public Integer getDescriptionId() {
		return descriptionId;
	}
	public void setDescriptionId(Integer descriptionId) {
		this.descriptionId = descriptionId;
	}
	public FileUpload getFileupload() {
		return fileUpload;
	}
	public void setFileupload(FileUpload fileUpload) {
		this.fileUpload = fileUpload;
	}
	
	@Column(name = "enabled", nullable = false, columnDefinition = "BIT default TRUE", length = 1)
	public boolean isEnabled() {
		return enabled;
	}
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getImgName() {
		return imgName;
	}
	public void setImgName(String imgName) {
		this.imgName = imgName;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	public Integer getStepId() {
		return stepId;
	}
	public void setStepId(Integer stepId) {
		this.stepId = stepId;
	} 
	
	
	
	
	

}
