package sample.project.mapper;

import org.apache.ibatis.annotations.Mapper;
import sample.project.dto.TrainDTO;

import java.util.List;

@Mapper
public interface ITrainMapper {
    //트레이닝 결과 전체 불러오기
    List<TrainDTO> getTrainList(TrainDTO pDTO) throws Exception;

    //최근 트레이닝 결과 불러오기
    TrainDTO getTrainLatest(TrainDTO pDTO) throws Exception;

    //트레이닝 결과 저장하기
    void insertTrain(TrainDTO pDTO) throws Exception;
}
