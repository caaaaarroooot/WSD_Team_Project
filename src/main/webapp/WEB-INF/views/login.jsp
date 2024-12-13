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
    input{
      width: 90%;
      border: 1px solid #E2E2E2;
      box-sizing: border-box;
      padding: 5px;
      height: 50px;
      font-size: 17px;
      margin-top: 30px;
    }
    button{
      box-sizing: border-box;
      width: 45%;
      height: 50px;
      margin-top: 30px;
      font-size: 25px;
      opacity: 0.8;
      border: none;
      border-radius: 5px;
      color: white;
    }
    button:hover{
      cursor: pointer;
    }
  </style>
</head>
<body>
<div class="header">
    <h1 style="color: white">GGulTip</h1>
</div>
<div style='margin-top:100px; height: 400px; width:30%;text-align:center;padding-top:50px; border: 1px #EAEAEA solid'>
  <h1 style="color: #626466">로그인</h1>
  <form method="post" action="loginOk">
    <div>
      <input type='text' name='userId'placeholder="아이디"/>
    </div>
    <div>
      <input type='password' name='password' placeholder="비밀번호"/>
    </div>
    <hr style="width: 90%; border: 1px solid #E2E2E2; margin-top: 30px"/>
    <div style="width: 80%; display: flex; justify-content: space-between; margin: auto">
      <button style="background-color: rgb(48, 23, 5);" type='submit'>login</button>
      <button style="background-color: #dddddd;" type='button'>회원가입</button>
    </div>
  </form>
</div>
</body>
</html>

