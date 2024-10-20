package sample.project.service;

import sample.project.dto.UserInfoDTO;

import java.util.List;

public interface IUserInfoService {
    UserInfoDTO getPhoneNumExists(UserInfoDTO pDTO,int check) throws Exception;
    int insertUserInfo(UserInfoDTO pDTO) throws Exception;
    UserInfoDTO getLogin(UserInfoDTO pDTO) throws Exception;
    List<UserInfoDTO> searchPhoneNumProc(UserInfoDTO pDTO) throws Exception;
    UserInfoDTO searchPasswordProc(UserInfoDTO pDTO) throws Exception;
    void newPasswordProc(UserInfoDTO pDTO) throws Exception;
}
