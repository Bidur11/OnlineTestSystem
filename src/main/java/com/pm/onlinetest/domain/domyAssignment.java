package com.pm.onlinetest.domain;

import java.time.LocalDateTime;

public class domyAssignment {
	
	private Integer assignmentId;
	
	private String coachFirstName;
	
	private String studentId;
	
	private String studentFirstName;
	
	private String studentLastName;
	 
	private String studentEntry;
	
	private String studentEmail;
	
	private LocalDateTime start_date;
	 
 	private LocalDateTime end_date;
 	
 	private String start;
 	
 	private String finish;
 	
 	private String accesscode;
 	
 	private Integer count;
 	
 	
 	
 	
 	

	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getFinish() {
		return finish;
	}

	public void setFinish(String finish) {
		this.finish = finish;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	

	public String getAccesscode() {
		return accesscode;
	}

	public void setAccesscode(String accesscode) {
		this.accesscode = accesscode;
	}

	public Integer getAssignmentId() {
		return assignmentId;
	}

	public void setAssignmentId(Integer assignmentId) {
		this.assignmentId = assignmentId;
	}

	public String getCoachFirstName() {
		return coachFirstName;
	}

	public void setCoachFirstName(String coachFirstName) {
		this.coachFirstName = coachFirstName;
	}

	public String getStudentId() {
		return studentId;
	}

	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}

	public String getStudentFirstName() {
		return studentFirstName;
	}

	public void setStudentFirstName(String studentFirstName) {
		this.studentFirstName = studentFirstName;
	}

	public String getStudentLastName() {
		return studentLastName;
	}

	public void setStudentLastName(String studentLastName) {
		this.studentLastName = studentLastName;
	}

	public String getStudentEntry() {
		return studentEntry;
	}

	public void setStudentEntry(String studentEntry) {
		this.studentEntry = studentEntry;
	}

	public String getStudentEmail() {
		return studentEmail;
	}

	public void setStudentEmail(String studentEmail) {
		this.studentEmail = studentEmail;
	}

	public LocalDateTime getStart_date() {
		return start_date;
	}

	public void setStart_date(LocalDateTime start_date) {
		this.start_date = start_date;
	}

	public LocalDateTime getEnd_date() {
		return end_date;
	}

	public void setEnd_date(LocalDateTime end_date) {
		this.end_date = end_date;
	}

	@Override
	public String toString() {
		return "domyAssignment [assignmentId=" + assignmentId + ", coachFirstName=" + coachFirstName + ", studentId="
				+ studentId + ", studentFirstName=" + studentFirstName + ", studentLastName=" + studentLastName
				+ ", studentEntry=" + studentEntry + ", studentEmail=" + studentEmail + ", start_date=" + start_date
				+ ", end_date=" + end_date + "]";
	}
 	
 	
 	
 	
	

}
