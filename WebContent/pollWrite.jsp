<%@page import="com.koreait.onlinePoll.PollWrite"%>
<%@page import="com.koreait.onlinePoll.PollRead"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.util.Scanner"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- pollRead.jsp 에서 넘어오는 투표한 항목을 받아서 득표수를 증가시켜 텍스트 파일에 저장한다. -->
<%
//	post 방식으로 데이터가 넘어올 때 한글 깨짐을 방지한다.
	request.setCharacterEncoding("UTF-8");

//	pollRead.jsp 에서 넘어오는 투표 데이터를 받는다.
	String temp = request.getParameter("poll");	
// 	투표 데이터가 넘어왔나(null 또는 공백이 아닌가) 검사한다. => 반드시 null 검사를 먼저한다.
	if( temp != null && temp.length() != 0){	
		
//		넘어온 투표 데이터가 숫자인가 검사한다.
		try{
			int voteResult = Integer.parseInt(temp);
			
			// 넘어온 데이터 숫자가 정상적인 투표 범위의 데이터인가 검사하기 위해서
			// 텍스트 파일을 읽어서 투표 항목의 개수를 계산한다.
			String filePath = application.getRealPath("/") + "poll.txt";
			ArrayList<String> dataList = PollRead.pollRead(filePath);
			int itemCount = (dataList.size()-1)/2 ;
			// 넘어온 투표 데이터가 정상적인 투표 범위인가 검사한다.
			
			
			if(voteResult <= itemCount || voteResult > 0){
				// 여기 까지 왔다는 것은 정상적인 투표 데이터가 넘어왔다는 것이므로 투표한 항목의 득표수를 증가시킨다.
				// 1. 득표수를 증가시킬 위치를 계산한다.
				int index = voteResult + itemCount;
				// 2. 득표수를 증가시킨다 => ArrayList index 번째 데이터를 1 증가 시킨다.
				voteResult = Integer.parseInt(dataList.get(index))+1;
				// 3. 증가된 득표수를 다시 ArrayList 에 저장한다.
				dataList.set(index, voteResult+"");
				// 4. ArrayList 텍스트 파일에 저장하는 메소드를 실행한다.
				PollWrite.pollWrite(filePath, dataList);
				
				// 5. 투표 결과보기 페이지로 넘겨준다.
				response.sendRedirect("pollResult.jsp");
				
				
			}else{
			//	넘어온 투표 데이터가 정상적인 투표 범위 숫자가 아니므로 오류 메세지를 출력하고 돌려보낸다
				out.println("<script>");
				out.println("alert('투표문항 이외의 문항을 선택하였습니다')");
				out.println("location.href='pollRead.jsp'");	// 메세지 보여주고 다른 페이지로 넘길때 자바 스크립트를 이용한다.
				out.println("</script>");
			}
		}catch(NumberFormatException e){
			// 넘어온 데이터가 숫자가 아니므로 오류 메세지 출력 후 pollRead.jsp 로 돌려보낸다
			out.println("<script>");
			out.println("alert('잘못된 투표 형식입니다.')");
			out.println("location.href='pollRead.jsp'");	// 메세지 보여주고 다른 페이지로 넘길때 자바 스크립트를 이용한다.
			out.println("</script>");
		}


	}else{
//		투표 데이터가 넘어오지 않았으므로 오류 메세지를 출력하고 pollRead.jsp 로 돌려보낸다
		out.println("<script>");
		out.println("alert('데이터가 넘어오지 않았습니다.')");
		out.println("location.href='pollRead.jsp'");	// 메세지 보여주고 다른 페이지로 넘길때 자바 스크립트를 이용한다.
		out.println("</script>");
		
//		jsp 는 서버용 스크립트 언어이고 javascript 는 클라이언트용 스크립트 언어이다.
//		하나의 jsp 파일에 서버용 스크립트와 클라이언트용 스크립트를 모두 사용한 경우 서버용 스크립트가 먼저 실행되고
//		그 다음 클라이언트용 스크립트가 실행된다 => 코딩 순서와 상관 없다.
		
//		response.sendRedirect() 메소드는 인수로 지정한 페이지로 넘겨준다.
//		response.sendRedirect("pollRead.jsp");
	}
%>
</body>
</html>