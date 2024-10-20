package sample.project.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import sample.project.dto.TestDTO;
import sample.project.service.ITestService;
import sample.project.util.CmmUtil;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Slf4j
@RequestMapping(value="/test")
@RequiredArgsConstructor
@Controller
public class TestController {

    private final ITestService testService;

    @GetMapping(value = "start")
    public String testMainPage(){
        return "test/start";
    }

    @GetMapping(value = "resultList")
    public String resultList(HttpSession session, ModelMap model) throws Exception{
        log.info("{}.resultList start!", this.getClass().getName());

        String phoneNum=CmmUtil.nvl((String) session.getAttribute("SS_PHONE_NUM"));
        log.info("phoneNum : {}", phoneNum);

        TestDTO pDTO=new TestDTO();
        pDTO.setPhoneNum(phoneNum);

        List<TestDTO> rList = Optional.ofNullable(testService.getTestList(pDTO)).orElseGet(ArrayList::new);
        model.addAttribute("rList",rList);

        log.info("{}.noticeList End!", this.getClass().getName());

        return "test/resultList";
    }


    @GetMapping(value = "test")
    public String test(){
        log.info("{}.test Start!",this.getClass().getName());
        log.info("{}.test End!",this.getClass().getName());
        return "test/test";
    }

    @ResponseBody
    @PostMapping("/upload")
    public ResponseEntity<String> handleFileUpload(@RequestParam("file") MultipartFile file) {
        try {
            // 파일을 로컬 또는 메모리에 저장
            Path tempFile = Files.createTempFile("recording", ".wav");
            file.transferTo(tempFile.toFile());

            // 파일 경로를 Python 서버로 전송
            String result = testService.callPythonService(tempFile.toString());

            return ResponseEntity.ok("Python 서버에서 받은 결과: " + result);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("File upload failed");
        }
    }

    @GetMapping(value = "result")
    public String testResult(@ModelAttribute("result") String result, ModelMap model, HttpSession session) throws Exception {

        TestDTO pDTO=new TestDTO();
        String phoneNum=CmmUtil.nvl((String) session.getAttribute("SS_PHONE_NUM"));

        pDTO.setTestRes(result);
        pDTO.setPhoneNum(phoneNum);

        testService.insertTest(pDTO);

        // Python 서버로부터 받은 처리 결과를 모델에 추가
        model.addAttribute("result", result);

        return "test/result";
    }



}
