package com.pm.onlinetest.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pm.onlinetest.domain.Question;
import com.pm.onlinetest.domain.Subcategory;
import com.pm.onlinetest.repository.QuestionRepository;
import com.pm.onlinetest.service.QuestionService;

@Service

public class QuestionServiceImp implements QuestionService {
	@Autowired
	QuestionRepository questionRepository;

	@Override
	public void save(Question question) {
		questionRepository.save(question);
	}

	@Override
	public List<Question> findAll() {
		return (List<Question>) questionRepository.findAll();
	}

	@Override
	public Question findQuestionById(Integer id) {
		return questionRepository.findOne(id);
	}

	@Override
	public void delete(Question question) {
		questionRepository.delete(question);
	}

	@Override
	public List<Question> findBySubcategory(Subcategory subcategory) {
		List<Question> questions = questionRepository.findBySubcategory(subcategory);
		return questions;
	}

	@Override
	public void update(Question question) {
		questionRepository.save(question);

	}

	@Override
	public boolean checkQuestionPresent(String newQuestion) {
		
		boolean flag = false;
		
		newQuestion = newQuestion.replaceAll("\\s", "");
		newQuestion = newQuestion.toLowerCase();
		newQuestion = newQuestion.replaceAll("[^a-zA-Z0-9]", "");

		List<Question> questionList = findAll();
		
		for (Question q : questionList) {

			String questionDescription = q.getDescription();
			String modifiedQuestion = questionDescription.replaceAll("\\s+", "");
			modifiedQuestion = modifiedQuestion.toLowerCase();
			modifiedQuestion = modifiedQuestion.replaceAll("[^a-zA-Z0-9]", "");
			
			if (newQuestion.equalsIgnoreCase(modifiedQuestion)) {
				flag = true;
			}
		}

		return flag;
	}

}
