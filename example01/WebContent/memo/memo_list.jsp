<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@include file = "../include/inc_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<h2>메모장</h2>
	
	<form name = "memoForm">
	<table border = "1" width = "100%">
		<tr>
			<td width = "130">이름</td>
			<td><input type = "text" name = "name"></td>
		</tr>
		<tr>
			<td>메모</td>
			<td>
				<input type = "text" name = "content" style = "width: 60%;">
				<button type = "button" onclick = "wrtMem();">확인</button>
			</td>
		</tr>
	</table>
	<br><br>
	<table border = "1" width = "80%" align = "center">
		<tr>
			<td>ID</td>
			<td>이름</td>
			<td>메모</td>
			<td>날짜</td>
		</tr>
	<c:if test = "${list.size() == 0 }">
		<tr height = "200" >
			<td colspan = "10" align = "center">등록된 내용 없음</td>
		</tr>
	</c:if>
	<c:forEach var = "dto" items = "${list }">
		<tr>
			<td>${dto.id}</td>
			<td>${dto.name}</td>
			<td>${dto.content}</td>
			<td>${fn:substring(dto.reg_date,0,19) }</td>
		</tr>
	</c:forEach>
	<c:if test = "${totalRecord > 0 }">
		<tr>
			<td colspan = "7" height = "50" align = "center">
			<a href = "#" onclick = "GoPage('memo_list', '1','')">[첫페이지]</a>
			&nbsp;&nbsp;
			<c:if test = "${startPage > blockSize}">
				<a href = "#" onclick = "GoPage('memo_list','${startPage - blockSize}','');">[이전 10개]</a>
			</c:if>
			<c:if test = "${startPage <= blockSize}">
				[이전 10개]
			</c:if>
			&nbsp;&nbsp;
			<c:forEach var = "i" begin = "${startPage }" end = "${lastPage }" step = "1">
				<c:if test = "${i == pageNumber }">
					[${i }]
				</c:if>
				<c:if test = "${i != pageNumber }">
					<a href = "#" onclick = "GoPage('memo_list', '${i}','');">${i }</a>
				</c:if>
			</c:forEach>
			&nbsp;&nbsp;
			<c:if test = "${lastPage < totalPage }">
				<a href = "#" onclick = "GoPage('memo_list', '${startPage + blockSize}','');">[다음 10개]</a>
			</c:if>
			<c:if test = "${lastPage >= totalPage }">
				[다음 10개]
			</c:if>
			&nbsp;&nbsp;
			<a href = "#" onclick = "GoPage('memo_list','${totalPage}','');">[끝페이지]</a>
			</td>
		</tr>
	</c:if>	
	</table>
	</form>
	<script>
	function wrtMem(){
		memoForm.method = "post";
		memoForm.action = "${path}/memo_servlet/memoProc.do";
		memoForm.submit();
	}
	
	function GoPage(val1,val2,val3){
		if(val1 == 'memo_list'){
			location.href = '${path}/memo_servlet/list.do?pageNumber=' + val2;
		}
	}
	</script>

</body>
</html>