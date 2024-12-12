<%--
  Created by IntelliJ IDEA.
  User: ijiyun
  Date: 2024. 12. 12.
  Time: 오전 4:26
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Insert title here</title>
  <style>
    img,label {
      display:inline-block;
    }
    label{
      width:130px
    }
    button{
      background-color:blue;
      color:white;
      font-size:15px
    }
  </style>
</head>
<body>
<div style='width:100%;text-align:center;padding-top:100px'>
  <img src="<%= request.getContextPath() %>/img/snowman.png" height="250" alt="image">
  <form method="post" action="loginOk">
    <div>
      <label>User ID: </label>
      <input type='text' name='userId'/>
    </div>
    <div>
      <label>Password: </label>
      <input type='password' name='password'/>
    </div>
    <button type='submit'>login</button>
  </form>
</div>
</body>
</html>

