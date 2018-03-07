package com.pm.onlinetest.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pm.onlinetest.domain.Question;

import com.pm.onlinetest.domain.Category;
import com.pm.onlinetest.domain.Choice;
import com.pm.onlinetest.service.CategoryService;
import com.pm.onlinetest.service.QuestionService;

@Controller
public class QuestionsController {

	@Autowired
	QuestionService questionService;
	@Autowired
	CategoryService categoryService;

	@RequestMapping(value = {"/dba/addquestion", "/coach/addquestion", "/admin/addquestion"}, method = RequestMethod.GET)
	public String addQuestion(Model model, HttpServletRequest request) {
		List<Category> listCategory = new ArrayList<>();
		listCategory.addAll(categoryService.findAll());
		Question q = new Question();
		List<Choice> choices = new ArrayList<>();
		for (int i = 0; i < 5; i++) {
			choices.add(new Choice());
		}
		q.setChoices(choices);
		model.addAttribute("question", q);
		model.addAttribute("categories", listCategory);
		// model.addAttribute("choices", choices);
		String mapping = request.getServletPath();
		return mapping;
	}

	@RequestMapping(value = {"/dba/addquestion", "/coach/addquestion", "/admin/addquestion"}, method = RequestMethod.POST)
	public String addQuestion(@Valid @ModelAttribute("question") Question question, BindingResult result,
			RedirectAttributes redirectAttr, Model model, HttpServletRequest request) {
		String mapping = request.getServletPath();
		if (result.hasErrors()) {
			List<Category> listCategory = new ArrayList<>();
			listCategory.addAll(categoryService.findAll());
			model.addAttribute("categories", listCategory);
			return mapping;
		}
		
		
		String newQuestion = question.getDescription();
		
		boolean questionPresent = questionService.checkQuestionPresent(newQuestion);
				
		if(questionPresent){
			redirectAttr.addFlashAttribute("duplicateError", "Question Duplicate Error!!!");
			return "redirect:" + mapping;
		}else{
			for (Choice choice : question.getChoices()) {
				choice.setQuestion(question);
			}
			questionService.save(question);
			redirectAttr.addFlashAttribute("success", "The question Successfully added !");
			redirectAttr.addFlashAttribute("question", question);
			return "redirect:"+mapping;
		}
	}

	// @RequestMapping(value = "/dba/editquestion/{question_id}", method =
	// RequestMethod.GET)
	// public String editQuestion(@PathVariable Integer question_id, Model
	// model) {
	// List<Category> listCategory = new ArrayList<>();
	// listCategory.addAll(categoryService.findAll());
	//
	// Question question = questionService.findQuestionById(question_id);
	// model.addAttribute("question", question);
	// model.addAttribute("categories", listCategory);
	//
	// return "editquestion";
	// }

	// @RequestMapping(value = "/dba/editquestion/{question_id}", method =
	// RequestMethod.POST)
	// public String editQuestion(@Valid @ModelAttribute("question") Question
	// question, BindingResult result,
	// RedirectAttributes redirectAttr, Model model) {
	//
	// if (result.hasErrors()) {
	// System.out.println("the error ");
	//
	// return "questions/editquestion";
	// }
	//
	// questionService.update(question);
	// redirectAttr.addFlashAttribute("success", "The question Successfully
	// added !");
	//
	// return "redirect:/dba/viewquestion";
	//
	// }

	@RequestMapping(value = { "/dba/viewquestions", "/coach/viewquestions", "/admin/viewquestions" }, method = RequestMethod.GET)
	public String viewQuestions(Model model, HttpServletRequest request) {
		List<Question> questions = questionService.findAll();

		model.addAttribute("questions", questions);
		String mapping = request.getServletPath();
		return mapping;
	}

	@RequestMapping(value = { "/dba/deleteQuestion", "/coach/deleteQuestion", "/admin/deleteQuestion" }, method = RequestMethod.POST)
	public void DeleteQuestion(HttpServletRequest request) {
		String id = request.getParameter("id").toString();
		Question question = questionService.findQuestionById(Integer.parseInt(id));
		questionService.delete(question);
	}
	
	// returning json data to auto fill the questions
	@RequestMapping(value = { "/admin/getQuestions","/coach/getQuestions", "/dba/getQuestions"} , method = RequestMethod.GET)
	@ResponseBody
	public JSONObject createGetQuestionsList(@ModelAttribute("Question") Question question) {
		
		String[] arr = new String[questionService.findAll().size()];
		JSONObject obj = new JSONObject();
		int index=0;
		for(Question q : questionService.findAll()){
			
			arr[index] = q.getDescription();
			index++;
		}
		obj.put("allQuestion", arr);
		return obj;
	}
}
