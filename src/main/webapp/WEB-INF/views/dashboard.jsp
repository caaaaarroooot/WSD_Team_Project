<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
  <title>Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
  <style>
    body{
      width: 100vw;
      height: 100vh;
      box-sizing: border-box;
      padding: 30px;
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    .grid-container {
      display: grid;
      grid-template-columns: repeat(4, minmax(200px, 1fr));
      gap: 20px;
    }
    .subject-card {
      cursor: pointer;
    }
  </style>
  <script>
    // 랜덤 색상을 생성하는 함수
    function getRandomColor() {
      const letters = '0123456789ABCDEF';
      let color = '#';
      for (let i = 0; i < 6; i++) {
        color += letters[Math.floor(Math.random() * 16)];
      }
      return color;
    }

    function openBoard(card) {
      const subjectName = card.getAttribute("data-subject");
      if (subjectName) {
        // subjectName을 쿼리 파라미터로 전달
        window.location.href = './board/list?subjectName=' + encodeURIComponent(subjectName);
      }
    }

    window.onload = function() {
      const subjectCards = document.querySelectorAll('.subject-card div[style^="background-color"]');
      subjectCards.forEach(function(cardDiv) {
        cardDiv.style.backgroundColor = getRandomColor(); // 랜덤 색상 적용
      });
    }
  </script>
</head>
<body>
<div style="width: 100%; display: flex; flex-direction: row; justify-content: space-between">
  <h1>GGulTip - Dashboard</h1>
  <button>추가</button>
</div>
<div class="grid-container">
  <c:forEach var="subject" items="${subjects}">
    <div class="card subject-card" style="width: 18rem;" data-subject="${subject.subjectName}" onclick="openBoard(this)">
      <div style="background-color: #006bb3; height: 150px; width: 100%"></div>
      <div class="card-body">
        <h5 class="card-title">
          <c:choose>
            <c:when test="${subject != null}">
              ${subject.subjectName}
            </c:when>
            <c:otherwise>
              No subject available
            </c:otherwise>
          </c:choose>
        </h5>
      </div>
    </div>
  </c:forEach>
</div>
</body>
</html>
