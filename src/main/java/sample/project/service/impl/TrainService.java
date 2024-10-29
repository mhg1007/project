package sample.project.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import sample.project.dto.TrainDTO;
import sample.project.mapper.ITrainMapper;
import sample.project.service.ITrainService;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service
public class TrainService implements ITrainService {

    private final ITrainMapper trainMapper;

    @Override
    public List<TrainDTO> getTrainList(TrainDTO pDTO) throws Exception {
        log.info("{}.getTrainList start!", this.getClass().getName());
        return trainMapper.getTrainList(pDTO);
    }

    @Override
    public TrainDTO getTrainLatest(TrainDTO pDTO) throws Exception {
        log.info("{}.getTrainLatest start!", this.getClass().getName());
        return trainMapper.getTrainLatest(pDTO);
    }

    @Override
    public void insertTrain(TrainDTO pDTO) throws Exception {
        log.info("{}.insertTrain start!", this.getClass().getName());
        trainMapper.insertTrain(pDTO);
    }

}
