package com.pm.onlinetest.util;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;
import org.springframework.web.multipart.MultipartFile;

import com.pm.onlinetest.domain.HelpDescription;

@Component
public class CustomFileValidator implements Validator {

	public static final long TEN_MB_IN_BYTES = 10485760;
	/*public static String[] PNG_MIME_TYPE = {"image/png","String2","String3"}; */
	@Override
	public boolean supports(Class<?> clazz) {
		return HelpDescription.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		HelpDescription helpDescription = (HelpDescription)target;
		MultipartFile file = helpDescription.getFile();
		if(file.isEmpty()){
			errors.rejectValue("file", "fileUpload.file.required");
		}
		else if(!(file.getContentType().equalsIgnoreCase("image/png")
				|| file.getContentType().equalsIgnoreCase("image/jpg")
				|| file.getContentType().equalsIgnoreCase("image/jpeg") 
				|| file.getContentType().equalsIgnoreCase("image/png")
				|| file.getContentType().equalsIgnoreCase("image/gif")
				|| file.getContentType().equalsIgnoreCase("image/webp")
				|| file.getContentType().equalsIgnoreCase("image/bmp"))){
			errors.rejectValue("file", "fileUpload.invalid.file.type");
		}

		else if(file.getSize() > TEN_MB_IN_BYTES){
			errors.rejectValue("file", "fileUpload.exceeded.file.size");
		}

	}

}
