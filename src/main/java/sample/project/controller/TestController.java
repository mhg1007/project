package sample.project.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import sample.project.dto.TestDTO;
import sample.project.service.ITestService;
import sample.project.util.CmmUtil;
import sample.project.util.EncryptUtil;

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
        log.info("phoneNum : {}", EncryptUtil.decAES128CBC(phoneNum));

        TestDTO pDTO=new TestDTO();
        pDTO.setPhoneNum(phoneNum);

        List<TestDTO> rList = Optional.ofNullable(testService.getTestList(pDTO)).orElseGet(ArrayList::new);
        model.addAttribute("rList",rList);

        log.info("{}.resultList End!", this.getClass().getName());

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
    public String handleFileUpload(@RequestParam("file") MultipartFile file, HttpSession session) {
        try {
            // 파일을 로컬 또는 메모리에 저장
            Path tempFile = Files.createTempFile("recording", ".wav");
            file.transferTo(tempFile.toFile());

            // 파일 경로를 Python 서버로 전송
            String result = testService.callPythonService(tempFile.toString());

            // Python 서버로부터 받은 처리 결과를 저장
            session.setAttribute("result", result);

            return "redirect:/result";
        } catch (Exception e) {
            log.info(e.toString());
            return "error";
        }
    }

    @GetMapping(value = "result")
    public String testResult(HttpSession session) throws Exception {

        log.info("{}.result start!", this.getClass().getName());

        String result= CmmUtil.nvl((String) session.getAttribute("result"));

        log.info("result: {}", result);

        TestDTO pDTO=new TestDTO();
        String phoneNum=CmmUtil.nvl((String) session.getAttribute("SS_PHONE_NUM"));

        pDTO.setTestRes(result);
        pDTO.setPhoneNum(phoneNum);

        testService.insertTest(pDTO);

        log.info("{}.result end!", this.getClass().getName());

        return "test/result";
    }



}
