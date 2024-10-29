<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="sample.project.dto.UserInfoDTO" %>
<%@ page import="sample.project.util.CmmUtil" %>
<%@ page import="sample.project.util.EncryptUtil" %>
<%
    String ssUserName = CmmUtil.nvl((String) session.getAttribute("SS_USER_NAME")); // 로그인된 회원 이름
    String ssPhoneNum = EncryptUtil.decAES128CBC(CmmUtil.nvl((String) session.getAttribute("SS_PHONE_NUM"))); // 로그인된 회원 휴대전화번호
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>마이페이지</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <link rel="stylesheet" href="/css/main.css"/>
    <script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>
        <script type="text/javascript">
            // HTML로딩이 완료되고, 실행됨
            $(document).ready(function () {
                // 버튼 클릭했을때, 발생되는 이벤트 생성함(onclick 이벤트와 동일함)
                $("#btnDelete").on("click", function () {
                    location.href = "/user/delete";
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
        <img width="105" src="/logo5.png" alt="REMENTIA 로고" style="margin-right: 0%;">
        <h1><a href="/index" id="logo5.png">REMENTIA</a></h1>

        <!-- Nav -->
        <nav id="nav">
        <ul>
            <li class="current"><a href="/index"><strong>Home</strong></a></li>
            <li><a href="/test/start" style="color: white;"><strong>진단하기</strong></a></li>
            <li><a href="/test/resultList" style="color: white;"><strong>진단결과보기</strong></a></li>
            <li><a href="/train/start" style="color: white;"><strong>뇌건강트레이너</strong></a></li>
        </ul>
        </nav>

        </div>

        <!-- 마이페이지 컨테이너 -->
        <div class="mypage-container" style="max-width: 700px; margin: auto; padding: 20px; background-color: #fff; box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); border-radius: 10px; margin-bottom: 3%;">

        <!-- 마이페이지 타이틀 및 사용자 정보 -->
        <section class="wrapper style1">
        <div class="container">
        <h2 style="text-align: center;">마이페이지</h2>
        <div style="text-align: center; margin-bottom: 20px;">
        <h3>이름: &emsp; <%=ssUserName%></h3> <!-- 로그인된 사용자의 이름 -->
        <h3>휴대전화번호: &emsp; <%=ssPhoneNum%></h3> <!-- 로그인된 사용자의 핸드폰 번호 -->
        </div>

        <div class="row gtr-200" style="padding: 9%;">

        <!-- 진단 결과 -->
        <section class="col-6 col-12-narrower">
        <div class="box highlight" onclick="location.href='/test/resultList';" style="cursor: pointer;">
        <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" fill="currentColor" class="bi bi-clipboard2-data" viewBox="0 0 16 16">
        <path d="M9.5 0a.5.5 0 0 1 .5.5.5.5 0 0 0 .5.5.5.5 0 0 1 .5.5V2a.5.5 0 0 1-.5.5h-5A.5.5 0 0 1 5 2v-.5a.5.5 0 0 1 .5-.5.5.5 0 0 0 .5-.5.5.5 0 0 1 .5-.5z"/>
        <path d="M3 2.5a.5.5 0 0 1 .5-.5H4a.5.5 0 0 0 0-1h-.5A1.5 1.5 0 0 0 2 2.5v12A1.5 1.5 0 0 0 3.5 16h9a1.5 1.5 0 0 0 1.5-1.5v-12A1.5 1.5 0 0 0 12.5 1H12a.5.5 0 0 0 0 1h.5a.5.5 0 0 1 .5.5v12a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5z"/>
        <path d="M10 7a1 1 0 1 1 2 0v5a1 1 0 1 1-2 0zm-6 4a1 1 0 1 1 2 0v1a1 1 0 1 1-2 0zm4-3a1 1 0 0 0-1 1v3a1 1 0 1 0 2 0V9a1 1 0 0 0-1-1"/>
        </svg>
        <h3 style="margin-top: 5%;">진단결과보기</h3>

        </div>
        </section>

        <!-- 두뇌 훈련 결과 -->
        <section class="col-6 col-12-narrower">
        <div class="box highlight" onclick="location.href='/train/resultList';" style="cursor: pointer;">
        <img width="80" src="/logo4.jpg" alt="뇌건강트레이너 로고">
        <h3 style="margin-top: 5%;">트레이닝결과보기</h3>

        </div>
        </section>

        </div>

        <!-- 회원 탈퇴 버튼 -->
        <div class="row gtr-200" style="text-align: center;">
        <section class="col-12">
        <button id="btnDelete" style="background-color: #37c0fb; color: white; width: 40%; padding: 8px; margin-top: 20px; display: inline-block;" type="button" class="btn btn-primary">회원탈퇴</button>
        </section>
        </div>

        </div>
        </section>

        </div> <!-- 마이페이지 컨테이너 끝 -->

    </div>
</body>
</html>