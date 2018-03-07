package com.pm.onlinetest.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.List;
import java.util.Locale;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pm.onlinetest.domain.Assignment;
import com.pm.onlinetest.domain.Authority;
import com.pm.onlinetest.domain.Choice;
import com.pm.onlinetest.domain.Question;
import com.pm.onlinetest.domain.Subcategory;
import com.pm.onlinetest.domain.Test;
import com.pm.onlinetest.domain.User;
import com.pm.onlinetest.domain.domyAssignment;
import com.pm.onlinetest.service.AssignmentService;
import com.pm.onlinetest.service.ChoiceService;
import com.pm.onlinetest.service.GradeService;
import com.pm.onlinetest.service.SearchService;
import com.pm.onlinetest.service.UserService;

@Controller
public class ReportController {

	@Autowired
	SearchService searchService;

	@Autowired
	AssignmentService assignmentService;

	@Autowired
	GradeService gradeService;

	@Autowired
	ChoiceService choiceService;
	@Autowired
	UserService userService;

	@RequestMapping(value = { "/coach/result/{id}", "/admin/result/{id}" }, method = RequestMethod.GET)
	public String testResult(@PathVariable("id") int id, Model model, HttpServletRequest request) {

		HashMap<Subcategory, String> report = new HashMap<>();

		Set<Subcategory> subcats = new HashSet<>();
		Assignment assignment = assignmentService.findById(id);
		Set<Test> tests = assignment.getTests();

		for (Test test : tests) {
			subcats.add(test.getQuestion().getSubcategory());
		}

		int numberofQuestions = tests.size();
		int overAllTotal = 0;
		double overAllAverage = 0;
		for (Subcategory subcat : subcats) {

			int scorePerCategory = 0;
			int totalQuestionsPerCategory = 0;
			for (Test testQuestion : tests) {
				if (testQuestion.getQuestion().getSubcategory().equals(subcat)) {
					totalQuestionsPerCategory++;

					if (testQuestion.getAnswer() != null) {
						int choiceID = 0;
						for (Choice ch : testQuestion.getQuestion().getChoices()) {
							if (ch.getAnswer()) {
								choiceID = ch.getId();
								break;
							}
						}
						if (testQuestion.getAnswer() == choiceID) {
							scorePerCategory++;
							overAllTotal++;
						}
					}

				}
			}
			//
			report.put(subcat, scorePerCategory + " / " + totalQuestionsPerCategory + "  |   "
					+ scorePerCategory * 100 / totalQuestionsPerCategory + "%");
			overAllAverage = 0;
			totalQuestionsPerCategory = 0;
		}
		model.addAttribute("reports", report);
		model.addAttribute("total", overAllTotal);
		model.addAttribute("questions", numberofQuestions);
		model.addAttribute("studentAssignment", assignment);
		model.addAttribute("grade", gradeService.getGradeAsStringFromInteger(100 / numberofQuestions * overAllTotal));
		String mapping = request.getServletPath();
		String mappingIDRemoved = mapping.substring(0, mapping.length() - Integer.toString(id).length() - 1);
		return mappingIDRemoved;
	}

	@RequestMapping(value = { "/coach/resultDetail/{id}", "/admin/resultDetail/{id}" }, method = RequestMethod.GET)
	public String testResultDetail(@PathVariable("id") int id, Model model, HttpServletRequest request) {

		HashMap<Test, Boolean> reportDetail = new HashMap<>();
		Assignment assignment = assignmentService.findById(id);
		Set<Test> tests = assignment.getTests();
		int score = 0;

		for (Test testQuestion : tests) {
			boolean answer = false;
			int choiceID = 0;
			if (testQuestion.getAnswer() != null) {
				for (Choice ch : testQuestion.getQuestion().getChoices()) {
					if (ch.getAnswer()) {
						choiceID = ch.getId();
						break;
					}
				}
				if (testQuestion.getAnswer() == choiceID) {
					answer = true;
					score++;
					reportDetail.put(testQuestion, answer);
				}
			}
			reportDetail.put(testQuestion, answer);
		}

		model.addAttribute("answers", reportDetail);
		model.addAttribute("student", assignmentService.findById(id).getStudentId());
		model.addAttribute("score", score + "/" + tests.size());
		double testPercent = 100 / tests.size() * score;
		model.addAttribute("percent", testPercent);

		String mapping = request.getServletPath();
		String mappingIDRemoved = mapping.substring(0, mapping.length() - Integer.toString(id).length() - 1);
		return mappingIDRemoved;
	}

