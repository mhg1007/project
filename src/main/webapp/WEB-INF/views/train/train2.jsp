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
		<title>REMENTIA</title>
		<meta charset="utf-8"/>
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="/css/main.css"/>
		<script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>
        <style>
        /* Basic styling for the grid */
            #grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 10px;
                width: 200px;
                margin: auto;
                margin-left: -7%;
                margin-bottom: 8%;
                font-weight: bold;
            }
            .cell {
                width: 50px;
                height: 50px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 14px;
                background-color: lightgrey;
                color: white;
                cursor: pointer;
                border-radius: 8px;
            }
            .hidden {
                background-color: grey;
                color: grey;
            }
        </style>
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
			<img  width="105"  src = "/logo5.png" alt="REMENTIA 로고" style="margin-right: 0% ;">
			<h1><a href="/index" id="logo5.png">REMENTIA </em></a></h1>

			<!-- Nav -->
            <nav id="nav">
                <ul>
                    <li class="current"><a href="/index">Home</a></li>
                    <li><a href="/test/start" style="color: white;"><strong>진단하기</strong></a></li>
                    <li><a href="/test/resultList" style="color: white;"><strong>진단결과보기</strong></a></li>
                    <li><a href="/train/start" style="color: white;"><strong>뇌건강트레이너</strong></a></li>
                </ul>
            </nav>

			<div>
                <div class="login-container" style = "margin : auto; margin-top: 3%; margin-bottom: 5%;">
                <p>제시되는 조건에 따라 짝을 맞춰 주세요<br><span id="gameMode"></span></p>
                    <div style="margin-top: 3%; margin-bottom: 10%">
                        <div id="grid"></div>
                        <p>남은 시간: <span id="timeLeft">30</span> 초</p>
                        <button onclick="startGame()">트레이닝 시작</button>
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
        <script type="text/javascript">
            // 색상 배열
            const colors = ["빨강", "초록", "파랑", "노랑", "보라", "주황", "분홍", "갈색"];

            // 한글 색상 이름에 맞는 영어 색상 매핑
            const colorMap = {
                "빨강": "red",
                "초록": "green",
                "파랑": "blue",
                "노랑": "yellow",
                "보라": "purple",
                "주황": "orange",
                "분홍": "pink",
                "갈색": "brown"
            };

            let grid, mode, score, timer, timeLeft;

            function startGame() {
                grid = generateGrid();
                mode = Math.random() < 0.5 ? 1 : 2;
                document.getElementById("gameMode").textContent = mode === 1 ? "색깔 이름" : "글자 색깔";
                score = 4;
                timeLeft = 30; // 30 seconds limit suitable for cognitive challenge
                document.getElementById("timeLeft").textContent = timeLeft;

                showGrid();
                setTimeout(hideGrid, 2000); // Show for 2 seconds
                startTimer();
            }

            function generateGrid() {
                let gridArray = [];
                let colorPairs = [...colors, ...colors]; // 짝을 맞추기 위해 색상 배열 2배로 복제

                colorPairs = colorPairs.sort(() => Math.random() - 0.5); // 무작위 섞기

                const gridContainer = document.getElementById("grid");
                gridContainer.innerHTML = '';

                colorPairs.forEach((color, index) => {
                    const cell = document.createElement("div");
                    cell.className = "cell";
                    cell.dataset.colorName = color;
                    cell.dataset.textColor = colors[(index + 4) % colors.length]; // 다른 색상 조합

                    // 한글 색상 이름에 맞는 영어 색상으로 글자 색상을 적용
                    cell.style.color = mode === 1 ? 'black' : colorMap[cell.dataset.textColor];
                    cell.textContent = mode === 1 ? color : cell.dataset.colorName;

                    cell.addEventListener("click", () => handleCellClick(cell));
                    gridArray.push(cell);
                    gridContainer.appendChild(cell);
                });

                return gridArray;
            }

            function showGrid() {
                grid.forEach(cell => cell.classList.remove("hidden"));
            }

            function hideGrid() {
                grid.forEach(cell => cell.classList.add("hidden"));
            }

            let selectedCells = [];

            function handleCellClick(cell) {
                if (selectedCells.length < 2 && cell.classList.contains("hidden")) {
                    cell.classList.remove("hidden");
                    selectedCells.push(cell);
                }

                if (selectedCells.length === 2) {
                    setTimeout(checkMatch, 500);
                }
            }

            function checkMatch() {
                const [first, second] = selectedCells;
                const isMatch = (mode === 1 && first.dataset.colorName === second.dataset.colorName) ||
                (mode === 2 && first.dataset.textColor === second.dataset.textColor);

                if (isMatch) {
                    score += 12;
                } else {
                    first.classList.add("hidden");
                    second.classList.add("hidden");
                }

                selectedCells = [];

                if (score === 100) endGame(score);
            }

            function startTimer() {
                timer = setInterval(() => {
                timeLeft -= 1;
                document.getElementById("timeLeft").textContent = timeLeft;
                if (timeLeft <= 0) endGame(score);
               }, 1000);
            }

            function endGame(score) {
                clearInterval(timer);
                $.ajax({
                    url: "/train/trainProc", // 서버의 적절한 엔드포인트
                    type: "POST", // 전송방식은 Post
                    dataType: "json", // 결과를 JSON으로 받음
                    //contentType: "application/json; charset=UTF-8",
                    data: { result: score, type: 2 }, // JSON 데이터로 전송
                    success: function (json) {
                        if (json.result === 1) { // 성공
                            alert(json.msg); // 메시지 띄우기
                            location.href = "/train/result"; // 페이지 이동

                        } else { // 실패
                            alert(json.msg); // 메시지 띄우기
                        }
                    },
                    error: function () {
                        console.log('오류가 발생했습니다.');
                    }
                });
            }
        </script>
	</body>
</html>