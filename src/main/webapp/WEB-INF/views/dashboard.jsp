<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
  <title>Dashboard</title>
  <style>
    .grid-container {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
      gap: 20px;
    }
    .subject-card {
      border: 1px solid #ddd;
      padding: 15px;
      text-align: center;
      cursor: pointer;
    }
  </style>
  <script>
    function openBoard(card) {
      const subjectName = card.getAttribute("data-subject");
      if (subjectName) {
        window.location.href = './board/list';
      }
    }
  </script>
</head>
<body>
<h1>My Subjects</h1>

<!-- subject size 출력 -->
<h3>Size of subjects list: ${subjectsSize}</h3>

<div class="grid-container">
  <c:forEach var="subject" items="${subjects}">
    <div class="subject-card" data-subject="${subject.subjectName}" onclick="openBoard(this)">
      <h3>
        <c:choose>
          <c:when test="${subject != null}">
            ${subject.subjectName}
          </c:when>
          <c:otherwise>
            No subject available
          </c:otherwise>
        </c:choose>
      </h3>
    </div>
  </c:forEach>
</div>
</body>
</html>
