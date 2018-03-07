package com.pm.onlinetest.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.poi.ddf.EscherDggRecord.FileIdCluster;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pm.onlinetest.domain.FileUpload;
import com.pm.onlinetest.domain.HelpDescription;
import com.pm.onlinetest.service.FileUploadService;
import com.pm.onlinetest.service.HelpDescriptionService;
import com.pm.onlinetest.util.CustomFileValidator;


@Controller
public class HelpController {

	@Autowired
	FileUploadService fileUploadService;
	
	@Autowired
	HelpDescriptionService helpDescriptionService;

	@Autowired
	ServletContext servletContext;
	
	@Autowired
	CustomFileValidator customFileValidator;

	@RequestMapping(value = "/admin/help", method = RequestMethod.GET)
	public String helpAmin(Model model) {
		List<FileUpload> imageFile = fileUploadService.findAllEnabled();
	/*	for(FileUpload img : imageFile){
			img.getHelpDescriptions().forEach(h->{
				System.out.println(h.getDescription());
			});
		}*/
		model.addAttribute("imageFile", imageFile);
		return "adminHelp";
	}
	
	@RequestMapping(value = "/coach/help", method = RequestMethod.GET)
	public String helpCoach(Model model) {
		List<FileUpload> imageFile = fileUploadService.findAllEnabled();
		model.addAttribute("imageFile", imageFile);
		return "coachHelp";
	}
	
	@RequestMapping(value = "/dba/help", method = RequestMethod.GET)
	public String helpDba(Model model) {
		List<FileUpload> imageFile = fileUploadService.findAllEnabled();
		model.addAttribute("imageFile", imageFile);
		return "dbaHelp";
	}

	@RequestMapping(value = "/admin/addHelpLink", method = RequestMethod.GET)
	public String getAddnewLinkForm(@ModelAttribute("fileUpload") FileUpload fileUpload) {
		return "/admin/addHelpLink";
	}
	
	@RequestMapping(value = "/admin/addHelpLink", method = RequestMethod.POST)
	public String addNewLink(@Valid @ModelAttribute("fileUpload") FileUpload fileUpload, BindingResult result,
		HttpServletRequest request)
					throws FileNotFoundException {
		if (result.hasErrors()) {
			return "/admin/addHelpLink";
		}else{
			if(this.fileUploadService.findByHelpLink(fileUpload.getHelpLink()) != null){
				result.rejectValue("helpLink", "error.fileUpload", "helpLink should be unique, this name already exist !!");
				return "/admin/addHelpLink";
			}else{
				fileUpload.setEnabled(true);

				fileUpload = fileUploadService.save(fileUpload);				
			}
		}
		return "redirect:/admin/allHelpLink";
	}

	


	@RequestMapping(value = "/admin/allHelpLink", method = RequestMethod.GET)
	public String getLinkList(Model model)
	{
		List<FileUpload> imageFile = fileUploadService.findAllEnabled();
		model.addAttribute("imageFile", imageFile);
		return "viewAllHelpLink";

	}
	
	
	@RequestMapping(value = "/admin/editHelpLink/{fileId}", method = RequestMethod.GET)
	public String getEditForm(@PathVariable Integer fileId, Model model) {
		model.addAttribute("linkEdit", fileUploadService.getFileByFileId(fileId));
		return "helpLinkEditForm";
	}
	@RequestMapping(value = "/admin/editHelpLink/{fileId}", method = RequestMethod.POST)
	public String updateLink(FileUpload fileUpload, @PathVariable Integer fileId,
			@ModelAttribute("linkEdit") @Valid FileUpload linkEdit, BindingResult result, Model model) {
		
		if (result.hasErrors()) {
			return "helpLinkEditForm";
		} else {
			linkEdit.setEnabled(true);
			fileUploadService.save(linkEdit);
			return "redirect:/admin/allHelpLink";
		}
	}
	
	@RequestMapping(value = "/admin/deleteHelp", method = RequestMethod.POST)
	@ResponseBody
	public String DeleteHelpLink(HttpServletRequest request) {
		String id = request.getParameter("fileId").toString();
		fileUploadService.softDelete(Integer.parseInt(id));
		helpDescriptionService.softDeleteChild(Integer.parseInt(id));
		return "help link delete Successfully";
	}

	
	
	
	@RequestMapping(value = "/admin/uploadDescription/{fileId}", method = RequestMethod.GET)
	public String getAddForm(@PathVariable Integer fileId,@ModelAttribute("helpDescription") HelpDescription helpDescription, Model model) {
		model.addAttribute(fileId);
		return "uploadDescription";
	}
	
