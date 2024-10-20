package sample.project.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import sample.project.dto.UserInfoDTO;
import sample.project.mapper.IUserInfoMapper;
import sample.project.service.IUserInfoService;
import sample.project.util.CmmUtil;
import sample.project.util.EncryptUtil;

import java.util.List;
import java.util.Optional;
import java.util.concurrent.ThreadLocalRandom;

@Slf4j
@RequiredArgsConstructor
@Service
public class UserInfoService implements IUserInfoService {

    private final IUserInfoMapper userInfoMapper;

    @Value("${coolsms.apikey}")
    private String apiKey;

    @Value("${coolsms.apisecret}")
    private String apiSecret;

    @Value("${coolsms.fromnumber}")
    private String fromNumber;

    @Override
    public UserInfoDTO getPhoneNumExists(UserInfoDTO pDTO, int checkNum) throws Exception {

        log.info("{}.phoneNumAuth Start!",this.getClass().getName());
        UserInfoDTO rDTO= Optional.ofNullable(userInfoMapper.getPhoneNumExists(pDTO)).orElseGet(UserInfoDTO::new);
        log.info("rDTO : {}",rDTO);

        //checkNum : 0은 가입할때(중복되는 번호가 없는지 확인), 1은 ID찾기할때(번호가 있는지 확인)
        String check="";
        if(checkNum==0){
            check="N";
        }
        else if (checkNum==1) {
            check="Y";
        }

        if(CmmUtil.nvl(rDTO.getExistsYn()).equals(check)){
            int authNumber= ThreadLocalRandom.current().nextInt(100000,1000000);

            log.info("authNumber : {}",authNumber);

            DefaultMessageService messageService =  NurigoApp.INSTANCE.initialize(apiKey, apiSecret, "https://api.coolsms.co.kr");

            Message sms=new Message();

            sms.setFrom(fromNumber);
            sms.setTo(EncryptUtil.decAES128CBC(pDTO.getPhoneNum()));
            sms.setText("인증번호는 "+authNumber+" 입니다.");

            try{
                messageService.send(sms);
            }
            catch (NurigoMessageNotReceivedException exception) {
                log.info("{}",exception.getFailedMessageList());
                log.info("{}",exception.getMessage());
            } catch (Exception exception) {
                log.info("{}",exception.getMessage());
            }

            rDTO.setAuthNumber(authNumber);
        }

        log.info("{}.phoneNumAuth End!",this.getClass().getName());

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
    public List<UserInfoDTO> searchPhoneNumProc(UserInfoDTO pDTO) throws Exception {
        log.info("{}.searchPhoneNumOrPasswordProc Start!",this.getClass().getName());

        List<UserInfoDTO> rList=userInfoMapper.getPhoneNum(pDTO);

        log.info("{}.searchPhoneNumOrPasswordProc End!",this.getClass().getName());

        return rList;
    }

    @Override
    public UserInfoDTO searchPasswordProc(UserInfoDTO pDTO) throws Exception {
        log.info("{}.searchPasswordProc Start!",this.getClass().getName());

        UserInfoDTO rDTO=userInfoMapper.getPassword(pDTO);

        log.info("{}.searchPasswordProc End!",this.getClass().getName());

        return rDTO;
    }

    @Override
    public void newPasswordProc(UserInfoDTO pDTO) throws Exception {
        log.info("{}.newPasswordProc Start!",this.getClass().getName());
        userInfoMapper.updatePassword(pDTO);
        log.info("{}.newPasswordProc End!",this.getClass().getName());
    }
}
