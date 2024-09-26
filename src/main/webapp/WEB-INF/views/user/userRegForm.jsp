<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" href="/css/table.css"/>
    <script type="text/javascript" src="/js/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">

        // 핸드폰번호 중복체크여부 (중복 Y / 중복아님 N)
        let phoneNumCheck = "Y";

        // SMS 인증번호 발송 값
        let smsAuthNumber = "";

        // 핸드폰 인증번호 확인여부 (확인 Y / 확인안됨 N)
        let phoneNumAuthCheck = "N";

        // HTML로딩이 완료되고, 실행됨
        $(document).ready(function () {

            let f = document.getElementById("f"); // form 태그

            // 핸드폰 번호 중복체크 및 인증번호 발송
            $("#btnPhoneNum").on("click", function () { // 버튼 클릭했을때, 발생되는 이벤트 생성함(onclick 이벤트와 동일함)
                phoneNumExists(f)
            })

            //인증번호 확인
            $("#btnPhoneNumAuth").on("click", function () { // 버튼 클릭했을때, 발생되는 이벤트 생성함(onclick 이벤트와 동일함)
                phoneNumAuth(f)
            })

            // 회원가입
            $("#btnSend").on("click", function () { // 버튼 클릭했을때, 발생되는 이벤트 생성함(onclick 이벤트와 동일함)
                doSubmit(f);
            })
        })

        // 회원 핸드폰 번호 중복 체크
        function phoneNumExists(f) {

            if (f.phoneNum.value === "") {
                alert("핸드폰 번호를 입력하세요.");
                f.phoneNum.focus();
                return;
            }

            if(isNaN(f.phoneNum.value)){
                alert("핸드폰 번호를 숫자로만 입력해 주세요.")
                f.phoneNum.focus();
                return;
            }

            // Ajax 호출해서 회원가입하기
            $.ajax({
                    url: "/user/getPhoneNumExists",
                    type: "post", // 전송방식은 Post
                    dataType: "JSON", // 전송 결과는 JSON으로 받기
                    data: $("#f").serialize(), // form 태그 내 input 등 객체를 자동으로 전송할 형태로 변경하기
                    success: function (json) { // 호출이 성공했다면..

                        if (json.existsYn === "Y") {
                            alert("이미 가입된 번호가 존재합니다.");
                            f.phoneNum.focus();
                        } else {
                            alert("인증번호가 발송되었습니다.");
                            phoneNumCheck = "N";
                            smsAuthNumber=json.authNumber;
                        }

                    }

                }
            )
        }

        // 인증번호 확인
        function phoneNumAuth(f) {

            if (smsAuthNumber === "") {
                alert("인증번호 받기를 먼저 진행해 해주세요.");
                f.phoneNum.focus();
                return;
            }

            if (f.authNumber.value === "") {
                alert("인증번호를 입력하세요.");
                f.authNumber.focus();
                return;
            }

            if (f.authNumber.value == smsAuthNumber) {
                alert("인증 확인 되었습니다.");
                phoneNumAuthCheck="Y";
            }
            else {
                alert("인증번호가 일치하지 않습니다. 다시 확인해 주세요.");
                f.authNumber.focus();
            }

        }

        //회원가입 정보의 유효성 체크하기
        function doSubmit(f) {

            if (f.phoneNum.value === "") {
                alert("핸드폰 번호를 입력하세요.");
                f.phoneNum.focus();
                return;
            }

            if(isNaN(f.phoneNum.value)){
                alert("핸드폰 번호를 숫자로만 입력해 주세요.")
                f.phoneNum.focus();
                return;
            }

            if (phoneNumCheck !== "N") {
                alert("아이디 중복 체크 및 중복되지 않은 아이디로 가입 바랍니다.");
                f.phoneNum.focus();
                return;
            }

            if (phoneNumAuthCheck !== "Y") {
                alert("인증번호 확인을 진행해 해주세요.");
                f.authNumber.focus();
                return;
            }

            if (f.userName.value === "") {
                alert("이름을 입력하세요.");
                f.userName.focus();
                return;
            }

            if (f.password.value === "") {
                alert("비밀번호를 입력하세요.");
                f.password.focus();
                return;
            }

            if (f.password2.value === "") {
                alert("비밀번호 확인을 입력하세요.");
                f.password2.focus();
                return;
            }

            if (f.password.value !== f.password2.value) {
                alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
                f.password.focus();
                return;
            }

            if (f.authNumber.value === "") {
                alert("인증번호를 입력하세요.");
                f.authNumber.focus();
                return;
            }

            // Ajax 호출해서 회원가입하기
            $.ajax({
                    url: "/user/insertUserInfo",
                    type: "post", // 전송방식은 Post
                    dataType: "JSON", // 전송 결과는 JSON으로 받기
                    data: $("#f").serialize(), // form 태그 내 input 등 객체를 자동으로 전송할 형태로 변경하기
                    success: function (json) { // /notice/noticeUpdate 호출이 성공했다면..

                        if (json.result === 1) { // 회원가입 성공
                            alert(json.msg); // 메시지 띄우기
                            location.href = "/user/login"; // 로그인 페이지 이동

                        } else { // 회원가입 실패
                            alert(json.msg); // 메시지 띄우기
                        }

                    }
                }
            )
        }

    </script>
</head>
<body>
<h2>회원가입</h2>
<hr/>
<br/>
<form id="f">
    <div class="divTable minimalistBlack">
        <div class="divTableBody">
            <div class="divTableRow">
                <div class="divTableCell">* 핸드폰번호
                </div>
                <div class="divTableCell">
                    <input type="text" name="phoneNum" style="width:80%" placeholder="핸드폰번호( - 없이 입력 )"/>
                    <button id="btnPhoneNum" type="button">인증번호받기</button>
                </div>
            </div>
            <div class="divTableRow">
                <div class="divTableCell">* 인증번호
                </div>
                <div class="divTableCell">
                    <input type="text" name="authNumber" style="width:30%" placeholder="인증번호 6자리" inputmode="numeric" maxlength="6"/>
                    <button id="btnPhoneNumAuth" type="button">인증번호확인</button>
                </div>
            </div>
            <div class="divTableRow">
                <div class="divTableCell">* 이름
                </div>
                <div class="divTableCell">
                    <input type="text" name="userName" style="width:95%" placeholder="이름"/>
                </div>
            </div>
            <div class="divTableRow">
                <div class="divTableCell">* 비밀번호
                </div>
                <div class="divTableCell">
                    <input type="password" name="password" style="width:95%" placeholder="비밀번호" autocomplete="new-password"/>
                </div>
            </div>
            <div class="divTableRow">
                <div class="divTableCell">* 비밀번호확인
                </div>
                <div class="divTableCell">
                    <input type="password" name="password2" style="width:95%" placeholder="비밀번호 확인"/>
                </div>
            </div>
        </div>
    </div>
    <div>
        <button id="btnSend" type="button">회원가입</button>
    </div>
</form>
</body>
</html>