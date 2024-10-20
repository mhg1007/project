package sample.project.service;

import sample.project.dto.TestDTO;

import java.util.List;

public interface ITestService {

    //진단 결과 불러오기
    List<TestDTO> getTestList(TestDTO pDTO) throws Exception;

    //진단 결과 저장하기
    void insertTest(TestDTO pDTO) throws Exception;

    String callPythonService(String filePath);
}
