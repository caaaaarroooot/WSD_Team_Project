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

    function openBoard(subjectName) {
      if (subjectName) {
        window.location.href = './board/list?subjectName=' + encodeURIComponent(subjectName);
      }
    }


    window.onload = function() {
      const subjectCards = document.querySelectorAll('.subject-card div[style^="background-color"]');
      subjectCards.forEach(function(cardDiv) {
        cardDiv.style.backgroundColor = getRandomColor(); // 랜덤 색상 적용
      });
    }

    // 모달 열기
    function openModal() {
      var myModal = new bootstrap.Modal(document.getElementById('addSubjectModal'));
      myModal.show();
    }
  </script>
</head>
<body>
<div class="header">
  <div style="width: 1200px">
    <a href="./dashboard" style="text-decoration: none"><h1 style="color: white">GGulTip</h1></a>
  </div>
    <div class="headerBtn linkImHeader" onclick="openModal()">Add</div>
    <div class="headerBtn">
      <a href="${pageContext.request.contextPath}/login/logout" class="linkImHeader">Logout</a>
    </div>
  </div>

<!-- 과목 추가 모달 -->
<div class="modal fade" id="addSubjectModal" tabindex="-1" aria-labelledby="addSubjectModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="addSubjectModalLabel">과목 추가</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="addSubjectForm" method="post" action="${pageContext.request.contextPath}/addSubject">
        <label for="subjectName">과목 이름:</label>
          <input type="text" id="subjectName" name="subjectName" class="form-control" placeholder="과목 이름을 입력하세요">
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" onclick="submitForm()">추가</button>
      </div>
    </div>
  </div>
</div>

<script>
  // 과목 추가 함수
  function submitForm() {
    const subjectName = document.getElementById('subjectName').value;
    if (subjectName) {
      // form을 제출하여 서버로 전송
      document.getElementById('addSubjectForm').submit();
    } else {
      alert('과목 이름을 입력해주세요.');
    }
  }
</script>
<div class="grid-container">
  <c:forEach var="subject" items="${subjects}">
    <div class="card subject-card" style="width: 18rem;">
      <div style="background-color: #006bb3; height: 150px; width: 100%" onclick="openBoard('${subject.subjectName}')"></div>
      <div class="card-body">
        <h5 class="card-title" onclick="openBoard('${subject.subjectName}')">
          <c:choose>
            <c:when test="${subject != null}">
              ${subject.subjectName}
            </c:when>
            <c:otherwise>
              No subject available
            </c:otherwise>
          </c:choose>
        </h5>
        <!-- 버튼 추가 -->
        <div style="display: flex; justify-content: space-between; margin-top: 10px;">
          <button class="btn btn-sm btn-primary" onclick="editSubject('${subject.subjectName}')">Edit</button>
          <button class="btn btn-sm btn-danger" onclick="deleteSubject('${subject.subjectName}')">Delete</button>
        </div>
      </div>
    </div>
  </c:forEach>
</div>

<script>
  // 과목 수정 함수
  function editSubject(subjectName) {
    const newSubjectName = prompt("새로운 과목 이름을 입력하세요:", subjectName);  // 기존 과목 이름을 기본값으로 사용

    if (newSubjectName && newSubjectName !== subjectName) {  // 입력값이 비어있지 않고, 기존 과목명과 다를 때만 수정
      // 폼 데이터를 URL 인코딩 형식으로 준비
      const formData = new URLSearchParams();
      formData.append('oldSubjectName', subjectName);
      formData.append('newSubjectName', newSubjectName);

      // 수정 요청을 서버로 전송
      fetch("${pageContext.request.contextPath}/editSubject", {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: formData.toString()  // URL 인코딩된 폼 데이터 전송
      })
              .then(response => {
                if (response.ok) {
                  alert("과목이 수정되었습니다.");
                  // 수정 후 페이지 새로고침하거나 UI 갱신
                  location.reload();
                } else {
                  alert("과목 수정에 실패했습니다. 다시 시도해 주세요.");
                }
              })
              .catch(error => {
                alert("서버 오류가 발생했습니다. 다시 시도해 주세요.");
                console.error('Error:', error);
              });
    } else {
      alert("과목 이름이 변경되지 않았습니다.");
    }
  }


  // 과목 삭제 함수
  function deleteSubject(subjectName) {
    if (subjectName && confirm("이 과목을 삭제하시겠습니까?")) {
      // 폼 데이터를 URL 인코딩 형식으로 준비
      const formData = new URLSearchParams();
      formData.append('subjectName', subjectName);

      // 삭제 요청을 서버로 전송
      fetch("${pageContext.request.contextPath}/deleteSubject", {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: formData.toString()  // URL 인코딩된 폼 데이터 전송
      })
              .then(response => {
                if (response.ok) {
                  alert("과목이 삭제되었습니다.");
                  // 삭제 후 페이지 새로고침하거나 UI 갱신
                  location.reload();
                } else {
                  alert("과목 삭제에 실패했습니다. 다시 시도해 주세요.");
                }
              })
              .catch(error => {
                alert("서버 오류가 발생했습니다. 다시 시도해 주세요.");
                console.error('Error:', error);
              });
    }
  }


  // 과목 추가 함수 (추가된 과목은 페이지에 표시되도록 구현 가능)
  function addSubject() {
    const subjectName = document.getElementById('subjectName').value;
    if (subjectName) {
      // 여기서 추가된 과목을 처리하는 로직 추가 (예: 서버로 전송)
      console.log('Added subject:', subjectName);

      // 모달 닫기
      var myModal = bootstrap.Modal.getInstance(document.getElementById('addSubjectModal'));
      myModal.hide();

      // 새 과목이 추가되었을 때 UI 갱신 (여기서는 콘솔에 출력만 했지만 실제 구현 시 반영)
      // 예: 서버에서 과목 목록을 다시 불러와서 화면 갱신
    } else {
      alert('과목 이름을 입력해주세요.');
    }
  }
</script>

</body>
</html>
