package sample.project.mapper;

import org.apache.ibatis.annotations.Mapper;
import sample.project.dto.TestDTO;

import java.util.List;

@Mapper
public interface ITestMapper {

    //진단 결과 불러오기
    List<TestDTO> getTestList(TestDTO pDTO) throws Exception;

    //진단 결과 저장하기
    void insertTest(TestDTO pDTO) throws Exception;

}
