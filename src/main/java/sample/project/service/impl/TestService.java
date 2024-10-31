package sample.project.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import sample.project.dto.TestDTO;
import sample.project.mapper.ITestMapper;
import sample.project.service.ITestService;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.nio.file.Path;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@Service
public class TestService implements ITestService {

    private final ITestMapper testMapper;
    private final S3Client s3Client;

    @Value("${aws.s3.bucket-name}")
    private String bucketName;

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
    public String putS3(String keyName, Path filePath) {
        PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                .bucket(bucketName)
                .key(keyName)
                .build();

        // 파일 업로드
        s3Client.putObject(putObjectRequest, RequestBody.fromFile(filePath));

        // 업로드된 파일의 URL 생성
        return "https://" + bucketName + ".s3.amazonaws.com/" + keyName;
    }


    @Override
    public String callPythonService(String url) {
        RestTemplate restTemplate = new RestTemplate();
        String pythonServerUrl = "http://198.19.184.252:5000/test_process";  // Python 서버 URL

        // 요청을 위한 헤더 및 본문 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        // JSON 형식으로 파일 경로 전송
        Map<String, String> request = new HashMap<>();
        request.put("url", url);

        HttpEntity<Map<String, String>> entity = new HttpEntity<>(request, headers);

        // Python 서버로 POST 요청 전송 후 응답 받기
        ResponseEntity<Map<String, Object>> response = restTemplate.exchange(pythonServerUrl, HttpMethod.POST, entity, new ParameterizedTypeReference<Map<String, Object>>() {});

        // 응답에서 "result" 값을 추출
        Map<String, Object> responseBody = response.getBody();

        if (responseBody != null && responseBody.containsKey("result")) {
            return responseBody.get("result").toString();
        }

        return "No result from Python server";
    }
}
