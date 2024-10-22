<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="sample.project.dto.UserInfoDTO" %>
<%@ page import="sample.project.util.CmmUtil" %>
<%@ page import="sample.project.util.EncryptUtil" %>
<%
    String ssUserName = CmmUtil.nvl((String) session.getAttribute("SS_USER_NAME")); // 로그인된 회원 이름
    String ssPhoneNum = EncryptUtil.decAES128CBC(CmmUtil.nvl((String) session.getAttribute("SS_PHONE_NUM"))); // 로그인된 회원 휴대전화번호
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>회원 탈퇴</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <link rel="stylesheet" href="/css/main.css" />
    <script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {

            let f = document.getElementById("f"); // form 태그

            $("#btnConfirm").on("click", function () { // 버튼 클릭했을때, 발생되는 이벤트 생성함(onclick 이벤트와 동일함)
                confirmDeletion(f)
            })
        })

        function confirmDeletion(f) {
            if (f.password.value === "") {
                alert("비밀번호를 입력해주세요.");
                return;
            }

            var confirmDelete = confirm("정말로 탈퇴하시겠습니까?");

            if (confirmDelete) {
                // 실제 서버로 요청을 보내는 코드 (Ajax)
                $.ajax({
                    url: "/user/deleteProc",
                    type: "post",
                    dataType: "JSON",
                    data: $("#f").serialize(),
                    success: function(json) {
                        if (json.result === 1) { // 탈퇴 성공
                            alert(json.msg); // 메시지 띄우기
                            location.href = "/index"; // 메인 페이지로 이동

                        } else { // 탈퇴 실패
                            alert(json.msg); // 메시지 띄우기
                            $("#password").focus(); // 아이디 입력 항목에 마우스 커서 이동
                        }
                    },
                    error: function(error) {
                        alert("탈퇴 중 오류가 발생했습니다.");
                    }
                });
            } else {
                alert("탈퇴가 취소되었습니다. 마이페이지로 돌아갑니다.");
                window.location.href = "/user/myPage";
            }
        }

    </script>
</head>

<body class="is-preload">
    <div id="page-wrapper">
        <div id="authed" style="position:absolute; right: 10px; bottom: 93%; display: flex; flex-direction: row;">
            <div><%=ssUserName%>님 환영합니다 &emsp; </div>

            <a href="/user/myPage" style="color: white;">
            <button style ="background-color: #37c0fb; width:100%; margin-right: 5px;" type="button" class="btn btn-primary">마이페이지</button></a>

            <a href="/user/logout" style="color: white;">
            <button style ="background-color: #37c0fb; width:100%; margin-left: 5px;" type="button" class="btn btn-primary" id="btnLogOut">로그아웃</button></a>
        </div>

    <!-- Header -->
    <div id="header">

        <!-- Logo -->
        <img width="105" src="/logo5.png" style="margin-right: 0%;">
        <h1><a href="/index" id="logo5">REMENTIA</a></h1>

        <!-- Nav -->
        <nav id="nav">
            <ul>
                <li class="current"><a href="/index"><strong>Home</strong></a></li>
                <li><a href="/test/start" style="color: white;"><strong>진단하기</strong></a></li>
                <li><a href="/test/resultList" style="color: white;"><strong>진단결과보기</strong></a></li>
                <li><a href="right-sidebar.html" style="color: white;"><strong>뇌건강트레이너</strong></a></li>
            </ul>
        </nav>

    </div>

    <!-- 회원탈퇴 폼 컨테이너 -->
    <div class="login-container" style="margin: auto; margin-top: 3%;">
        <h2>회원탈퇴</h2>
        <h3>탈퇴시 모든 회원 관련 정보가 삭제됩니다</h3>
        <div>
            <h3>탈퇴하시려면 비밀번호를 입력하세요</h3>
            <form id="f">
                <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" autocomplete="new-password"  required>
                <button id="btnConfirm" style="background-color: #37c0fb; color: white; padding: 10px; margin-top: 10%;" type="button" class="btn btn-primary">탈퇴하기</button>
            <form>
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

    .login-container {
    width: 560px;
    padding: 20px;
    background-color: white;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    border-radius: 20px;
    text-align: center;
    }

    h2 {
    margin-bottom: 20px;
    }

    input[type="password"] {
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    width: 100%;
    margin-bottom: 15px;
    margin-top: 10%
    }

    button:hover {
    background-color: #309ac9;
    }
    </style>

    </div>
</body>
</html>