	// added functionality
	@RequestMapping(value = { "/coach/assignments", "/admin/assignments" }, method = RequestMethod.GET)
	public String assignmentDetail(HttpServletRequest request,Model model) {
		
		String username = request.getUserPrincipal().getName();		
		User user = userService.findByUsername(username);

		for (Authority authority : user.getAuthorities()) {
			
			if (authority.getAuthority().equals("ROLE_ADMIN")) {
				model.addAttribute("role","admin");
			} else if (authority.getAuthority().equals("ROLE_COACH")) {
				model.addAttribute("role","coach");
			} else if (authority.getAuthority().equals("ROLE_DBA")) {
				model.addAttribute("role","admin");
			}
		}
		String mapping = request.getServletPath();
		return mapping;
	}

	@RequestMapping(value = { "/coach/assignments", "/admin/assignments" }, method = RequestMethod.POST)
	@ResponseBody
	public List<domyAssignment> assignmentDetailAjax(HttpServletRequest request,
			@RequestParam("selectedValue") String selectedValue) {
		
		List<domyAssignment> domyAssignmentList = new ArrayList();

		// if (selectedValue.equals("all")) {

		List<Assignment> assignments = assignmentService.findAll();

		for (Assignment assignment : assignments) {
			
			if(selectedValue.equals( "all")){

			domyAssignment dass = new domyAssignment();

			dass.setAssignmentId(assignment.getId());
			dass.setCoachFirstName(assignment.getCoachId().getFirstName());
			dass.setEnd_date(assignment.getEnd_date());
			dass.setStart_date(assignment.getStart_date());
			dass.setStudentId(assignment.getStudentId().getStudentId());
			dass.setStudentEmail(assignment.getStudentId().getEmail());
			dass.setStudentEntry(assignment.getStudentId().getEntry());
			dass.setStudentFirstName(assignment.getStudentId().getFirstName());
			dass.setStudentLastName(assignment.getStudentId().getLastName());
			dass.setStart("T");
			dass.setFinish("F");
			
			if (assignment.isStarted() == true) {
				dass.setStart("true");
			}
			if (assignment.isStarted() == false) {
				dass.setStart("false");
			}
			if (assignment.isFinished() == true) {
				dass.setFinish("true");
			}

			if (assignment.isFinished() == false) {
				dass.setFinish("false");
			}

			dass.setCount(assignment.getCount());
			
			domyAssignmentList.add(dass);

			}

			if(selectedValue.equals( "assigned") && assignment.isStarted() == false && assignment.isFinished()==false  ){

				domyAssignment dass = new domyAssignment();
				
				dass.setAssignmentId(assignment.getId());
				dass.setCoachFirstName(assignment.getCoachId().getFirstName());
				dass.setEnd_date(assignment.getEnd_date());
				dass.setStart_date(assignment.getStart_date());
				dass.setStudentId(assignment.getStudentId().getStudentId());
				dass.setStudentEmail(assignment.getStudentId().getEmail());
				dass.setStudentEntry(assignment.getStudentId().getEntry());
				dass.setStudentFirstName(assignment.getStudentId().getFirstName());
				dass.setStudentLastName(assignment.getStudentId().getLastName());
				dass.setStart("T");
				dass.setFinish("F");
				
				if (assignment.isStarted() == true) {
					dass.setStart("true");
				}
				if (assignment.isStarted() == false) {
					dass.setStart("false");
				}
				if (assignment.isFinished() == true) {
					dass.setFinish("true");
				}

				if (assignment.isFinished() == false) {
					dass.setFinish("false");
				}

				dass.setCount(assignment.getCount());
				
				domyAssignmentList.add(dass);
				  
				}
			if(selectedValue.equals( "scheduled") && assignment.isStarted() == true && assignment.isFinished()==false  ){

				domyAssignment dass = new domyAssignment();
				
				dass.setAssignmentId(assignment.getId());
				dass.setCoachFirstName(assignment.getCoachId().getFirstName());
				dass.setEnd_date(assignment.getEnd_date());
				dass.setStart_date(assignment.getStart_date());
				dass.setStudentId(assignment.getStudentId().getStudentId());
				dass.setStudentEmail(assignment.getStudentId().getEmail());
				dass.setStudentEntry(assignment.getStudentId().getEntry());
				dass.setStudentFirstName(assignment.getStudentId().getFirstName());
				dass.setStudentLastName(assignment.getStudentId().getLastName());
				
				
				if (assignment.isStarted() == true) {
					dass.setStart("true");
				}
				if (assignment.isStarted() == false) {
					dass.setStart("false");
				}
				if (assignment.isFinished() == true) {
					dass.setFinish("true");
				}

				if (assignment.isFinished() == false) {
					dass.setFinish("false");
				}

				dass.setCount(assignment.getCount());
				
				domyAssignmentList.add(dass);
				  
				}
			if(selectedValue.equals( "finished") && assignment.isStarted() == true && assignment.isFinished()==true  ){

				domyAssignment dass = new domyAssignment();
				
				dass.setAssignmentId(assignment.getId());
				dass.setCoachFirstName(assignment.getCoachId().getFirstName());
				dass.setEnd_date(assignment.getEnd_date());
				dass.setStart_date(assignment.getStart_date());
				dass.setStudentId(assignment.getStudentId().getStudentId());
				dass.setStudentEmail(assignment.getStudentId().getEmail());
				dass.setStudentEntry(assignment.getStudentId().getEntry());
				dass.setStudentFirstName(assignment.getStudentId().getFirstName());
				dass.setStudentLastName(assignment.getStudentId().getLastName());
				dass.setStart("T");
				dass.setFinish("F");
				
				if (assignment.isStarted() == true) {
					dass.setStart("true");
				}
				if (assignment.isStarted() == false) {
					dass.setStart("false");
				}
				if (assignment.isFinished() == true) {
					dass.setFinish("true");
				}

				if (assignment.isFinished() == false) {
					dass.setFinish("false");
				}

				dass.setCount(assignment.getCount());
				
				domyAssignmentList.add(dass);
				  
				}
			
		}

		String mapping = request.getServletPath();
		return domyAssignmentList;
	}

