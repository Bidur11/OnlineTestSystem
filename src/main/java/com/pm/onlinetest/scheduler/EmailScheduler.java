package com.pm.onlinetest.scheduler;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.concurrent.SynchronousQueue;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.datetime.joda.LocalDateTimeParser;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.pm.onlinetest.domain.Assignment;
import com.pm.onlinetest.domain.Student;
import com.pm.onlinetest.service.AssignmentService;
import com.pm.onlinetest.service.StudentService;

@Component
public class EmailScheduler {
	
	@Autowired
	AssignmentService assignmentService;
	
	@Autowired
    private MailSender mailSender;

	@Scheduled(fixedDelay=30000)
	public void doTask() {		
		LocalDateTime currentTime = LocalDateTime.now();
		
		List<Assignment> assignments = assignmentService.findAll();
		
		for(Assignment assignment: assignments) {
			
			if(assignment.getStart_date() != null && !assignment.isStarted())  {
				long diffInSeconds = java.time.Duration.between(currentTime, assignment.getStart_date())
			            .getSeconds();
				
				if(diffInSeconds<0) {
					System.out.println("email sending...");
					sendEmail(assignment);
					assignment.setStart_date(null);
					assignmentService.update(assignment);
				}
			}
		}
	}

	private void sendEmail(Assignment assignment) {
		
		Student student = assignment.getStudentId();
		String email = student.getEmail();
		String accessCode = assignment.getAccesscode();
		System.out.println(email);
		SimpleMailMessage message = new SimpleMailMessage();
	    message.setTo(email);
	    message.setReplyTo("false");
	 
	    message.setFrom("mumtestlink@gmail.com");
	    message.setSubject("Test Link");
	    message.setText("The test you can take at this particular link. To access the test you need to enter the access code provided below. "
	    		+ " Please find the link and the access code below: \n"+ "Access Link: "+"https://localhost:8080/onlinetest/test" +"\n"+"Access Code: "+ accessCode +"\nAll the best!");
    	mailSender.send(message);
	}
}
