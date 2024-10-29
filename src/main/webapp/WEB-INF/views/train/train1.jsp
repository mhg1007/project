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
            .grid {
                display: grid;
                grid-template-columns: repeat(3, 100px);
                grid-template-rows: repeat(3, 100px);
                gap: 5px;
            }
            .cell {
                width: 100px;
                height: 100px;
                display: flex;
                justify-content: center;
                align-items: center;
                font-size: 24px;
                background-color: #ddd;
                position: relative;
            }
            .triangle, .square, .circle {
                position: absolute;
                width: 85px;
                height: 85px;
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .triangle {
                border-left: 50px solid transparent;
                border-right: 50px solid transparent;
                border-bottom: 87px solid rgba(55,192,251, 1);
                height: auto;
            }
            .square {
                background-color: rgba(55,192,251, 1);
            }
            .circle {
                background-color: rgba(55,192,251, 1);
                border-radius: 50%;
            }
            #result {
                margin-top: 20px;
                font-size: 18px;
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
                <p><strong>삼각형, 사각형, 원을 순서없이 한 번씩 클릭하고<br>나오는 숫자 세 개의 합을 적어주세요</strong></p>
                    <div style="margin-top: 3%; margin-bottom: 10%">
                        <div class="grid" id="grid"></div>
                        <input type="text" id="userInput" placeholder="세 숫자의 합" />
                        <button id="submitAnswer">확인</button>
                        <div id="result"></div>
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
            $(document).ready(function () {
                const gridElement = $('#grid');
                const resultElement = $('#result');
                const userInputElement = $('#userInput');
                const submitButton = $('#submitAnswer');

                let gridData = [];
                let clickedShapes = { triangle: false, square: false, circle: false };
                let clickOrder = [];
                let correctAnswer = null;
                let score = 0;
                let attempts = 0;
                const maxAttempts = 5;

                function generateRandomGrid() {
                    const numbers = [...Array(9).keys()].map(n => n + 1); // 1 to 9
                    gridData = numbers.sort(() => Math.random() - 0.5);

                    const shapes = ['triangle', 'square', 'circle'];
                    shapes.push(...Array(6).fill().map(() => ['triangle', 'square', 'circle'][Math.floor(Math.random() * 3)]));
                    return shapes.sort(() => Math.random() - 0.5);
                }

                function handleClick(index, shape, block) {
                    if (!clickedShapes[shape] && clickOrder.length < 3) {
                        clickedShapes[shape] = true;
                        clickOrder.push(gridData[index]);
                        block.remove(); // 클릭된 도형을 삭제
                        if (clickOrder.length === 3) {
                            correctAnswer = clickOrder.reduce((a, b) => a + b, 0);
                            setTimeout(clearGrid, 2000); // 2초 후에 그리드를 비움
                        }
                    }
                }

                function createBlock(index, shape) {
                    const block = $('<div></div>').attr('id', `block-${index}-${shape}`).addClass(shape);
                    block.on('click', function () {
                        handleClick(index, shape, block); // 해당 도형 클릭 시 처리
                    });
                    return block;
                }

                function clearGrid() {
                    $('.cell').empty(); // 모든 칸을 비움
                    resultElement.text("세 개의 숫자의 합을 적어주세요");
                }

                function initGrid() {
                    gridElement.html('');
                    clickedShapes = { triangle: false, square: false, circle: false };
                    clickOrder = [];

                    const shapes = generateRandomGrid();

                    gridData.forEach((num, index) => {
                        const cellElement = $('<div></div>').addClass('cell').text(num);
                        gridElement.append(cellElement);

                        const block = createBlock(index, shapes[index]); // 도형을 셀 위에 추가
                        cellElement.append(block);
                    });
                }

                function sendResultToServer(score) {
                    $.ajax({
                        url: "/train/trainProc", // 서버의 적절한 엔드포인트
                        type: "POST", // 전송방식은 Post
                        dataType: "json", // 결과를 JSON으로 받음
                        //contentType: "application/json; charset=UTF-8",
                        data: { result: score, type: 1 }, // JSON 데이터로 전송
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

                function checkAnswer() {
                    const userAnswer = parseInt(userInputElement.val(), 10);
                    if (userAnswer === correctAnswer) {
                        score += 20;
                        resultElement.text("정답입니다!");
                    }
                    else{
                        resultElement.text("오답입니다");
                    }

                    userInputElement.val('');
                    attempts++;

                    if (attempts < maxAttempts) {
                        initGrid(); // Reset the grid for the next attempt
                    } else {
                        resultElement.text("트레이닝 종료!");
                        submitButton.prop('disabled', true);
                        sendResultToServer(score); // 점수를 서버로 전송
                    }
                }

                submitButton.on('click', checkAnswer);

                initGrid();
            });
        </script>
	</body>
</html>