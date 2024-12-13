<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Post Details</title>
</head>
<body>
<h1>게시글 상세 정보</h1>
<p><strong>ID:</strong> ${post.id}</p>
<p><strong>제목:</strong> ${post.title}</p>
<p><strong>내용:</strong> ${post.content}</p>
<p><strong>작성일:</strong> ${post.created_date}</p>
<a href="list">목록으로</a>
</body>
</html>