	private Path path;
	@RequestMapping(value = "/admin/uploadDescription/{fileId}", method = RequestMethod.POST)
	public String addNewScreenShots(@Valid  @ModelAttribute("helpDescription") HelpDescription helpDescription, BindingResult result,
		HttpServletRequest request)
					throws FileNotFoundException {

		customFileValidator.validate(helpDescription, result);
		
		
		if (result.hasErrors()) {
			return "uploadDescription";
		}else{
			if(this.helpDescriptionService.findByImgName(helpDescription.getImgName()) != null){
				result.rejectValue("imgName", "error.helpDescription", "Image name should be unique, this name already exist !!");
				return "uploadDescription";
			}else{
				helpDescription.setEnabled(true);
				
				FileUpload fileupload = fileUploadService.getFileByFileId(helpDescription.getFileId());

				helpDescription.setFileupload(fileupload);

				helpDescriptionService.save(helpDescription);
				
				String imgName = "help_" + helpDescription.getFileId() + "_"  + helpDescription.getDescriptionId();
				
				helpDescription.setImgName(imgName);
				
				helpDescriptionService.save(helpDescription);

				MultipartFile userImage = helpDescription.getFile();

				String rootDirectory = "C:\\Users\\gyanendra\\Desktop\\OnlineTest-master\\src\\main\\webapp";

				path = Paths.get(rootDirectory + "/resources/images/"  + imgName + ".png");

				if (userImage != null && !userImage.isEmpty()) {
					try {
						userImage.transferTo(new File(path.toString()));
					} catch (Exception e) {
						e.printStackTrace();
						throw new RuntimeException("Image saving failed", e);
					}
				}
				
			}
		}
		return "redirect:/admin/allHelpLink";
	}
	
	
	@RequestMapping(value = "/admin/allDescription/{fileId}", method = RequestMethod.GET)
	public String getAllDescription(@PathVariable Integer fileId, Model model, HttpServletRequest request)
	{
		FileUpload fileUpload = fileUploadService.getFileByFileId(fileId);
		List<HelpDescription> allImageFileByFileId = helpDescriptionService.findAllEnabledByFileId(fileUpload);
		model.addAttribute("allImageFile", allImageFileByFileId);
		model.addAttribute("fileId",fileId);
		return "viewAllDescription";

	}
	
	
	
	
	
	@RequestMapping(value = "/admin/allDescription/editDescription/{fileId}/{descriptionId}", method = RequestMethod.GET)
	public String get(@PathVariable Integer fileId, @PathVariable Integer descriptionId, Model model, HelpDescription helpDescription) {
		model.addAttribute("descriptionEdit", helpDescriptionService.getFileByDescriptionId(descriptionId));
		model.addAttribute("fileId", fileId);
		return "descriptionEditForm";
	}
	
	
	@RequestMapping(value = "/admin/allDescription/editDescription/{fileId}/{descriptionId}", method = RequestMethod.POST)
	public String update(@PathVariable Integer fileId, @PathVariable Integer descriptionId, HelpDescription helpDescription,
			@ModelAttribute("descriptionEdit") @Valid HelpDescription descriptionEdit, BindingResult result, Model model) {
		
		if (result.hasErrors()) {
			return "descriptionEditForm";
		} else {
			descriptionEdit.setEnabled(true);
			FileUpload fileupload = fileUploadService.getFileByFileId(helpDescription.getFileId());

			descriptionEdit.setFileupload(fileupload);
			
			String imgName = "help_" + helpDescription.getFileId() + "_"  + helpDescription.getDescriptionId();
			//System.out.println(imgName);
			descriptionEdit.setImgName(imgName);
			
			helpDescriptionService.save(descriptionEdit);
			return "redirect:/admin/allDescription/{fileId}";
		}
	}
	
	
	@RequestMapping(value = "/admin/deleteHelpDescription", method = RequestMethod.POST)
	@ResponseBody
	public String DeleteDescription(HttpServletRequest request) {
		String id = request.getParameter("descriptionId").toString();
		helpDescriptionService.softDelete(Integer.parseInt(id));
		return "Description delete Successfully";
	}
	
	/*@RequestMapping(value = { "/admin/help/description", "/coach/help/description", "/dba/help/description" }, method = RequestMethod.GET)
	@ResponseBody
	public String loadDescription(HttpServletRequest request, @RequestParam int id) {
		FileUpload file = fileUploadService.getFileByFileId(id);
		String description = file.getDescription();
		return description;
	}*/
	
	

}

