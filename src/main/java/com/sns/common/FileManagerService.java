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
		// folder(directory) 생성
		// e.g.: aaaa_13854324684/sun.png
		//       = (loginId)_(miliseconds)/(file name)
		String direcotryName = loginId + "_" + System.currentTimeMillis();
		
		// C:\\megastudy\\6_spring_project\\MEMO\\memo_workspace\\images/aaaa_13854324684
		String filePath = FILE_UPLOAD_PATH + direcotryName;
		
		File directory = new File(filePath); // import java.io
		if (!directory.mkdir()) { // 폴더 생성 실패
			return null;
		}
		
		// 파일 업로드 = byte 단위
		try {
			byte[] bytes = file.getBytes();
			// ★★★★★ 한글 이름 이미지는 올릴 수 없으므로 나중에 영문자로 바꿔서 올리기
			// import java.nio
			Path path = Paths.get(filePath + "/" + file.getOriginalFilename());
			Files.write(path, bytes); // 실제 파일 업로드
		} catch (IOException e) {
			e.printStackTrace();
			return null; // 이미지 업로드 실패
		}
		
		// 파일 업로드가 성공했다면 웹 이미지 url path를 return
		// /images/aaaa_13854324684/sun.png
		return "/images/" + direcotryName + "/" + file.getOriginalFilename();
	}
}
