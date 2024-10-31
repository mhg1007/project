<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="sample.project.dto.UserInfoDTO" %>
<%@ page import="sample.project.util.CmmUtil" %>
<%@ page import="sample.project.util.EncryptUtil" %>
<%
    String ssUserName = CmmUtil.nvl((String) session.getAttribute("SS_USER_NAME")); // 로그인된 회원 이름
    String ssPhoneNum = EncryptUtil.decAES128CBC(CmmUtil.nvl((String) session.getAttribute("SS_PHONE_NUM"))); // 로그인된 회원 휴대전화번호
    String phoneNumLast=ssPhoneNum.substring(ssPhoneNum.length()-4,ssPhoneNum.length());
%>
<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>로그인 성공</title>
    <link rel="stylesheet" href="/css/main.css"/>
    <script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">

        // HTML로딩이 완료되고, 실행됨
        $(document).ready(function () {
            // 버튼 클릭했을때, 발생되는 이벤트 생성함(onclick 이벤트와 동일함)
            $("#btnSend").on("click", function () {
                location.href = "/index";
            })
        })
    </script>
</head>
<body class="is-preload">
    <div id="page-wrapper">
        <!-- Header -->
        <div id="header">

        <!-- Logo -->
        <img  width="105"  src = "/logo5.png" alt="REMENTIA 로고" style="margin-right: 0% ;">
        <h1><a href="/index" id="logo5">REMENTIA</a></h1>

        <!-- Nav -->
        <nav id="nav">
            <ul>
                <li class="current"><a href="/index">Home</a></li>
                <li><a href="/test/start" style="color: white;"><strong>진단하기</strong></a></li>
                <li><a href="/test/resultList" style="color: white;"><strong>진단결과보기</strong></a></li>
                <li><a href="/train/start" style="color: white;"><strong>뇌건강트레이너</strong></a></li>
            </ul>
        </nav>
    </div>
    <div class="login-container" style = "margin : auto; margin-top: 3%; margin-bottom: 5%;">
        <div style="margin-top:30%; margin-bottom:30%;">
            <div><%=ssUserName%> (<%=phoneNumLast%>) 님 </div>
            <div>로그인 되었습니다</div>
        </div>
        <button id="btnSend" type="button">메인 화면 이동</button>
    </div>
<div>
</div>
<br/><br/>

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
