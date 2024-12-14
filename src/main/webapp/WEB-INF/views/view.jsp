<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 상세</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
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
        .top-buttons {
            background-color: #f8f9fa;
            padding: 10px 20px;
            border-bottom: 1px solid #ddd;
        }
        .post-title {
            font-size: 1.8rem;
            font-weight: bold;
        }
        .post-meta {
            font-size: 0.9rem;
            color: #6c757d;
        }
        .post-content {
            margin-top: 20px;
            font-size: 1.1rem;
        }
        .post-footer {
            margin-top: 30px;
            font-size: 0.9rem;
            text-align: right;
            color: #6c757d;
        }
    </style>

    <script>
        // 게시글 삭제 기능
        function deletePost() {
            console.log("helloworld");

            if (confirm("이 게시글을 삭제하시겠습니까?")) {
                fetch(`${pageContext.request.contextPath}/board/delete/${board.id}`, {
                    method: 'POST'
                })
                    .then(response => {
                        if (response.ok) {
                            alert("게시물이 삭제되었습니다.");
                            // 삭제 후 대시보드 페이지로 이동
                            window.location.href = '${pageContext.request.contextPath}/board/list?subjectName=${board.subject}';
                        } else {
                            alert("게시물이 삭제되었습니다. - response.no");
                            window.location.href = '${pageContext.request.contextPath}/board/list?subjectName=${board.subject}';
                        }
                    })
                    .catch(error => {
                        alert("서버와의 통신 중 문제가 발생했습니다.");
                        console.error("Error:", error);
                    });
            }
        }



        function goBack() {
            window.location.href = "${pageContext.request.contextPath}/board/list?subjectName=${board.subject}";
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

<div class="container mt-4">
    <!-- 상단 버튼 섹션 -->
    <div class="top-buttons d-flex justify-content-between align-items-center">
        <a href="${pageContext.request.contextPath}/board/list?subjectName=${board.subject}" class="btn btn-secondary">목록으로 이동</a>
        <div>
            <!-- 수정 및 삭제 버튼: 로그인 유저와 게시글 작성자가 동일할 경우에만 표시 -->
            <c:if test="${sessionScope.userId eq board.userid}">
                <a href="${pageContext.request.contextPath}/board/edit/${board.id}" class="btn btn-warning">
                    <i class="bi bi-pencil-square"></i> 수정
                </a>
                <button class="btn btn-danger" onclick="deletePost(${board.id})">
                    <i class="bi bi-trash"></i> 삭제
                </button>
            </c:if>
        </div>
    </div>

    <!-- 게시글 상세 -->
    <div class="mt-4">
        <h1 class="post-title">${board.title}</h1>
        <p class="post-meta">작성자: ${board.userid} | 작성일: ${board.regdate}</p>
        <p class="post-content">${board.contents}</p>
    </div>

    <!-- 조회수 -->
    <div class="post-footer">
        조회수: ${board.view}
    </div>
</div>
</body>
</html>