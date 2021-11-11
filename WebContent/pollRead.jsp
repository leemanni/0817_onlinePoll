<%@page import="com.koreait.onlinePoll.PollRead"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표하기</title>
<!--  
	favicon : 인터넷 웹 브라우저의 주소창에 표시되는 웹사이트나 웹페이지를 대표하는 아이콘이다.
-->
<link rel="icon" href="./pngwing.com (1).png">
</head>
<body>
	<h1>메롱</h1>
	<!-- 투표 항목이 지정된 텍스트 파일의 데이터를 읽어서 웹 브라우저에 출력한다.  -->
	<%
		//	프로젝트를 실행하면 이클립스가 자체적으로 웹 서버를 구축하고 구축된 웹 서버에서 프로젝트를 실행한다.
		//	=> 실제 경로, realPath(여기서 웹 서비스가 실행된다.)

		//	이클립스에서 웹 서비스가 구현되는 실제 경로 (wtpwebapps 폴더)
		//	C:\work\resource\JSP\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\0817_onlinePoll

		//	getRealPath("/") 명령을 실행해서 이클립스에서 웹 서비스가 구현되는 실제 경로를 얻어올 수 있다.
		//	out.println(application.getRealPath("/"));		//  "/" 는 웹 서비스가 실행되는 web root(최상위 경로)를 의미한다.
		String filePath = application.getRealPath("/") + "poll.txt";
		//	out.println(filePath);

		//	텍스트 파일의 데이터를 읽어오는 메소드를 실행해서 리턴되는 결과를 ArrayList에 저장한다.
		ArrayList<String> poll = PollRead.pollRead(filePath);
		//	out.println(poll);
		//	for(String str : poll){
		//	out.println(str + "<br>");
		//	}

		//	투표 항목이 증가하거나 감소 하더라도 해주기
		int itemCount = (poll.size() - 1) / 2;
		//	out.println(itemCount);
	%>
	<!-- 표를 만들어주기(절대적 방법-> widtn 치수, 상대적 방법-> %) -->
	<form action="pollWrite.jsp" method="post">
		<!-- cellpadding : 셀과 셀 내부에 입력된 데이터와의 간격을 지정한다 = > 안여백 -->
		<!-- cellspacing : 셀과 셀 사이의 간격을 지정한다.-->
		<table width="500" border="1" align="center" cellpadding ="5" cellspacing ="0">
			<!-- tr ~ / tr 까지가 한 줄 , 칸 => <th>테이블 헤더(첫줄) , <td> 테이블 데이터(나머지) -->
			<tr >
				<th><%=poll.get(0)%></th>
			</tr>
			<!-- 투표 항목의 개수만큼 반복하여 라디오 버튼과 투표 버튼 항목을 출력한다.  -->
		<%
			for (int i = 1; i < itemCount + 1; i++) { // 중간에 html 코드 삽입을 위해 이렇게 한다 나중엔 jstl 로 할거야
		%>
			<tr height="50">
				<td> 
					<input type="radio" name="poll" value=<%=i%>><%=poll.get(i)%>
				</td>
			</tr>
		<%
			}
		%>
			<tr height="50">
				<td align="center">
					<input type="submit" name="vote"value="투표하기"> 
					<!--  onclick="location.href='pollResult.jsp'" 자바스크립트 언어로 클릭 하는 순간 정해진 페이지로 보내주는 기능 -->
					<input type="button" name="result"value="결과보기" onclick="location.href='pollResult.jsp'">
				</td>
			</tr>
		</table>
	</form>


</body>
</html>
