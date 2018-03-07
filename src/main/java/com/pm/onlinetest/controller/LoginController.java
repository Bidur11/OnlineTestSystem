package com.pm.onlinetest.controller;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pm.onlinetest.domain.User;
import com.pm.onlinetest.service.AssignmentService;
import com.pm.onlinetest.service.UserService;

@Controller
public class LoginController {
	
	final static Logger logger = Logger.getLogger(LoginController.class);

	@Autowired
	UserService userService;

	@Autowired
	private MailSender mailSender;

	@Autowired
	AssignmentService assignmentService;

	@RequestMapping(value = "/exam", method = RequestMethod.GET)
	public String exam(HttpServletRequest request) {
		request.getSession().setAttribute("min", 2);
		request.getSession().setAttribute("sec", 59);
		return "exam";
	}

	// @RequestMapping(value = "/login", method = RequestMethod.GET)
	// public String login() {
	// return "login";
	// }

	@RequestMapping(value = "/loginfailed", method = RequestMethod.GET)
	public String loginerror(@ModelAttribute("loginUser") User user, Model model) {
		model.addAttribute("error", "true");
		return "home";

	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
		}
		return "redirect:/";
	}

	
	@RequestMapping(value = "/postResetPassword", method = RequestMethod.POST)
	public String forgetPass(@ModelAttribute("loginUser") User user, Model model, RedirectAttributes redirectAttr) {

		String email = user.getEmail();

		if (userService.emailExists(user.getEmail())) {

			String accessCode = assignmentService.generateAccesscode();
			userService.setAccessCodeInPasswordField(email, accessCode);
			user = userService.findUserByAccessCode(accessCode);

			SimpleMailMessage message = new SimpleMailMessage();
			message.setTo(email);
			message.setReplyTo("false");
			message.setFrom("mumtestlink@gmail.com");
			message.setSubject("Reset Password");
			message.setText(
					"You have requested to reset your password for your account. To reset your password, please click this link."
							+ "Access Link: " + "http://localhost:8080/onlinetest/resetPassword/" + accessCode);

			mailSender.send(message);

			redirectAttr.addFlashAttribute("success", "Success");
			redirectAttr.addFlashAttribute("titleMessage", "Password Change Email Sent");
			redirectAttr.addFlashAttribute("bodyMessage",
					"Hi " + user.getFirstName() + ", an email has been sent to your email for password change.");

			return "redirect:/";
		} else {
			model.addAttribute("errorMessage", "Email Not Found, Please Enter Valid Email");
			System.out.println("Email Not Found");
			// return "home";

			redirectAttr.addFlashAttribute("success", "Success");
			redirectAttr.addFlashAttribute("titleMessage", "Email Not Found");
			redirectAttr.addFlashAttribute("bodyMessage", "There is no email registered by " + email);
			return "redirect:/";
		}

	}

	
	@RequestMapping(value = "/resetPassword/{accessCode}", method = RequestMethod.GET)
	public String resetPassword(Locale locale, Model model, HttpServletRequest request, HttpServletResponse response,
			@PathVariable("accessCode") String accessCode) {

		System.out.println("GET ACCESS IN RESET:" + accessCode);
		model.addAttribute("accessCode", accessCode);

		return "resetPassword";
	}

	
	@RequestMapping(value = "/resetPassword", method = RequestMethod.POST)
	public String updatePassword(Model model, HttpServletRequest request, RedirectAttributes redirectAttr) {

		String userAccessCode = request.getParameter("userAccessCode").toString();
		String newPassword = request.getParameter("newpassword");

		User user = userService.findUserByAccessCode(userAccessCode);

		if (user != null) {
			user.setPassword(newPassword);
			userService.saveProfile(user);

			redirectAttr.addFlashAttribute("success", "Success");
			redirectAttr.addFlashAttribute("titleMessage", "Password Changed");
			redirectAttr.addFlashAttribute("bodyMessage",
					"Hi " + user.getFirstName() + ", your password has been changed succesfully.");

			return "redirect:/";

		} else {

			redirectAttr.addFlashAttribute("success", "Success");
			redirectAttr.addFlashAttribute("titleMessage", "Reset Password Code Expired");
			redirectAttr.addFlashAttribute("bodyMessage",
					"Your reset password code has expired. Please try resetting password again. ");
			return "redirect:/";
		}
	}
	
	@RequestMapping(value = "/userChangePassword", method = RequestMethod.POST)
	public String changePassword(HttpServletRequest request, RedirectAttributes redirectAttr) {
		
		User user = (User) request.getSession().getAttribute("user");
		String newPassword = request.getParameter("nPassword");
		String url= request.getParameter("currentURL");
		
		url = url.substring(url.lastIndexOf("onlinetest/") + 11);
		
		System.out.println("URL: "+url);
		System.out.println("NEW PASSWORD: "+newPassword);
		
		
		user.setPassword(newPassword);
		userService.saveProfile(user);
		
		redirectAttr.addFlashAttribute("baseLayoutSuccess", "Success");
		redirectAttr.addFlashAttribute("titleMessage", "Password Changed Successfull !");
		redirectAttr.addFlashAttribute("bodyMessage","Your Password has been changed.");
		
		return "redirect:/"+url+"";
	}
	
	@RequestMapping(value = "/editUserProfile", method = RequestMethod.POST)
	public String updateProfile(HttpServletRequest request, RedirectAttributes redirectAttr) {
		
		User  user = (User) request.getSession().getAttribute("user");
		
		User user1 = userService.findByUserId(user.getUserId());
		
		user1.setEmail(request.getParameter("email"));
		user1.setFirstName(request.getParameter("firstName"));
		user1.setLastName(request.getParameter("lastName"));
		
		user1.setEnabled(true);
		userService.updateProfile(user1);
		
		user1.setPassword("");
		request.getSession().setAttribute("user", user1);
		
		String url = request.getHeader("referer");
		url = url.substring(url.lastIndexOf("onlinetest/") + 11);
		
		logger.info("PROFILE EDITED by :"+ user.getFirstName());
		
		redirectAttr.addFlashAttribute("baseLayoutSuccess", "Success");
		redirectAttr.addFlashAttribute("titleMessage", "Profile Updated Successfull !");
		redirectAttr.addFlashAttribute("bodyMessage","Your Profile Info has been changed.");
		
		return "redirect:/"+url+"";
	}
}
