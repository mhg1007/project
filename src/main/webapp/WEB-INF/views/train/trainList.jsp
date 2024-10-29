<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="sample.project.dto.UserInfoDTO" %>
<%@ page import="sample.project.util.CmmUtil" %>
<%@ page import="sample.project.util.EncryptUtil" %>
<%
    String ssUserName = CmmUtil.nvl((String) session.getAttribute("SS_USER_NAME")); // 로그인된 회원 이름
    String ssPhoneNum = EncryptUtil.decAES128CBC(CmmUtil.nvl((String) session.getAttribute("SS_PHONE_NUM"))); // 로그인된 회원 휴대전화번호
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>트레이닝 목록</title>
    <link rel="stylesheet" href="/css/main.css"/>
    <script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">

        // HTML로딩이 완료되고, 실행됨
        $(document).ready(function () {
            // 해당 트레이닝으로 이동
            $("#btnTrain1").on("click", function () { // 버튼 클릭했을때, 발생되는 이벤트 생성함(onclick 이벤트와 동일함)
                location.href = "/train/train1";
            })
            $("#btnTrain2").on("click", function () { // 버튼 클릭했을때, 발생되는 이벤트 생성함(onclick 이벤트와 동일함)
                location.href = "/train/train2";
            })
            $("#btnTrain3").on("click", function () { // 버튼 클릭했을때, 발생되는 이벤트 생성함(onclick 이벤트와 동일함)
                location.href = "/train/train3";
            })
        })
    </script>
</head>
<body class="is-preload">
    <div id="page-wrapper">
        <!-- Header -->
        <div id="header">
            <div id="authed" style="position:absolute; right: 10px; bottom: 93%; display: flex; flex-direction: row;">
                <div><%=ssUserName%>님 환영합니다 &emsp; </div>

                <a href="/user/myPage" style="color: white;">
                <button style ="background-color: #37c0fb; width:100%; margin-right: 5px;" type="button" class="btn btn-primary">마이페이지</button></a>

                <a href="/user/logout" style="color: white;">
                <button style ="background-color: #37c0fb; width:100%; margin-left: 5px;" type="button" class="btn btn-primary" id="btnLogOut">로그아웃</button></a>
        </div>

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

    <div>
    <div class="login-container" style = "margin : auto; margin-top: 3%; margin-bottom: 5%;">
    <h2>트레이닝 선택하기</h2>
    <h2></h2>
        <button id="btnTrain1" type="button" class="btnTL">트레이닝 1<br />도형 셋 숫자 셋</button>
        <button id="btnTrain2" type="button" class="btnTL">트레이닝 2<br />색깔 짝 맞추기</button>
        <button id="btnTrain3" type="button" class="btnTL">트레이닝 3<br />숫자 퀴즈</button>
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
            .btnTL{
                margin-top: 4%;
                margin-bottom: 4%;
                width: 45%;
                height: 75px;
                font-size: large;
                font-weight: bold;
                line-height: normal;
            }
            h2 {
                margin-bottom: 20px;
            }
            label, input {
                display: block;
                width: 100%;
                margin-bottom: 15px;
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