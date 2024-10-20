<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" href="/css/main.css"/>
    <script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">

        // HTML로딩이 완료되고, 실행됨
        $(document).ready(function () {

            // 회원가입
            $("#btnUserReg").on("click", function () { // 버튼 클릭했을때, 발생되는 이벤트 생성함(onclick 이벤트와 동일함)
                location.href = "/user/userRegForm";
            })

            // 아이디 찾기
            $("#btnSearchPhoneNum").on("click", function () { // 버튼 클릭했을때, 발생되는 이벤트 생성함(onclick 이벤트와 동일함)
                location.href = "/user/searchPhoneNum";
            })

            // 비밀번호 찾기
            $("#btnSearchPassword").on("click", function () { // 버튼 클릭했을때, 발생되는 이벤트 생성함(onclick 이벤트와 동일함)
                location.href = "/user/searchPassword";
            })

            // 로그인
            $("#btnLogin").on("click", function () {
                let f = document.getElementById("f"); // form 태그

                if (f.phoneNum.value === "") {
                    alert("휴대전화 번호를 입력하세요.");
                    f.phoneNum.focus();
                    return;
                }

                if(isNaN(f.phoneNum.value)){
                    alert("휴대전화 번호를 숫자로만 입력해 주세요.")
                    f.phoneNum.focus();
                    return;
                }

                if (f.password.value === "") {
                    alert("비밀번호를 입력하세요.");
                    f.password.focus();
                    return;
                }

                // Ajax 호출해서 로그인하기
                $.ajax({
                        url: "/user/loginProc",
                        type: "post", // 전송방식은 Post
                        dataType: "JSON", // 전송 결과는 JSON으로 받기
                        data: $("#f").serialize(), // form 태그 내 input 등 객체를 자동으로 전송할 형태로 변경하기
                        success: function (json) { // /notice/noticeUpdate 호출이 성공했다면..

                            if (json.result === 1) { // 로그인 성공
                                alert(json.msg); // 메시지 띄우기
                                location.href = "/user/loginResult"; // 로그인 성공 페이지 이동

                            } else { // 로그인 실패
                                alert(json.msg); // 메시지 띄우기
                                $("#phoneNum").focus(); // 아이디 입력 항목에 마우스 커서 이동
                            }

                        }
                    }
                )

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
    <h2>로그인</h2>
    <h2></h2>
    <form id="f">
        <div>
            <label for="phoneNum">아이디(휴대전화번호)</label>
            <input type="text" id="phoneNum" name="phoneNum" placeholder="휴대전화번호( - 없이 입력 )" required>

            <label for="password">비밀번호</label>
            <input type="password" id="password" name="password" placeholder="비밀번호" autocomplete="new-password" style="margin-bottom: 7%;" required>
            <button id="btnLogin" type="button" class="btn btn-primary" style ="margin-top: 3%; width:100%">로그인</button>
        </div>
        <div style="margin-top: 3%; margin-bottom: 10%">
            <button id="btnUserReg" type="button" class="btn btn-primary">회원가입</button>
            <button id="btnSearchPhoneNum" type="button" class="btn btn-primary">아이디 찾기</button>
            <button id="btnSearchPassword" type="button" class="btn btn-primary">비밀번호 찾기</button>
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