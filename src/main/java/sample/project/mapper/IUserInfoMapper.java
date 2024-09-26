package sample.project.mapper;

import org.apache.ibatis.annotations.Mapper;
import sample.project.dto.UserInfoDTO;

@Mapper
public interface IUserInfoMapper {
    int insertUserInfo(UserInfoDTO pDTO) throws Exception;
    UserInfoDTO getPhoneNumExists(UserInfoDTO pDTO) throws Exception;
    UserInfoDTO getLogin(UserInfoDTO pDTO) throws Exception;
    UserInfoDTO getPhoneNum(UserInfoDTO pDTO) throws Exception;
    int updatePassword(UserInfoDTO pDTO) throws Exception;
}
