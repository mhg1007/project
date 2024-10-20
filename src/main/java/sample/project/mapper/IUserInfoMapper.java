package sample.project.mapper;

import org.apache.ibatis.annotations.Mapper;
import sample.project.dto.UserInfoDTO;

import java.util.List;

@Mapper
public interface IUserInfoMapper {
    int insertUserInfo(UserInfoDTO pDTO) throws Exception;
    UserInfoDTO getPhoneNumExists(UserInfoDTO pDTO) throws Exception;
    UserInfoDTO getLogin(UserInfoDTO pDTO) throws Exception;
    List<UserInfoDTO> getPhoneNum(UserInfoDTO pDTO) throws Exception;
    UserInfoDTO getPassword(UserInfoDTO pDTO) throws Exception;
    void updatePassword(UserInfoDTO pDTO) throws Exception;
}
