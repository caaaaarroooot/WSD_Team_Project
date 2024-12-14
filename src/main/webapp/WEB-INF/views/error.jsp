<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>오류 발생</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container text-center mt-5">
    <h1 class="text-danger">오류가 발생했습니다.</h1>
    <p>요청을 처리하는 중 문제가 발생했습니다. 관리자에게 문의하세요.</p>
    <a href="${pageContext.request.contextPath}/board/list" class="btn btn-primary">메인으로 돌아가기</a>
</div>
</body>
</html>f