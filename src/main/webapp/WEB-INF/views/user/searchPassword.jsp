<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>비밀번호 찾기</title>
    <link rel="stylesheet" href="/css/main.css"/>
    <script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">

        // SMS 인증번호 발송 값
        let smsAuthNumber = "";

        // 핸드폰 인증번호 확인여부 (확인 Y / 확인안됨 N)
        let phoneNumAuthCheck = "N";

        // HTML로딩이 완료되고, 실행됨
        $(document).ready(function () {

            let f = document.getElementById("f"); // form 태그

            // 핸드폰 번호 체크 및 인증번호 발송
            $("#btnPhoneNum").on("click", function () { // 버튼 클릭했을때, 발생되는 이벤트 생성함(onclick 이벤트와 동일함)
                phoneNumExists(f)
            })

            //인증번호 확인
            $("#btnPhoneNumAuth").on("click", function () { // 버튼 클릭했을때, 발생되는 이벤트 생성함(onclick 이벤트와 동일함)
                phoneNumAuth(f)
            })

            // 비밀번호  찾기
            $("#btnSearchPassword").on("click", function () {
                searchPassword(f)

                f.method = "post"; // 비밀번호 찾기 정보 전송 방식
                f.action = "/user/searchPasswordProc" // 비밀번호 찾기 URL

                f.submit(); // 아이디 찾기 정보 전송하기
            })
        })

        // 회원 핸드폰 번호 중복 체크
        function phoneNumExists(f) {

            if (f.phoneNum.value === "") {
                alert("핸드폰 번호를 입력하세요.");
                f.phoneNum.focus();
                return;
            }

            if(isNaN(f.phoneNum.value)){
                alert("핸드폰 번호를 숫자로만 입력해 주세요.")
                f.phoneNum.focus();
                return;
            }

            // Ajax 호출해서 회원가입하기
            $.ajax({
                    url: "/user/getPhoneNumExists2",
                    type: "post", // 전송방식은 Post
                    dataType: "JSON", // 전송 결과는 JSON으로 받기
                    data: $("#f").serialize(), // form 태그 내 input 등 객체를 자동으로 전송할 형태로 변경하기
                    success: function (json) { // 호출이 성공했다면..

                        if (json.existsYn === "Y") {
                            alert("인증번호가 발송되었습니다.");
                            smsAuthNumber=json.authNumber;
                        } else {
                            alert("가입되지 않은 번호입니다.");
                            f.phoneNum.focus();
                        }
                    }
                }
            )
        }

        // 인증번호 확인
        function phoneNumAuth(f) {

            if (smsAuthNumber === "") {
                alert("인증번호 받기를 먼저 진행해 해주세요.");
                f.phoneNum.focus();
                return;
            }

            if (f.authNumber.value === "") {
                alert("인증번호를 입력하세요.");
                f.authNumber.focus();
                return;
            }

            if (f.authNumber.value == smsAuthNumber) {
                alert("인증 확인 되었습니다.");
                phoneNumAuthCheck="Y";
            }
            else {
                alert("인증번호가 일치하지 않습니다. 다시 확인해 주세요.");
                f.authNumber.focus();
            }

        }

        //회원가입 정보의 유효성 체크하기
        function searchPassword(f) {

            if (f.phoneNum.value === "") {
                alert("핸드폰 번호를 입력하세요.");
                f.phoneNum.focus();
                return;
            }

            if(isNaN(f.phoneNum.value)){
                alert("핸드폰 번호를 숫자로만 입력해 주세요.")
                f.phoneNum.focus();
                return;
            }

            if (phoneNumAuthCheck !== "Y") {
                alert("인증번호 확인을 진행해 해주세요.");
                f.authNumber.focus();
                return;
            }

            if (f.userName.value === "") {
                alert("이름을 입력하세요.");
                f.userName.focus();
                return;
            }

            if (f.authNumber.value === "") {
                alert("인증번호를 입력하세요.");
                f.authNumber.focus();
                return;
            }

            f.method = "post"; // 비밀번호 찾기 정보 전송 방식
            f.action = "/user/searchPasswordProc" // 비밀번호 찾기 URL

            f.submit(); // 아이디 찾기 정보 전송하기
        }

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
    </div>

    <!-- 로그인 폼 컨테이너 -->
    <div>
        <div class="login-container" style = "margin : auto; margin-top: 3%; margin-bottom: 5%;">
        <h2>비밀번호 찾기</h2>
        <h2></h2>
        <form id="f" style = "text-align: left;" >
            <div>
                <label for="phoneNum">아이디(휴대전화번호)</label>
                <div class="input-with-button" style="display: flex;">
                    <input type="text" style="width:70%; margin-right:5%; " id="phoneNum" name="phoneNum" placeholder="휴대전화번호( - 없이 입력 )" required>
                    <button id="btnPhoneNum" style="float:right; height: 44px;" type="button" class="btn-small">인증번호 받기</button>
                </div>

                <label for="authNumber">인증번호</label>
                <div class="input-with-button" style="display: flex;">
                    <input type="text" style="width:70%; margin-right:5%;" id="authNumber" name="authNumber" placeholder="인증번호 6자리를 입력해주세요" required>
                    <button id="btnPhoneNumAuth" style="float:right; height: 44px;" type="button" class="btn-small">인증번호 확인</button>
                </div>

                <label for="userName">이름</label>
                <input type="text" id="userName" name="userName" placeholder="이름을 입력하세요" required>
            </div>
            <button id="btnSearchPassword" style ="width:100%; margin-top:10%;" type="button">비밀번호 찾기</button>
        </form>
        </div>
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
          width: 100%;
          margin-bottom: 20px
        }

        input#phoneNumber {
            width : 65%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 20px;
            display: inline;
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
</form>
</body>
</html>

