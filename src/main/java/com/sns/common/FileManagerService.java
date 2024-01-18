package com.sns.common;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class FileManagerService {
	
	public static final String FILE_UPLOAD_PATH = "C:\\megastudy\\6_spring_project\\SNS\\sns_workspace\\images/";
	
	public String saveFile(String loginId, MultipartFile file) {
		
		// create folder = directory
		String direcotyrName = loginId + "_" + System.currentTimeMillis();
		String filePath = FILE_UPLOAD_PATH + direcotyrName;
		
		File direcotry = new File(filePath);
		if (!direcotry.mkdir()) { // failed to make directory
			return null;
		}
		
		// file upload
		try {
			byte[] bytes = file.getBytes();
			Path path = Paths.get(filePath + "/" + file.getOriginalFilename());
			Files.write(path, bytes);
		} catch (IOException e) {
			e.printStackTrace();
			return null; // failed to upload image
		}
		
		return "/images/" + direcotyrName + "/" + file.getOriginalFilename();
	}
}
