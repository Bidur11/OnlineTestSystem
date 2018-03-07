package com.pm.onlinetest.domain;

import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

@Entity
public class FileUpload {
	

	public FileUpload(Integer fileId, boolean enabled, String helpLink) {
		super();
		this.fileId = fileId;
		this.enabled = enabled;
		this.helpLink = helpLink;
	}

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer fileId;
	
	
	
	private boolean enabled;
	
	@Column(unique = true)
	@Size(min=2, max=50)
	@NotEmpty(message="No empty field accepted")	
	private String helpLink;
	
	@OrderBy("stepId")
	@OneToMany(mappedBy = "fileUpload",cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private  Set<HelpDescription> helpDescriptions;
	
	
	public Set<HelpDescription> getHelpDescriptions() {
		return helpDescriptions;
	}

	public void setHelpDescriptions(Set<HelpDescription> helpDescriptions) {
		this.helpDescriptions = helpDescriptions;
	}

	public Integer getFileId() {
		return fileId;
	}

	public void setFileId(Integer fileId) {
		this.fileId = fileId;
	}
	
	public FileUpload(){
		super();
	}

	public String getHelpLink() {
		return helpLink;
	}

	public void setHelpLink(String helpLink) {
		this.helpLink = helpLink;
	}  
	
	@Column(name = "enabled", nullable = false, columnDefinition = "BIT default TRUE", length = 1)
	public boolean isEnabled() {
		return this.enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	

}
