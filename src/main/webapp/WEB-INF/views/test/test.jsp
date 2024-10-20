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
        <script type="text/javascript">

                // HTML로딩이 완료되고, 실행됨
                $(document).ready(function () {
                    // 버튼 클릭했을때, 발생되는 이벤트 생성함(onclick 이벤트와 동일함)
                    $("#startBtn").on("click", function () {
                        displayRandomSentence()
                    })
                })
        </script>

        <script>
            // 미리 정의된 문장 배열
            const sentences = [
                        "오늘 저녁은 무엇을 먹을까 고민하고 있어요.",
                        "햇볕이 따뜻해서 산책을 나갔어요.",
                        "텔레비전 리모컨이 어디 있는지 모르겠어요.",
                        "친구와 함께 커피를 마시러 갔어요.",
                        "어제는 비가 많이 내렸어요.",
                        "아침에 일어나서 창문을 열었어요.",
                        "집에 가는 길에 꽃을 한 송이 샀어요.",
                        "주말에는 영화를 보러 가기로 했어요.",
                        "시계가 고장 나서 시간을 알 수 없었어요.",
                        "냉장고에 남은 음식이 거의 없어요.",
                        "오늘은 날씨가 정말 좋네요.",
                        "지하철에서 책을 읽고 있었어요.",
                        "세탁기를 돌리고 나서 잠깐 쉬었어요.",
                        "엘리베이터를 타고 5층으로 올라갔어요.",
                        "아침에 커피를 한 잔 마셨어요.",
                        "주방에서 저녁을 준비하고 있었어요.",
                        "오늘 할 일을 메모해 두었어요.",
                        "방을 청소 해야겠다고 생각했어요.",
                        "세탁소에서 옷을 찾아왔어요.",
                        "식탁에 앉아 아침을 먹었어요.",
                        "책상 밑에 있는 볼펜을 주웠어요."
            ];

            // 랜덤 문장 선택 및 표시
            function displayRandomSentence() {
                const randomIndex = Math.floor(Math.random() * sentences.length);
                const randomSentence = sentences[randomIndex];
                document.getElementById("randomSentence").textContent = "다음 문장을 따라읽어 주세요<br>"
                                                                        +randomSentence
                                                                        +"<br>종료버튼을 누르면 바로 진단이 시작됩니다";
            }
        </script>

        <script>
            const startBtn = document.getElementById('startBtn');
            const stopBtn = document.getElementById('stopBtn');
            let mediaRecorder;
            let audioChunks = [];

            // Start Recording
            startBtn.addEventListener('click', async () => {
                const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
                mediaRecorder = new MediaRecorder(stream);

                mediaRecorder.start();
                startBtn.disabled = true;
                stopBtn.disabled = false;

                mediaRecorder.ondataavailable = (event) => {
                    audioChunks.push(event.data);
                };
            });

            // Stop Recording
            stopBtn.addEventListener('click', () => {
                mediaRecorder.stop();
                startBtn.disabled = false;
                stopBtn.disabled = true;

                mediaRecorder.onstop = async () => {
                    const audioBlob = new Blob(audioChunks, { type: 'audio/wav' });
                    const formData = new FormData();
                    formData.append('file', audioBlob, 'recording.wav');

                    // Send the recorded audio file to Spring Boot server
                    fetch('/test/upload', {
                        method: 'POST',
                        body: formData
                    })
                    .then(response => response.text())
                    .then(data => {
                        console.log('Success:', data);
                        window.location.href = '/test/result';
                    })
                    .catch((error) => {
                        console.error('Error:', error);
                    });

                    audioChunks = [];  // Reset chunks
                };
            });
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
                <h2>진단하기</h2>
                <h2></h2>
                    <div style="margin-top: 3%; margin-bottom: 10%">
                        <p id="randomSentence">녹음 시작 버튼을 누르면 문장이 제시됩니다<br>제시되는 문장을 따라읽어주세요</p>
                        <button id="startBtn">녹음 시작</button>
                        <button id="stopBtn" disabled>녹음 종료</button>
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