package sample.project.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import sample.project.dto.TestDTO;
import sample.project.mapper.ITestMapper;
import sample.project.service.ITestService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@Service
public class TestService implements ITestService {

    private final ITestMapper testMapper;

    @Override
    public List<TestDTO> getTestList(TestDTO pDTO) throws Exception {
        log.info("{}.getTestList start!", this.getClass().getName());
        return testMapper.getTestList(pDTO);
    }

    @Override
    public void insertTest(TestDTO pDTO) throws Exception {
        log.info("{}.insertTest start!", this.getClass().getName());
        testMapper.insertTest(pDTO);
    }

    @Override
    public String callPythonService(String filePath) {
        RestTemplate restTemplate = new RestTemplate();
        String pythonServerUrl = "http://localhost:5000/process-audio";  // Python 서버 URL

        // 요청을 위한 헤더 및 본문 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        // JSON 형식으로 파일 경로 전송
        Map<String, String> request = new HashMap<>();
        request.put("filePath", filePath);

        HttpEntity<Map<String, String>> entity = new HttpEntity<>(request, headers);

        // Python 서버로 POST 요청 전송 후 응답 받기
        ResponseEntity<Map> response = restTemplate.exchange(pythonServerUrl, HttpMethod.POST, entity, Map.class);

        // 응답에서 "result" 값을 추출
        Map<String, Object> responseBody = response.getBody();
        if (responseBody != null && responseBody.containsKey("result")) {
            return responseBody.get("result").toString();
        }

        return "No result from Python server";
    }
}
