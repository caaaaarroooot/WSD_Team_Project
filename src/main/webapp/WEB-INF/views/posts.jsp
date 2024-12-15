<%@ page language="java" contentType="text/html; charset=UTF-8"
		 isELIgnored="false"
		 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>free board</title>
	<style>
		<%--헤더바를 위한 css--%>
		body {
			width: 100vw;
			height: 100vh;
			box-sizing: border-box;
			padding: 30px;
			padding-top: 120px;
			display: flex;
			flex-direction: column;
			align-items: center;
			justify-content: start;
			margin: 0;
		}
		.header {
			position: fixed; /* 화면 상단에 고정 */
			top: 0;
			width: 100%;
			height: 80px;
			background-color: rgb(48, 23, 5);
			display: flex;
			flex-direction: row;
			align-items: center;
			justify-content: center;
			z-index: 1000; /* 다른 요소들 위에 표시되도록 설정 */
			opacity: 0.8;
		}
		.headerBtn {
			height: 100%;
			width: 100px;
			font-size: 25px;
			box-sizing: border-box;
			margin: 10px 5px 10px 0;
			display: flex;
			align-items: center;
			justify-content: center;
		}
		.headerDrop {
			color: white !important;
			font-size: 25px !important;
		}
		.linkImHeader {
			text-decoration: none;
			color: white;
		}

		.linkImHeader:hover {
			text-decoration: none !important;
			color: white;
			cursor: pointer;
		}
		/*여기까지 - for header*/

		#list {
			font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
			border-collapse: collapse;
			width: 100%;
			box-sizing: border-box;
		}
		#list td, #list th {
			box-sizing: border-box;
			border: 1px solid #ddd;
			padding: 8px;
			text-align:center;
		}
		#list tr:nth-child(even){background-color: #f2f2f2;}
		#list tr:hover {background-color: #ddd;}
		#list th {
			box-sizing: border-box;
			padding-top: 12px;
			padding-bottom: 12px;
			text-align: center;
			background-color: #006bb3;
			color: white;
		}
	</style>
</head>
<body>
<div class="header">
	<div style="width: 1200px">
		<a href="../dashboard" style="text-decoration: none"><h1 style="color: white">GGulTip</h1></a>
	</div>
	<!-- Add 버튼 -->
	<div class="headerBtn">
		<a href="./addpostform?subjectName=${subjectName}" class="linkImHeader">Add</a>
	</div>
	<div class="headerBtn">
		<a href="${pageContext.request.contextPath}/login/logout" class="linkImHeader">Logout</a>
	</div>
</div>
<div style="margin-bottom: 20px; display: flex; align-items: center; justify-content: space-between;">
	<form method="get" action="${pageContext.request.contextPath}/board/list" style="display: flex;">
		<input type="text" name="searchKeyword" placeholder="검색어 입력" value="${searchKeyword}" style="margin-right: 10px; padding: 5px;" />

		<select name="sortOption" style="margin-right: 10px; padding: 5px;">
			<option value="" ${sortOption == null ? 'selected' : ''}>정렬 없음</option>
			<option value="title" ${sortOption == 'title' ? 'selected' : ''}>제목순</option>
			<option value="regdate" ${sortOption == 'regdate' ? 'selected' : ''}>최신순</option>
			<option value="likes" ${sortOption == 'likes' ? 'selected' : ''}>좋아요순</option>
		</select>
		<input type="hidden" name="subjectName" value="${subjectName}" />
		<button type="submit" style="padding: 5px 10px;">검색</button>
	</form>
</div>
<h1>자유게시판</h1>

	<c:forEach items="${list}" var="u" varStatus="status">
		<div style="width: 100%; height: 90px; display: flex; flex-direction: row; justify-content: center">
			<h1 style="margin-right: 30px; color: #626466">${fn:length(list) - status.index}</h1>
			<div style="width: 80%; height: 70px; background-color: white;
        border: 1px solid #D2D2D2; border-right: none; border-left: none;
        display: flex; flex-direction: column; justify-content: space-between;
        box-sizing: border-box; padding: 5px;">
				<!-- 게시글 제목 클릭 시 상세페이지 이동 -->
				<a href="view/${u.id}" style="text-decoration: none; color: black;">
					<div style="font-size: 25px; font-weight: 900">${u.title}</div>
				</a>
				<div style="display: flex; flex-direction: row; width: 100%; justify-content: space-between; align-items: center; margin-top: 5px; margin-bottom: 5px;">
					<div>${u.userid}</div>
					<div style="display: flex; flex-direction: row; justify-content: flex-end; align-items: center;">
							${u.regdate}
						<img src="../img/view.png" width="30px" style="margin: 0 5px;"/>
							${u.view}
<%--						<img src="../img/like.png" width="25px" style="margin: 0 5px;"/>--%>
<%--							${u.like}--%>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>
</body>
</html>