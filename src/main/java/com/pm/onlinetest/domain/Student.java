package com.pm.onlinetest.domain;

import javax.persistence.Entity;
import javax.validation.constraints.Pattern;

@Entity
public class Student extends User {

	@Pattern(regexp="[\\d]{6}")
	private String studentId;
	private String entry;
	
	private boolean jobSearchStatus;
	
	public String getEntry() {
		return entry;
	}

	public void setEntry(String entry) {
		this.entry = entry;
	}

	public String getStudentId() {
		return studentId;
	}

	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}

	public boolean isJobSearchStatus() {
		return jobSearchStatus;
	}

	public void setJobSearchStatus(boolean jobSearchStatus) {
		this.jobSearchStatus = jobSearchStatus;
	}


	
}
