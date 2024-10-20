<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="sample.project.dto.UserInfoDTO" %>
<%@ page import="sample.project.util.CmmUtil" %>
<%@ page import="sample.project.util.EncryptUtil" %>
<%
    String ssUserName = CmmUtil.nvl((String) session.getAttribute("SS_USER_NAME")); // 로그인된 회원 이름
    String ssPhoneNum = EncryptUtil.decAES128CBC(CmmUtil.nvl((String) session.getAttribute("SS_PHONE_NUM"))); // 로그인된 회원 휴대전화번호
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
                    $("#btnLogOut").on("click", function () {
                        location.href = "/user/logout";
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
									<a href="/test/start" style="color:white">진단하기</a>
								</li>
								<li><a href="left-sidebar.html" style="color: white;">진단결과보기</a></li>
								<li><a href="right-sidebar.html" style="color: white;">뇌건강트레이너</a></li>
							</ul>
						</nav>

			<!-- Highlights -->
				<section class="wrapper style1">
					<div class="container">
						<div class="row gtr-200">
							<section class="col-4 col-12-narrower">
								<div class="box highlight">
										<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-zoom-in" viewBox="0 0 16 16">
										<path fill-rule="evenodd" d="M6.5 12a5.5 5.5 0 1 0 0-11 5.5 5.5 0 0 0 0 11M13 6.5a6.5 6.5 0 1 1-13 0 6.5 6.5 0 0 1 13 0"/>
										<path d="M10.344 11.742q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1 6.5 6.5 0 0 1-1.398 1.4z"/>
										<path fill-rule="evenodd" d="M6.5 3a.5.5 0 0 1 .5.5V6h2.5a.5.5 0 0 1 0 1H7v2.5a.5.5 0 0 1-1 0V7H3.5a.5.5 0 0 1 0-1H6V3.5a.5.5 0 0 1 .5-.5"/>
									  </svg>
									<h3 style="margin-top: 5%;">진단하기</h3>
								</div>
							</section>
							<section class="col-4 col-12-narrower">
								<div class="box highlight">
									<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-clipboard2-data" viewBox="0 0 16 16">
										<path d="M9.5 0a.5.5 0 0 1 .5.5.5.5 0 0 0 .5.5.5.5 0 0 1 .5.5V2a.5.5 0 0 1-.5.5h-5A.5.5 0 0 1 5 2v-.5a.5.5 0 0 1 .5-.5.5.5 0 0 0 .5-.5.5.5 0 0 1 .5-.5z"/>
										<path d="M3 2.5a.5.5 0 0 1 .5-.5H4a.5.5 0 0 0 0-1h-.5A1.5 1.5 0 0 0 2 2.5v12A1.5 1.5 0 0 0 3.5 16h9a1.5 1.5 0 0 0 1.5-1.5v-12A1.5 1.5 0 0 0 12.5 1H12a.5.5 0 0 0 0 1h.5a.5.5 0 0 1 .5.5v12a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5z"/>
										<path d="M10 7a1 1 0 1 1 2 0v5a1 1 0 1 1-2 0zm-6 4a1 1 0 1 1 2 0v1a1 1 0 1 1-2 0zm4-3a1 1 0 0 0-1 1v3a1 1 0 1 0 2 0V9a1 1 0 0 0-1-1"/>
									  </svg>
									<h3 style="margin-top: 5%;">진단결과보기</h3>
								</div>
							</section>
							<section class="col-4 col-12-narrower">
								<div class="box highlight">
									<img width="100" src="logo4.jpg" alt="뇌건강트레이너 로고">
									<h3 style="margin-top: 5%;">뇌건강트레이너</h3>
								</div>
							</section>
						</div>
					</div>
				</section>

	</body>
</html>