<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="sample.project.dto.UserInfoDTO" %>
<%@ page import="sample.project.util.CmmUtil" %>
<%@ page import="sample.project.util.EncryptUtil" %>
<%
    List<UserInfoDTO> rList = (List<UserInfoDTO>) request.getAttribute("rList");

    String msg = "";
    String phoneNumList="";

    if (rList.size() > 0) { // 아이디 찾기 성공
        msg = CmmUtil.nvl(rList.get(0).getUserName()) + " 회원님의 이름으로</br>등록된 휴대전화 번호는 </br></br>";

        for(UserInfoDTO dto:rList){
            String phoneNum=EncryptUtil.decAES128CBC(CmmUtil.nvl(dto.getPhoneNum()));
            String phoneNumSec="";
            if(phoneNum.length()==11){
                phoneNumSec=phoneNum.replace(phoneNum.substring(3,7),"****");
            }
            else if(phoneNum.length()==10){
                phoneNumSec=phoneNum.replace(phoneNum.substring(3,6),"***");
            }
            phoneNumList=phoneNumList+phoneNumSec+"</br>";
        }
        msg=msg+phoneNumList+"</br>입니다.";

    } else {
        msg = "번호가 존재하지 않습니다.";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>아이디(휴대전화번호)찾기결과</title>
    <link rel="stylesheet" href="/css/main.css"/>
    <script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">

        // HTML로딩이 완료되고, 실행됨
        $(document).ready(function () {

            // 로그인 화면 이동
            $("#btnLogin").on("click", function () { // 버튼 클릭했을때, 발생되는 이벤트 생성함(onclick 이벤트와 동일함)
                location.href = "/user/login";
            })

            // 로그인 화면 이동
            $("#btnSearchPassword").on("click", function () { // 버튼 클릭했을때, 발생되는 이벤트 생성함(onclick 이벤트와 동일함)
                location.href = "/user/searchPassword";
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
    <h2>아이디(휴대전화번호) 찾기 결과</h2>
    <h2></h2>
    <form id="f">
        <div style="margin-top:15%; margin-bottom:15%; text-align:center">
            <%=msg%>
        </div>
        <button id="btnLogin" type="button">로그인 하기</button>
        <button id="btnSearchPassword" type="button" class="btn btn-primary" style="margin-bottom:15%;">비밀번호 찾기</button>
    </form>
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