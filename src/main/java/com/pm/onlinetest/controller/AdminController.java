package com.pm.onlinetest.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Locale;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.apache.commons.validator.EmailValidator;

import com.pm.onlinetest.domain.User;
import com.pm.onlinetest.domain.Authority;
import com.pm.onlinetest.domain.Category;
import com.pm.onlinetest.domain.Choice;
import com.pm.onlinetest.domain.LogPop;
import com.pm.onlinetest.domain.Question;
import com.pm.onlinetest.domain.Student;
import com.pm.onlinetest.domain.Subcategory;
import com.pm.onlinetest.domain.Test;
import com.pm.onlinetest.service.AuthorityService;
import com.pm.onlinetest.service.CategoryService;
import com.pm.onlinetest.service.ChoiceService;
import com.pm.onlinetest.service.QuestionService;
import com.pm.onlinetest.service.StudentService;
import com.pm.onlinetest.service.SubCategoryService;
import com.pm.onlinetest.service.UserService;

import helpers.CurrentQuestion;

/**
 * Handles requests for the application home page.
 */
@Controller
public class AdminController {

	private static final Logger logger = Logger.getLogger(AdminController.class);

	@Autowired
	UserService userService;
	@Autowired
	AuthorityService authorityService;
	@Autowired
	StudentService studentService;
	@Autowired
	CategoryService categoryService;
	@Autowired
	SubCategoryService subCategoryService;
	@Autowired
	QuestionService questionService;
	@Autowired
	ChoiceService choiceService;

