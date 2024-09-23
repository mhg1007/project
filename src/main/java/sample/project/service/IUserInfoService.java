package sample.project.service;

import sample.project.dto.UserInfoDTO;

public interface IUserInfoService {
    UserInfoDTO getPhoneNumExists(UserInfoDTO pDTO) throws Exception;
    int insertUserInfo(UserInfoDTO pDTO) throws Exception;
    UserInfoDTO getLogin(UserInfoDTO pDTO) throws Exception;
    UserInfoDTO searchPhoneNumOrPasswordProc(UserInfoDTO pDTO) throws Exception;
    int newPasswordProc(UserInfoDTO pDTO) throws Exception;
}
