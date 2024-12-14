<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 상세</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script>
        function likePost(postId) {
            if (!postId) {
                console.error("유효하지 않은 게시글 ID:", postId);
                alert("게시글 ID가 유효하지 않습니다.");
                return;
            }

            fetch(`/board/like/${postId}`, { method: 'POST' })
                .then(response => {
                    if (!response.ok) throw new Error("좋아요 요청 실패");
                    return response.json();
                })
                .then(data => {
                    if (data.success) {
                        document.getElementById('likeCount').innerText = data.likes;
                    } else {
                        alert("좋아요 요청 실패: " + data.error);
                    }
                })
                .catch(error => {
                    alert("서버와의 통신 중 문제가 발생했습니다.");
                    console.error("Error:", error);
                });
        }

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
                            window.location.href = '/dashboard';
                        } else {
                            alert("게시물 삭제 실패. 다시 시도하세요.");
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
<div class="container mt-5">
    <div class="mb-4 text-center">
        <h1>${board.title}</h1>
        <p class="text-muted">작성자: ${board.userid} | 작성일: ${board.regdate}</p>
    </div>

    <div class="mb-4">
        <p>${board.contents}</p>
    </div>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <button class="btn btn-primary" onclick="likePost(${board.id})">
            좋아요 <span class="badge bg-light text-dark" id="likeCount">${board.like}</span>
        </button>
        <button class="btn btn-secondary" onclick="goBack()">목록으로 돌아가기</button>
        <a href="${pageContext.request.contextPath}/board/edit/${board.id}" class="btn btn-warning">수정</a>
        <button class="btn btn-danger" onclick="deletePost()">삭제</button>
    </div>
</div>
</body>
</html>