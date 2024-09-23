package sample.project.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import sample.project.dto.UserInfoDTO;
import sample.project.mapper.IUserInfoMapper;
import sample.project.service.IUserInfoService;

import java.util.Optional;

@Slf4j
@RequiredArgsConstructor
@Service
public class UserInfoService implements IUserInfoService {

    private final IUserInfoMapper userInfoMapper;

    @Override
    public UserInfoDTO getPhoneNumExists(UserInfoDTO pDTO) throws Exception {
        log.info("{}.getUserIdExists Start!",this.getClass().getName());
        UserInfoDTO rDTO=userInfoMapper.getPhoneNumExists(pDTO);
        log.info("{}.getUserIdExists End!",this.getClass().getName());
        return rDTO;
    }

    @Override
    public int insertUserInfo(UserInfoDTO pDTO) throws Exception {
        log.info("{}.insertUserInfo Start!",this.getClass().getName());

        int res;

        int success=userInfoMapper.insertUserInfo(pDTO);

        if(success>0){
            res=1;
        }
        else {
            res=0;
        }

        log.info("{}.insertUserInfo End!",this.getClass().getName());

        return res;
    }

    @Override
    public UserInfoDTO getLogin(UserInfoDTO pDTO) throws Exception {
        log.info("{}.getLogin Start!",this.getClass().getName());

        UserInfoDTO rDTO= Optional.ofNullable(userInfoMapper.getLogin(pDTO)).orElseGet(UserInfoDTO::new);

        log.info("{}.getLogin End!",this.getClass().getName());

        return rDTO;
    }

    @Override
    public UserInfoDTO searchPhoneNumOrPasswordProc(UserInfoDTO pDTO) throws Exception {
        log.info("{}.searchUserIdOrPasswordProc Start!",this.getClass().getName());

        UserInfoDTO rDTO=userInfoMapper.getPhoneNum(pDTO);

        log.info("{}.searchUserIdOrPasswordProc End!",this.getClass().getName());

        return rDTO;
    }

    @Override
    public int newPasswordProc(UserInfoDTO pDTO) throws Exception {
        log.info("{}.newPasswordProc Start!",this.getClass().getName());
        int success=userInfoMapper.updatePassword(pDTO);
        log.info("{}.newPasswordProc End!",this.getClass().getName());
        return success;
    }
}