	// end of added functionality
	// @RequestMapping(value = {"/coach/assignments", "/admin/assignments"},
	// method = RequestMethod.GET)
	// public String assignmentDetail(Model model, HttpServletRequest request) {
	//
	// List<Assignment> assignments = assignmentService.findAll();
	// model.addAttribute("assignments", assignments);
	//
	// String mapping = request.getServletPath();
	// return mapping;
	// }

//	@RequestMapping(value = {"/admin/assignments"}, method = RequestMethod.GET)
//	public String assignmentDetail(HttpServletRequest request) {
//
//		String mapping = request.getServletPath();
//		return mapping;
//	}
	
//	@RequestMapping(value = {"/coach/assignments", "/admin/assignments"}, method = RequestMethod.POST)
//	@ResponseBody
//	public List<domyAssignment> assignmentDetailAjax(HttpServletRequest request,@RequestParam ("selectedValue") String selectedValue) {
//		
//		System.out.println("I am here-------------------------- "+selectedValue);
//		
//		List<Assignment> assignments=assignmentService.findAll();
//		
//		List<domyAssignment> domyAssignmentList = new ArrayList();
//		
//		
//		for(Assignment assignment : assignments){
//			
//			domyAssignment dass = new domyAssignment();
//			
//			dass.setAssignmentId(assignment.getId());
//			dass.setCoachFirstName(assignment.getCoachId().getFirstName());
//			dass.setEnd_date(assignment.getEnd_date());
//			dass.setStart_date(assignment.getStart_date());
//			dass.setStudentId(assignment.getStudentId().getStudentId());
//			dass.setStudentEmail(assignment.getStudentId().getEmail());
//			dass.setStudentEntry(assignment.getStudentId().getEntry());
//			dass.setStudentFirstName(assignment.getStudentId().getFirstName());
//			dass.setStudentLastName(assignment.getStudentId().getLastName());
//			domyAssignmentList.add(dass);
//			
//		}
//		
//		
//	
//		String mapping = request.getServletPath();
//		return domyAssignmentList;
//	}
	
//	@RequestMapping(value = {"/coach/test"}, method = RequestMethod.GET)
//	@ResponseBody
//	public String getTest() {
//		
//		System.out.println("I am here-------------------------- ");
//
//		//List<Assignment> assignments = assignmentService.findAll();
//		//model.addAttribute("assignments", assignments);
//		
//		//String mapping = request.getServletPath();
//		return "aa";
//	}
	

	@RequestMapping(value = {"/coach/resultlist", "/admin/resultlist"}, method = RequestMethod.GET)
	public String resultList(Model model, HttpServletRequest request) {

		HashMap<Assignment, Long> reports = new HashMap<>();
		List<Assignment> finisedAssignmentList = new ArrayList<>();
		List<Assignment> assignments = assignmentService.findAll();
		// filter only the finished tests
		for (Assignment assign : assignments) {
			if (assign.isFinished() == true) {
				finisedAssignmentList.add(assign);
			}
		}

		int score = 0;
		for (Assignment assignment : finisedAssignmentList) {
			System.out.println(assignment.getStudentId());
			for (Test testQuestion : assignment.getTests()) {
				if (testQuestion.getAnswer() != null) {
					int choiceID = 0;
					for (Choice ch : testQuestion.getQuestion().getChoices()) {
						if (ch.getAnswer()) {
							choiceID = ch.getId();
							break;
						}
					}
					if (testQuestion.getAnswer() == choiceID) {
						score++;
					}
				}

			}
			long testPercent = 100 * score / assignment.getTests().size();
			System.out.println("----" + testPercent);
			reports.put(assignment, testPercent);
			model.addAttribute("reports", reports);
			score = 0;

		}
		String mapping = request.getServletPath();
		return mapping;
	}

	@RequestMapping(value = "/coach/feedback", method = RequestMethod.GET)
	public String giveFeedback(Model model) {
		return "feedback";

	}

}