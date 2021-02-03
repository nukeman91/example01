<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file = "../include/inc_header.jsp" %>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:choose>
		<c:when test = "${menu_gubun == 'memo_main' }">
			<jsp:include page ="../memo/memo_main.jsp"/>
		</c:when>
		<c:when test = "${menu_gubun == 'memo_list' }">
			<jsp:include page = "../memo/memo_list.jsp"/>
		</c:when>
	</c:choose>
</body>
</html>