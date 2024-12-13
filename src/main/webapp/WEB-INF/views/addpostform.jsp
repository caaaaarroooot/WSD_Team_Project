<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>New Post</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script>
        const validate = (event) => {
            event.preventDefault();

            const form = document.querySelector('form');
            const inputs = document.querySelectorAll('input, textarea');

            let isValid = true;

            inputs.forEach(input => {
                if (!input.checkValidity()) {
                    input.reportValidity();
                    isValid = false;
                }
            });

            if (isValid) {
                alert("게시물이 추가됩니다.");
                form.submit();
            }
        };
    </script>
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

        .validate-note {
            visibility: hidden;
        }

        .invalid-form input:invalid {
            border: 1px solid red;
        }

        .invalid-form input:invalid+.invalid-note {
            visibility: visible;
        }

        form {
            background-color: #f9f9f9;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            margin: 20px auto;
        }

        form input,
        form select,
        form textarea {
            background-color: #ffffff;
            border: 1px solid #ced4da;
            padding: 12px;
            border-radius: 5px;
            font-size: 1rem;
            margin-bottom: 15px;
        }

        form input:focus,
        form select:focus,
        form textarea:focus {
            border-color: #80bdff;
            outline: 0;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.25);
        }

        form label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
        }

        textarea#custom_textarea {
            height: 250px;
        }

        .validate-note {
            color: red;
            font-size: 0.85rem;
            margin-top: -10px;
            margin-bottom: 10px;
        }

        input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-size: 1rem;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="header">
    <div style="width: 1200px">
        <a href="../dashboard" style="text-decoration: none"><h1 style="color: white">GGulTip</h1></a>
    </div>
    <div class="headerBtn linkImHeader" onclick="openModal()">Add</div>
    <div class="headerBtn">
        <a href="${pageContext.request.contextPath}/login/logout" class="linkImHeader">Logout</a>
    </div>
</div>


<form method="post" action="<%= request.getContextPath() %>/board/addok">
    <div class="row mb-3">
        <h2>새 글 작성</h2>
        <div class="col-md-6">
            <label for="title">제목</label>
            <input type="text" class="form-control" id="title" name="title" placeholder="제목" required />
            <div class="validate-note">제목이 입력되지 않았습니다.</div>
        </div>
    </div>

    <div class="row mb-3">
        <div class="col-md-6">
            <label for="userid">작성자</label>
            <input type="text" class="form-control" id="userid" name="userid" placeholder="작성자" required />
            <div class="validate-note">작성자 이름을 입력하세요.</div>
        </div>
    </div>

    <div class="mb-3">
        <label for="contents">내용</label>
        <textarea class="form-control" id="contents" name="contents" placeholder="내용" rows="10" required></textarea>
        <div class="validate-note">내용을 입력하세요.</div>
    </div>

    <div class="d-flex justify-content-end">
        <input type="submit" value="추가" class="btn btn-primary" onclick="validate(event)" />
    </div>
</form>

</body>
</html>