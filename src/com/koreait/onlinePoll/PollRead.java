package com.koreait.onlinePoll;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

public class PollRead {
//	텍스트 파일이 저장된 경로와 이름을 넘겨받아 텍스트 파일에 저장된 데이터를 읽어서 
//	ArrayList 에 저장시킨 후 리턴하는 메소드를 만들기
	
	public static ArrayList<String> pollRead(String filePath) {
		ArrayList<String> dataList = null;;
		Scanner scanner = null;
		try {
			dataList = new ArrayList<>();
			scanner = new Scanner(new File(filePath));
			while (scanner.hasNext()) {
				String str = scanner.nextLine().trim();
				if(str.length() > 0) {
					dataList.add(str);
				}
			}
		} catch (FileNotFoundException e) {
			System.out.println("파일이 존재하지 않음;;");
			e.printStackTrace();
		}
		return dataList;
	}
}
