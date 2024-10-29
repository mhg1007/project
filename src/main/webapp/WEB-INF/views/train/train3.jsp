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
                    #quiz-container {
                        text-align: center;
                    }

                    #number-grid {
                        display: grid;
                        grid-template-columns: repeat(5, 1fr);
                        gap: 10px;
                        margin: 20px auto;
                        max-width: 300px;
                    }

                    .number-cell {
                        padding: 10px;
                        border: 1px solid #ddd;
                        cursor: pointer;
                    }

                    .selected {
                        background-color: #007bff;
                        color: white;
                    }

                    #operator-buttons {
                        margin: 10px 0;
                    }

                    .operator-btn {
                        margin: 0 5px;
                        padding: 5px 10px;
                        min-width: initial;
                        line-height: initial;
                        width: 20%;
                        font-size: xxx-large;
                        font-family: cursive;
                    }

                    #equation-display {
                        display: flex;
                        align-items: center;
                    }

                    .equation-box {
                        display: inline-block;
                        width: 80px;
                        height: 80px;
                        border: 2px solid #000;
                        margin: 0 5px;
                        line-height: 80px;
                        text-align: center;
                        font-weight: bold;
                        font-size: 24px;
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
                <p style="margin: 0px;"><strong>첫 번째 숫자와 두번째 숫자를 덧셈/뺄셈해서<br>세 번째 숫자가 나오도록 숫자를 골라주세요</strong></p>
                    <div id="quiz-container">
                        <div id="number-grid"></div>
                        <div id="operator-buttons" style="display: none;">
                            <button class="operator-btn" data-operator="+">+</button>
                            <button class="operator-btn" data-operator="-">-</button>
                        </div>
                        <div id="equation">
                            <p>
                                <span id="equation-display" style="margin-top: 15px;">
                                    <span id="num1" class="equation-box"></span>
                                    <span id="operator" class="equation-box"></span>
                                    <span id="num2" class="equation-box"></span>
                                    <span id="operator2" class="equation-box"><strong>=</strong></span>
                                    <span id="result" class="equation-box"></span>
                                </span>
                            </p>
                        </div>
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
            document.addEventListener('DOMContentLoaded', function () {
                const grid = document.getElementById('number-grid');
                const num1Span = document.getElementById('num1');
                const num2Span = document.getElementById('num2');
                const operatorSpan = document.getElementById('operator');
                const resultSpan = document.getElementById('result');
                const attemptsLeftSpan = document.getElementById('attempts-left');
                const scoreSpan = document.getElementById('score');
                const operatorButtons = document.getElementById('operator-buttons');

                let attemptsLeft = 5;
                let score = 0;
                let selectedNumbers = [];
                let selectedOperator = '';
                let gridNumbers = []; // 그리드 숫자 배열
                let currentStep = 1;
                let correctAnswer = 0;

                function shuffleNumbers() {
                    const numbers = Array.from({ length: 100 }, (_, i) => i + 1);
                    for (let i = numbers.length - 1; i > 0; i--) {
                        const j = Math.floor(Math.random() * (i + 1));
                        [numbers[i], numbers[j]] = [numbers[j], numbers[i]];
                    }
                    return numbers.slice(0, 25);
                }

                // 그리드 생성
                function createGrid() {
                    grid.innerHTML = '';
                    for (let i = 0; i < 25; i++) {
                        const cell = document.createElement('div');
                        cell.className = 'number-cell';
                        cell.textContent = gridNumbers[i];
                        cell.addEventListener('click', () => selectNumber(cell, gridNumbers[i]));
                        grid.appendChild(cell);
                    }
                }

                function selectNumber(cell, number) {
                    if (selectedNumbers.includes(number)) {
                        alert('이미 선택한 숫자입니다. 다른 숫자를 선택해주세요.');
                        return; // 이미 선택된 숫자는 선택할 수 없음
                    }

                    if (currentStep === 1 || currentStep === 3) {
                        selectedNumbers.push(number);
                        updateEquationDisplay();
                        nextStep();
                    } else if (currentStep === 4) {
                        checkAnswer(number);
                    }
                }

                function selectOperator(operator) {
                    selectedOperator = operator;
                    updateEquationDisplay();
                    nextStep();
                }

                function updateEquationDisplay() {
                    num1Span.textContent = selectedNumbers[0] || '';
                    num2Span.textContent = selectedNumbers[1] || '';
                    operatorSpan.textContent = selectedOperator;
                    resultSpan.textContent = currentStep === 4 ? '?' : '';
                }

                function nextStep() {
                    currentStep++;
                    if (currentStep === 2) {
                        grid.style.display = 'none';
                        operatorButtons.style.display = 'block';
                    } else if (currentStep === 3) {
                        operatorButtons.style.display = 'none';
                        createGrid(); // 고정된 숫자로 그리드 생성
                        grid.style.display = 'grid';
                    } else if (currentStep === 4) {
                        correctAnswer = selectedOperator === '+' ? selectedNumbers[0] + selectedNumbers[1] : selectedNumbers[0] - selectedNumbers[1];
                        createGrid(); // 동일한 숫자로 그리드 생성 (변화 없음)
                    }
                }

                function checkAnswer(answer) {
                    if (answer === correctAnswer) {
                        alert('정답입니다!');
                        score += 20;
                    } else {
                        alert('틀렸습니다. 정답은 ' + correctAnswer + '입니다.');
                    }

                    attemptsLeft--;

                    if (attemptsLeft === 0) {
                        finishQuiz(score);
                    } else {
                        resetQuiz();
                    }
                }

                function resetQuiz() {
                    selectedNumbers = [];
                    selectedOperator = '';
                    currentStep = 1;
                    gridNumbers = shuffleNumbers(); // 새로운 랜덤 숫자 배열 생성
                    createGrid(); // 새로운 숫자로 그리드 생성
                    updateEquationDisplay();
                    grid.style.display = 'grid';
                    operatorButtons.style.display = 'none';
                }

                function finishQuiz(score) {
                    $.ajax({
                        url: "/train/trainProc", // 서버의 적절한 엔드포인트
                        type: "POST", // 전송방식은 Post
                        dataType: "json", // 결과를 JSON으로 받음
                        //contentType: "application/json; charset=UTF-8",
                        data: { result: score, type: 3 }, // JSON 데이터로 전송
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

                // 초기 그리드 숫자 생성
                gridNumbers = shuffleNumbers(); // 그리드를 한 번만 생성
                createGrid(); // 그리드 생성

                operatorButtons.querySelectorAll('.operator-btn').forEach(button => {
                    button.addEventListener('click', () => selectOperator(button.dataset.operator));
                });
            });
        </script>
	</body>
</html>