	@RequestMapping(value = "/admin/home", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {

		return "admin-home";
	}

	@RequestMapping(value = "/admin/users", method = RequestMethod.GET)
	public String getUsers(Locale locale, HttpServletRequest request, Model model) {

		String username = request.getUserPrincipal().getName();
		User user = userService.findByUsername(username);

		for (Authority authority : user.getAuthorities()) {

			if (authority.getAuthority().equals("ROLE_ADMIN")) {
				model.addAttribute("role", "admin");
			} else if (authority.getAuthority().equals("ROLE_COACH")) {
				model.addAttribute("role", "coach");
			} else if (authority.getAuthority().equals("ROLE_DBA")) {
				model.addAttribute("role", "admin");
			}
		}

		return "users";
	}

	// added functionality to select new users based on user status
	@RequestMapping(value = "/admin/users", method = RequestMethod.POST)
	@ResponseBody
	public List<User> getUsers(Locale locale, Model model, HttpServletRequest request) {

		List<User> users = null;
		if (request.getParameter("selectedValue") != null) {

			String enableValue = request.getParameter("selectedValue");
			String userenableCheck = enableValue;
			if (userenableCheck.equals("active") || userenableCheck.equals("select")) {
				users = userService.findAllEnabled();
				model.addAttribute("users", users);
			}

			if (userenableCheck.equals("inactive")) {
				users = userService.findAllDisabled();
				model.addAttribute("users", users);
			}
			if (userenableCheck.equals("all")) {
				users = userService.findAll();
				model.addAttribute("users", users);
			}
		} else {
			users = userService.findAllEnabled();
			model.addAttribute("users", users);
		}
		return users;
	}
	//

	@RequestMapping(value = "/admin/register", method = RequestMethod.GET)
	public String register(@ModelAttribute("loginUser") User user) {
		return "register";
	}

	@RequestMapping(value = "/admin/register", method = RequestMethod.POST)
	public String add(@Valid @ModelAttribute("loginUser") User user, BindingResult result,
			RedirectAttributes redirectAttr) {
		if (result.hasErrors()) {
			return "register";
		}

		if (null != userService.findByUsername(user.getUsername())) {
			redirectAttr.addFlashAttribute("error", "Error");
			return "redirect:/admin/register";
		} else if (userService.emailExists(user.getEmail())) {
			redirectAttr.addFlashAttribute("duplicateEmailError", "DuplicateEmailError");
			return "redirect:/admin/register";
		} else {
			user.setEnabled(true);
			userService.save(user);
			redirectAttr.addFlashAttribute("success", "Success");
			return "redirect:/admin/users";
		}
	}

	@RequestMapping(value = "/admin/editUser/{id}", method = RequestMethod.GET)
	public String editUser(@ModelAttribute("loginUser") User user, Model model, @PathVariable String id) {

		model.addAttribute("user", userService.findByUserId(Integer.parseInt(id)));
		return "editUser";
	}

	@RequestMapping(value = { "/admin/editUser" }, method = RequestMethod.POST)
	public String editUser(@Valid @ModelAttribute("loginUser") User user, BindingResult result,
			RedirectAttributes redirectAttr) {
		if (result.hasErrors()) {
			return "editUser";
		}

		if (null != userService.findByUsernameExceptThis(user.getUsername(), user.getUserId())) {
			redirectAttr.addFlashAttribute("error", "Error");
			return "redirect:/admin/editUser/" + user.getUserId();
		} else if (null != userService.findByEmailExceptThis(user.getEmail(), user.getUserId())) {
			redirectAttr.addFlashAttribute("emailError", "EmailError");
			return "redirect:/admin/editUser/" + user.getUserId();
		} else {
			user.setEnabled(true);
			userService.save(user);
			redirectAttr.addFlashAttribute("successEdit", "successEdit");
			return "redirect:/admin/users";
		}
	}

	@RequestMapping(value = { "/admin/registerStudent", "/coach/registerStudent" }, method = RequestMethod.GET)
	public String getStudent(@ModelAttribute("student") Student student, HttpServletRequest request) {
		String mapping = request.getServletPath();
		return mapping;
	}

	@RequestMapping(value = { "/admin/registerStudent", "/coach/registerStudent" }, method = RequestMethod.POST)
	public String registerStudent(@Valid @ModelAttribute("student") Student student, BindingResult result,
			RedirectAttributes redirectAttr, HttpServletRequest request) {

		String mapping = request.getServletPath();
		String url = "/" + (String) request.getSession().getAttribute("role") + "/students";
		if (result.hasErrors()) {
			return mapping;
		}
		if (null != studentService.findByStudentId(student.getStudentId())) {
			redirectAttr.addFlashAttribute("error", "Error");
			return "redirect:" + mapping;
		} else if (userService.emailExists(student.getEmail())) {
			redirectAttr.addFlashAttribute("duplicateEmailError", "DuplicateEmailError");
			return "redirect:" + mapping;
		} else {
			studentService.save(student);
			redirectAttr.addFlashAttribute("successAddStudent", "successAddStudent");
			return "redirect:" + url;
		}
	}

	@RequestMapping(value = { "/admin/checkid", "/coach/checkid" }, method = RequestMethod.POST)
	@ResponseBody
	public String checkStudentId(HttpServletRequest request) {

		String id = request.getParameter("userid").toString();
		String check = "";
		if (studentService.findByStudentId(id) != null) {
			check = "This student already exist !";
		} else {
			check = "";
		}
		return check;

	}

	@RequestMapping(value = { "/admin/checkEmail", "/coach/checkEmail" }, method = RequestMethod.POST)
	@ResponseBody
	public String checkEmail(HttpServletRequest request) {
		String email = request.getParameter("email").toString();
		String check = "";
		if (userService.emailExists(email)) {
			check = "This email already exist !";
		}
		return check;
	}

	@RequestMapping(value = { "/admin/editStudent/{id}", "/coach/editStudent/{id}" }, method = RequestMethod.GET)
	public String editStudent(@ModelAttribute("student") Student student, HttpServletRequest request, Model model,
			@PathVariable("id") int id) {
		model.addAttribute("student", studentService.findByUserId(id));
		String mapping = request.getServletPath();
		String mappingIDRemoved = mapping.substring(0, mapping.length() - Integer.toString(id).length() - 1);
		return mappingIDRemoved;
	}

	@RequestMapping(value = { "/admin/editStudent", "/coach/editStudent" }, method = RequestMethod.POST)
	public String editStudent(@ModelAttribute("student") Student student, BindingResult result,
			RedirectAttributes redirectAttr, HttpServletRequest request) {
		String mapping = request.getServletPath();
		if (result.hasErrors()) {
			return mapping;
		}

		if (null != studentService.findByStudentIdExceptThis(student.getStudentId(), student.getUserId())) {
			redirectAttr.addFlashAttribute("error", "Error");
			return "redirect:" + mapping + "/" + student.getUserId();
		}else if(null != userService.findByEmailExceptThis(student.getEmail(), student.getUserId())) {
			redirectAttr.addFlashAttribute("emailError", "EmailError");
			return "redirect:" + mapping + "/" + student.getUserId();
		} 
		else {
			studentService.save(student);
			redirectAttr.addFlashAttribute("successEditStudent", "successEditStudent");
			String role = (String) request.getSession().getAttribute("role");
			
			return "redirect:/"+role+"/students";
		}
	}

	@RequestMapping(value = { "/admin/deleteUser", "/coach/deleteUser" }, method = RequestMethod.POST)
	@ResponseBody
	public String DeleteUser(HttpServletRequest request) {
		String id = request.getParameter("userid").toString();
		userService.softDelete(Integer.parseInt(id));
		return "user successfully deleted";
	}

	@RequestMapping(value = { "/admin/unDeleteUser", "/coach/unDeleteUser" }, method = RequestMethod.POST)
	@ResponseBody
	public String unDeleteUser(HttpServletRequest request) {
		String id = request.getParameter("userid").toString();
		userService.softUnDelete(Integer.parseInt(id));
		return "user successfully undeleted";
	}

	@RequestMapping(value = { "/admin/students", "/coach/students" }, method = RequestMethod.GET)
	public String getStudents(HttpServletRequest request, Model model) {
		String username = request.getUserPrincipal().getName();
		User user = userService.findByUsername(username);

		for (Authority authority : user.getAuthorities()) {

			if (authority.getAuthority().equals("ROLE_ADMIN")) {
				model.addAttribute("role", "admin");
			} else if (authority.getAuthority().equals("ROLE_COACH")) {
				model.addAttribute("role", "coach");
			} else if (authority.getAuthority().equals("ROLE_DBA")) {
				model.addAttribute("role", "admin");
			}
		}

		String mapping = request.getServletPath();
		return mapping;
	}

	// added functionalities to check and display students based on status
	// change from ajax request
	@RequestMapping(value = { "/admin/students", "/coach/students" }, method = RequestMethod.POST)
	@ResponseBody
	public List<Student> getStudents(Model model, HttpServletRequest request) {
		String role = request.getUserPrincipal().getName();

		List<Student> students = null;
		if (request.getParameter("selectedValue") != null) {

			String enableValue = request.getParameter("selectedValue");
			String userenableCheck = enableValue;
			if (userenableCheck.equals("active")) {
				students = studentService.findAllEnabled();
				// model.addAttribute("users", students);
			}

			if (userenableCheck.equals("inactive")) {
				students = studentService.findAllDisabled();
				// model.addAttribute("users", students);
			}
			if (userenableCheck.equals("all")) {
				students = studentService.findAll();
				// model.addAttribute("users", students);
			}
		} else {
			students = studentService.findAllEnabled();
			// model.addAttribute("users", students);
		}
		return students;

		// String status = request.getParameter("selectedValue");
		// List<Student> students = studentService.findAllEnabled();
		// model.addAttribute("students", students);
		// String mapping = request.getServletPath();
		// return mapping;
	}
	// end of added functionalities of displaying students based on status
	// changed from ajax request

	@RequestMapping(value = "/admin/categories", method = RequestMethod.GET)
	public String getCategory(Model model) {
		List<Category> categories = categoryService.findAllEnabled();
		model.addAttribute("categories", categories);
		return "categories";
	}

	@RequestMapping(value = "/admin/createCategory", method = RequestMethod.GET)
	public String createCategory(@ModelAttribute("Category") Category category) {
		return "createCategory";
	}

	// returning json data to auto fill the categories
	@RequestMapping(value = "/admin/createCategory/getCategory", method = RequestMethod.GET)
	@ResponseBody
	public List<Category> createGetCategoryList(@ModelAttribute("Category") Category category) {
		return categoryService.findAllEnabled();
	}

	@RequestMapping(value = "/admin/createCategory", method = RequestMethod.POST)
	public String createCategoryPost(@ModelAttribute("Category") Category category, BindingResult result,
			RedirectAttributes redirectAttr) {
		if (result.hasErrors()) {
			return "createCategory";
		}

		String msg;
		if (!categoryService.checkCategory(category)) {
			msg = "";
		} else {
			categoryService.save(category);
			msg = "Successfully added new category";

		}
		redirectAttr.addFlashAttribute("success", msg);
		return "redirect:/admin/createCategory";
	}

	@RequestMapping(value = "/admin/subCategories", method = RequestMethod.GET)
	public String getSubCategory(Model model) {
		List<Subcategory> subCategories = subCategoryService.findAllEnabled();
		model.addAttribute("subCategories", subCategories);
		return "subCategories";
	}

	@RequestMapping(value = { "/admin/deleteCategory" }, method = RequestMethod.POST)
	public void DeleteCategory(HttpServletRequest request) {
		String id = request.getParameter("id").toString();
		categoryService.softDelete(Integer.parseInt(id));
	}

	@RequestMapping(value = "/admin/createSubCategory", method = RequestMethod.GET)
	public String createSubCategory(@ModelAttribute("Subcategory") Subcategory subcategory, Model model) {
		List<Category> categories = categoryService.findAllEnabled();
		model.addAttribute("categories", categories);
		return "createSubCategory";
	}

	@RequestMapping(value = "/admin/createSubCategory", method = RequestMethod.POST)
	public String createSubCategoryPost(@ModelAttribute("Subcategory") Subcategory subcategory, BindingResult result,
			RedirectAttributes redirectAttr) {
		if (result.hasErrors()) {
			return "createSubCategory";
		}

		subcategory.setCategory(categoryService.findOne(subcategory.getCategoryId()));

		String msg;
		if (!subCategoryService.checkSubCategory(subcategory)) {
			msg = "";
		} else {
			subCategoryService.save(subcategory);
			msg = "Successfully added new Subcategory!";

		}
		redirectAttr.addFlashAttribute("success", msg);
		return "redirect:/admin/createSubCategory";
	}

	@RequestMapping(value = "/admin/createSubCategory/getSubCategory", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject getSubCategoryList(@ModelAttribute("Subcategory") Subcategory subcategory,
			HttpServletRequest request) {
		String id = request.getParameter("id").toString();
		JSONObject obj = new JSONObject();
		String[] arr = new String[subCategoryService.getSubCategories(Integer.parseInt(id)).size()];
		int index = 0;
		for (Subcategory x : subCategoryService.getSubCategories(Integer.parseInt(id))) {
			arr[index] = x.getName();
			index++;
		}
		obj.put("subcat", arr);
		return obj;
	}

	@RequestMapping(value = { "/admin/deleteSubCategory" }, method = RequestMethod.POST)
	public void DeleteSubCategory(HttpServletRequest request) {
		String id = request.getParameter("id").toString();
		subCategoryService.softDelete(Integer.parseInt(id));
	}

	@RequestMapping(value = { "/admin/importData", "/coach/importData", "/dba/importData",
			"/admin/uploadStudents", "/coach/uploadStudents", "/dba/uploadStudents" }, method = RequestMethod.GET)
	public String importDataGet(HttpServletRequest request) {
		String mapping = request.getServletPath();
		return mapping;
	}

	@RequestMapping(value = { "/admin/importData", "/coach/importData",
			"/dba/importData" }, method = RequestMethod.POST)
	public String processExcel2007(Model model, @RequestParam("ExcelFile") MultipartFile excelfile,
			RedirectAttributes redirectAttr, HttpServletRequest request) {
		String mapping = request.getServletPath();
		String ls = System.lineSeparator();

		try {
			List<Question> questions = new ArrayList<>();
			int i = 0;
			// Creates a workbook object from the uploaded excelfile
			XSSFWorkbook workbook = new XSSFWorkbook(excelfile.getInputStream());

			// Creates a worksheet object representing the first sheet
			XSSFSheet worksheet = workbook.getSheetAt(0);

			boolean error = true;
			String errorMessage;
			List<String> errors = new ArrayList<String>();
			List<LogPop> errorLogPop = new ArrayList<LogPop>();
			
			// Reads the data in excel file until last row is encountered

			if (error) {
				error = false;
				while (i <= worksheet.getLastRowNum()) {
					Question question = new Question();
					List<Choice> choices = new ArrayList<>();
					XSSFRow row = worksheet.getRow(i++);
					
					for (int j = 0; j < 9; j++) {
						
						if (row.getCell(j).toString().equals("") ) {
							
							error = true;
							errorMessage = "Location : Error on Excel File : Line Number " + i + " Column " + j + ls;
							errorMessage += "Cause : Data Not Found." + ls;
							errors.add(errorMessage);
							
							LogPop logpop = new LogPop();
							logpop.setLocation("Line Number " + i + " Column " + j);
							logpop.setCause("Data Not Found.");
							errorLogPop.add(logpop);
						}
						if (j == 3) {
							
							String answer = row.getCell(j).getStringCellValue().toUpperCase();
							if (65 > answer.charAt(0) || 70 < answer.charAt(0)) {
								error = true;
								errorMessage = "Location : Error on Excel File : Line Number " + i + " Column " + j
										+ ls;
								errorMessage += "Cause : Correct Answer Entry Other Than A,B,C,D,E." + ls;
								errors.add(errorMessage);
								
								LogPop logpop = new LogPop();
								logpop.setLocation("Line Number " + i + " Column " + j);
								logpop.setCause("Correct Answer Entry Other Than A,B,C,D,E.");
								errorLogPop.add(logpop);
							}
						}
						if(j==2){
							String newQuestion = row.getCell(j).getStringCellValue();
							boolean questionPresent = questionService.checkQuestionPresent(newQuestion);
							
							if (questionPresent) {
								error = true;
								errorMessage = "Location : Error on Excel File : Line Number " + i + " Column " + j
										+ ls;
								errorMessage += "Cause : DUPLICATE QUESTION: "+"(" + newQuestion + ")."
										+ ls;
								errors.add(errorMessage);
								
								LogPop logpop = new LogPop();
								logpop.setLocation("Line Number " + i + " Column " + j);
								logpop.setCause("DUPLICATE QUESTION: "+"(" + newQuestion + ").");
								errorLogPop.add(logpop);
							}
						}
						
					}
				}
			}

			if (error) {
				
				String bulkErrorMessage = "LOG REPORT: " + excelfile.getOriginalFilename() + ls;
				int index = 1;
				for (String erro : errors) {
					bulkErrorMessage = bulkErrorMessage + ls + index + ". " + erro;
					index++;
				}

				logger.error(bulkErrorMessage);

				redirectAttr.addFlashAttribute("error", "Invalid Data, File Upload Cancelled.");
				redirectAttr.addFlashAttribute("bulkUploadQuestionError", "Batch Upload Error");
				redirectAttr.addFlashAttribute("titleMessage", "ERROR : Batch Upload Questions Error");
				redirectAttr.addFlashAttribute("bodyMessage", bulkErrorMessage);
				
				redirectAttr.addFlashAttribute("filename",excelfile.getOriginalFilename());
				redirectAttr.addFlashAttribute("errorLogPop",errorLogPop);

				return "redirect:" + mapping;
			}
				
			i = 0;
			

			if (!error) {
				while (i <= worksheet.getLastRowNum()) {
					Question question = new Question();
					List<Choice> choices = new ArrayList<>();

					XSSFRow row = worksheet.getRow(i++);

					question.setDescription(row.getCell(2).getStringCellValue());

					String catName = row.getCell(0).getStringCellValue().trim();
					String subCatName = row.getCell(1).getStringCellValue().trim();

					List<Subcategory> subcategories = subCategoryService.findSubCategoryByName(subCatName);
					if (subcategories.size() == 0) {
						Subcategory subCategory = new Subcategory();
						subCategory.setName(subCatName);
						subCategory.setEnabled(true);

						List<Category> categories = categoryService.findCategoryByName(subCatName);
						if (categories.size() == 0) {
							Category category = new Category();
							category.setName(catName);
							category.setEnabled(true);
							categoryService.save(category);
							subCategory.setCategory(category);
						} else {
							subCategory.setCategory(categories.get(0));
						}
						subCategoryService.save(subCategory);
						question.setSubcategory(subCategory);
					} else {
						question.setSubcategory(subcategories.get(0));
					}

					questionService.save(question);
					String answer = row.getCell(3).getStringCellValue().toUpperCase();
					int correctAnswerPos = answer.charAt(0) - 65;

					for (int k = 0; k <= 4; k++) {
						Choice choice = new Choice();
						choice.setQuestion(question);
						choice.setDescription(row.getCell(k + 4).getStringCellValue().trim());
						if (correctAnswerPos == k) {
							choice.setAnswer(true);
						} else {
							choice.setAnswer(false);
						}
						choices.add(choice);
					}
					choiceService.save(choices);

				}
			}
			workbook.close();
			redirectAttr.addFlashAttribute("success", "Success");

		} catch (Exception e) {
			e.printStackTrace();
			redirectAttr.addFlashAttribute("error", "Error");
			redirectAttr.addFlashAttribute("error2", "Error:\n" + e);
		}

		return "redirect:" + mapping;
	}

	/* Batch Import Student Details */

	@RequestMapping(value = { "/admin/uploadStudents", "/coach/uploadStudents" }, method = RequestMethod.POST)
	public String uploadStudents(Model model, @RequestParam("ExcelFile") MultipartFile excelfile,
			RedirectAttributes redirectAttr, HttpServletRequest request) {
		logger.info("Uploading student records");
		System.out.println("Upload data");
		String mapping = request.getServletPath();
		String ls = System.lineSeparator();
		try {

			List<Student> students = new ArrayList<>();
			int i = 1;
			// Creates a workbook object from the uploaded excelfile
			XSSFWorkbook workbook = new XSSFWorkbook(excelfile.getInputStream());
			// Creates a worksheet object representing the first sheet
			XSSFSheet worksheet = workbook.getSheetAt(0);

			

			boolean error = true;
			String errorMessage;
			
			List<LogPop> errorLogPop = new ArrayList<LogPop>();
			List<String> errors = new ArrayList<String>();

			// Reads the data in excel file until last row is encountered

			if (error) {
				error = false;
				while (i <= worksheet.getLastRowNum()) {
					XSSFRow row = worksheet.getRow(i++);
				
					Student student = new Student();
					
					for (int j = 0; j < 6; j++) {

						if (row.getCell(j).toString().equals("")){
							error = true;
							errorMessage = "Location : Error on Excel File : Line Number " + i + " Column " + j + ls;
							errorMessage += "Cause : Data Not Found." + ls;
							errors.add(errorMessage);
							
							LogPop logpop = new LogPop();
							logpop.setLocation("Line Number " + i + " Column " + j);
							logpop.setCause("Data Not Found.");
							errorLogPop.add(logpop);
							
						}
						if (j == 0) {
							
							String studentId = row.getCell(0).getStringCellValue().trim();
							
							if (studentService.findOneByStudentId(studentId) != null) {
								error = true;
								errorMessage = "Location : Error on Excel File : Line Number " + i + " Column " + j
										+ ls;
								errorMessage += "Cause : Student Id Already Exist ( "+ studentId +" )" + ls;
								errors.add(errorMessage);
								
								LogPop logpop = new LogPop();
								logpop.setLocation("Line Number " + i + " Column " + j);
								logpop.setCause("Student Id Already Exist ( "+ studentId +" )");
								errorLogPop.add(logpop);
								
							}
						}
						
						if(j == 3){
							String email = row.getCell(3).getStringCellValue().trim();
							EmailValidator emailValidator = EmailValidator.getInstance();
							if (!emailValidator.isValid(email)) {
								error = true;
								errorMessage = "Location : Error on Excel File : Line Number " + i + " Column " + j
										+ ls;
								errorMessage += "Cause : Invalid Email Provided( "+ email +" )" + ls;
								errors.add(errorMessage);
								
								LogPop logpop = new LogPop();
								logpop.setLocation("Line Number " + i + " Column " + j);
								logpop.setCause("Invalid Email Provided( "+ email +" )");
								errorLogPop.add(logpop);
								
							}else{
								if(userService.emailExists(email)){
									error = true;
									errorMessage = "Location : Error on Excel File : Line Number " + i + " Column " + j
											+ ls;
									errorMessage += "Cause : Email Already Exist: ( "+ email +" )" + ls;
									errors.add(errorMessage);
									
									LogPop logpop = new LogPop();
									logpop.setLocation("Line Number " + i + " Column " + j);
									logpop.setCause("Email Already Exist: ( "+ email +" )");
									errorLogPop.add(logpop);
								}
							}
						}
						if(j == 5){
							String status = row.getCell(5).getStringCellValue().trim();
							if (!status.equalsIgnoreCase("ACTIVE") ) {
								if(!status.equalsIgnoreCase("INACTIVE")){
									error = true;
									errorMessage = "Location : Error on Excel File : Line Number " + i + " Column " + j
											+ ls;
									errorMessage += "Cause : Invalid Job Search Status Data: ( "+ status +" )" + ls;
									errors.add(errorMessage);
									
									LogPop logpop = new LogPop();
									logpop.setLocation("Line Number " + i + " Column " + j);
									logpop.setCause("Invalid Job Search Status Data: ( "+ status +" )");
									errorLogPop.add(logpop);
								
								}
							}
						}
					}
				}
			}
					
			if (error) {

				String bulkErrorMessage = "LOG REPORT: " + excelfile.getOriginalFilename() + ls;
				int index = 1;
				for (String erro : errors) {
					bulkErrorMessage = bulkErrorMessage + ls + index + ". " + erro;
					index++;
				}

				logger.error(bulkErrorMessage);

				redirectAttr.addFlashAttribute("error", "Invalid Data, File Upload Cancelled.");
				redirectAttr.addFlashAttribute("bulkUploadStudentError", "Batch Upload Error");
				redirectAttr.addFlashAttribute("titleMessage", "ERROR : Batch Upload Student Error");
				redirectAttr.addFlashAttribute("errorMessage", bulkErrorMessage);
				
				redirectAttr.addFlashAttribute("filename",excelfile.getOriginalFilename());
				redirectAttr.addFlashAttribute("errorLogPop",errorLogPop);
				

				return "redirect:students";
			}
			
			i=1;
			
			if(!error){
				while (i <= worksheet.getLastRowNum()) {
					Student student = new Student();
					
					XSSFRow row = worksheet.getRow(i++);
					
					student.setStudentId(readCell(row, 0));
					student.setFirstName(readCell(row, 1));
					student.setLastName(readCell(row, 2));
					student.setEmail(readCell(row, 3));
					student.setEntry(readCell(row, 4));
					student.setJobSearchStatus(readCell(row, 5).equalsIgnoreCase("Active") ? true : false);
					student.setEnabled(readCell(row, 5).equalsIgnoreCase("Active") ? true : false);
					
					studentService.save(student);
				}
			}
			
			workbook.close();
			redirectAttr.addFlashAttribute("success", "Success");
			
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttr.addFlashAttribute("error", "Error");
			redirectAttr.addFlashAttribute("error2", "Error:\n" + e);
		}

		return "redirect:students";
	}

	private String readCell(XSSFRow row, int column) {
		XSSFCell cell = row.getCell(column);
		int type = cell.getCellType();
		switch (type) {
		case 0:
			return new Double(cell.getNumericCellValue()).intValue() + "";
		case 1:
			return cell.getStringCellValue();
		default:
			throw new RuntimeException("There is no support for this type of cell");
		}
	}

	@RequestMapping(value = { "/dba/subcategories/{catId}", "/coach/subcategories/{catId}",
			"/admin/subcategories/{catId}" }, method = RequestMethod.POST)
	@ResponseBody
	public JSONObject setAnswer(HttpServletRequest request, @PathVariable("catId") Integer catId) {
		List<Subcategory> listSubCategory = new ArrayList<>();
		listSubCategory.addAll(subCategoryService.findByCategoryId(categoryService.findOne(catId)));

		JSONObject obj = new JSONObject();

		String str = "<select id='idSubCategory' path='subcategory.id' name='subcategory.id' class='form-control placeholder-no-fix'>";
		for (Subcategory sc : listSubCategory) {
			str += "<option value=" + sc.getId() + ">" + sc.getName() + "</option>";
		}
		str += "</select>";
		obj.put("subcat", str);
		return obj;
	}

	// @ResponseBody
	// @RequestMapping(value = "/assign", method = RequestMethod.POST)
	// public String getAssignCoach(Locale locale, Model model,
	// HttpServletRequest request,
	// RedirectAttributes redirectAttr) {
	// String coachId = request.getParameter("coachId").toString();
	// String studentId = request.getParameter("studentId").toString();
	// User coach = userService.findByUserId(Integer.parseInt(coachId));
	// Student student = studentService.findByStudentId(studentId);
	// Student_Record studentRecord = new Student_Record();
	// studentRecord.setCoach(coach);
	// studentRecord.setStudent(student);
	// studentRecordService.save(studentRecord);
	//
	// // redirectAttr.addFlashAttribute("success", "Successfully assigned!");
	// // return "assigned";
	// return "ok";
	// }

	// @RequestMapping(value = "/assignedList", method = RequestMethod.GET)
	// public String getAssignedList(Locale locale, Model model) {
	// List<Student_Record> studentRecords = studentRecordService.findAll();
	// model.addAttribute("studentRecords", studentRecords);
	// return "assignedList";
	// }
	//
	// @RequestMapping(value = { "/deleteAssign" }, method = RequestMethod.POST)
	// public void DeleteAssign(HttpServletRequest request) {
	// String id = request.getParameter("userid").toString();
	// Student_Record sr = studentRecordService.findById(Integer.parseInt(id));
	// studentRecordService.delete(sr);
	// }
}
