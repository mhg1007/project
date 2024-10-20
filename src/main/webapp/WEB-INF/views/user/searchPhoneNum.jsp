<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>휴대전화번호찾기</title>
    <link rel="stylesheet" href="/css/main.css"/>
    <script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">

        // HTML로딩이 완료되고, 실행됨
        $(document).ready(function () {

            // 핸드폰 번호 찾기
            $("#btnSearchPhoneNum").on("click", function () {
                let f = document.getElementById("f"); // form 태그

                if (f.userName.value === "") {
                    alert("이름을 입력하세요.");
                    f.userName.focus();
                    return;
                }

                f.method = "post"; // 아이디 찾기 정보 전송 방식
                f.action = "/user/searchPhoneNumProc" // 아이디 찾기 URL

                f.submit(); // 아이디 찾기 정보 전송하기
            })


        })
    </script>
</head>
<body class="is-preload">
    <div id="page-wrapper">
        <!-- Header -->
        <div id="header">
            <div id="auth" style="position:absolute; right: 10px; bottom: 93%; display: flex; flex-direction: row;">
                <a href="/user/userRegForm" style="color: white;">
                <button style ="background-color: #37c0fb; width:100%; margin-right: 5px;" type="button" class="btn btn-primary">회원가입</button></a>

                <a href="/user/login" style="color: white;">
                <button style ="background-color: #37c0fb; width:100%; margin-left: 5px;" type="button" class="btn btn-primary">로그인</button></a>
            </div>

        <!-- Logo -->
        <img  width="105"  src = "/logo5.png" style="margin-right: 0% ;">
        <h1><a href="/index" id="logo5">REMENTIA</a></h1>

        <!-- Nav -->
        <nav id="nav">
            <ul>
            <li class="current"><a href="/index">Home</a></li>
            <li>
            <a href="/test/start" style="color: white;"><strong>진단하기</strong></a>
            </li>
            <li><a href="left-sidebar.html" style="color: white;"><strong>진단결과보기</strong></a></li>
            <li><a href="right-sidebar.html" style="color: white;"><strong>뇌건강트레이너</strong></a></li>
            </ul>
        </nav>
    </div>


    <!-- 로그인 폼 컨테이너 -->
    <div>
        <div class="login-container" style = "margin : auto; margin-top: 3%; margin-bottom: 5%;">
        <h2>아이디(휴대전화번호) 찾기</h2>
        <h2></h2>
        <form id="f" style="margin-top: 5%; margin-bottom: 5%; padding-left: 5%; padding-right: 5%;">
            <div style="margin-top: 6%; margin-bottom: 15%">
                <label for="userName">이름</label>
                <input type="text" id="userName" name="userName" placeholder="이름을 입력해 주세요" required>
                <button id="btnSearchPhoneNum" type="button" class="btn btn-primary" style=" width:100%; margin-top: 10%;">아이디(휴대전화번호) 찾기</button>
            </div>
        </form>
    </div>
    <style>
            body {
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
                font-family: Arial, sans-serif;
                height: 100vh;
                display: flex;
                flex-direction: column;
            }
            .container {
                flex-grow: 1;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                padding-top: 100px; /* 헤더 높이를 고려한 여백 */
            }

            .login-container {
              width: 560px;
              padding: 20px;
              background-color: white;
              box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
              border-radius: 20px;
              display: flex;
              flex-direction: column;
              justify-content: center;
              align-items: center;
            }
            h2 {
                margin-bottom: 20px;
            }
            form {
                display: flex;
                flex-direction: column;
                width: 100%;
            }
            label, input {
                display: block;
                width: 100%;
                margin-bottom: 15px;
            }
            input[type="number"],
            input[type="text"],
            input[type="password"] {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            input[type="submit"] {
                padding: 10px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }


            input[type="submit"] {
                padding: 10px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            .extra-links {
                margin-top: 15px;
            }

            .extra-links a {
                text-decoration: none;
                color: #007bff;
            }

            .extra-links a:hover {
                text-decoration: underline;
            }
    </style>
</body>
</html>