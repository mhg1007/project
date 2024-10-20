<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="sample.project.dto.UserInfoDTO" %>
<%@ page import="sample.project.util.CmmUtil" %>
<%@ page import="sample.project.util.EncryptUtil" %>
<%
    String ssUserName = CmmUtil.nvl((String) session.getAttribute("SS_USER_NAME")); // 로그인된 회원 이름
    String ssPhoneNum = EncryptUtil.decAES128CBC(CmmUtil.nvl((String) session.getAttribute("SS_PHONE_NUM"))); // 로그인된 회원 휴대전화번호
    String result=CmmUtil.nvl((String) request.getAttribute("result"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
    <head>
		<title>REMENTIA</title>
		<meta charset="utf-8"/>
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="/css/main.css"/>
		<script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>
            <script type="text/javascript">

                // HTML로딩이 완료되고, 실행됨
                $(document).ready(function () {
                    // 버튼 클릭했을때, 발생되는 이벤트 생성함(onclick 이벤트와 동일함)
                    $("#btnUserReg").on("click", function () {
                        location.href = "/user/userRegForm";
                    })
                    $("#btnLogin").on("click", function () {
                        location.href = "/user/login";
                    })
                    $("#btnTest").on("click", function () {
                        location.href = "/test/test";
                    })
                })
            </script>
	</head>
    <body class="is-preload">
		<div id="page-wrapper">
			<!-- Header -->
				<div id="header">
                    <%if(session.getAttribute("SS_PHONE_NUM") == null){%>
                    <div id="auth" style="position:absolute; right: 10px; bottom: 93%; display: flex; flex-direction: row;">
                        <a href="/user/userRegForm" style="color: white;">
                        <button style ="background-color: #37c0fb; width:100%; margin-right: 5px;" type="button" class="btn btn-primary">회원가입</button></a>

                        <a href="/user/login" style="color: white;">
                        <button style ="background-color: #37c0fb; width:100%; margin-left: 5px;" type="button" class="btn btn-primary">로그인</button></a>
                    </div>

                    <%}else{ %>
                    <div id="authed" style="position:absolute; right: 10px; bottom: 93%; display: flex; flex-direction: row;">
                        <div><%=ssUserName%>님 환영합니다 &emsp; </div>

                        <a href="/user/myPage" style="color: white;">
                        <button style ="background-color: #37c0fb; width:100%; margin-right: 5px;" type="button" class="btn btn-primary">마이페이지</button></a>

                        <a href="/user/logout" style="color: white;">
                        <button style ="background-color: #37c0fb; width:100%; margin-left: 5px;" type="button" class="btn btn-primary" id="btnLogOut">로그아웃</button></a>
                    </div>
					<%} %>

			<!-- Logo -->
			<img  width="70"  src = "logo5.png" style="margin-right: 0% ;">
			<h1><a href="index.html" id="logo5.png">REMENTIA </em></a></h1>

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

			<div>
                <div class="login-container" style = "margin : auto; margin-top: 3%; margin-bottom: 5%;">
                <h2>진단결과</h2>
                <h2></h2>
                    <div style="margin-top: 3%; margin-bottom: 10%">
                        <div>진단 결과는</div>
                        <%if(result.equals("good")){%>
                        <div>위험도 낮음<br>입니다</div>
                        <%}else{ %>
                        <div>위험도 높음<br>입니다</div>
                        <div>상담을 권유드립니다<br>치매상담콜센터<br>☎1899-9988</div>
                        <%} %>
                    </div>
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