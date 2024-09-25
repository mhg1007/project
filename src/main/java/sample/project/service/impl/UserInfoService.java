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
    public UserInfoDTO getPhoneNumExists(UserInfoDTO pDTO) throws Exception {

        log.info("{}.phoneNumAuth Start!",this.getClass().getName());
        UserInfoDTO rDTO= Optional.ofNullable(userInfoMapper.getPhoneNumExists(pDTO)).orElseGet(UserInfoDTO::new);
        log.info("rDTO : {}",rDTO);

        if(CmmUtil.nvl(rDTO.getExistsYn()).equals("N")){
            int authNumber= ThreadLocalRandom.current().nextInt(100000,1000000);

            log.info("authNumber : {}",authNumber);

            DefaultMessageService messageService =  NurigoApp.INSTANCE.initialize(apiKey, apiSecret, "https://api.coolsms.co.kr");

            Message sms=new Message();

            sms.setFrom(fromNumber);
            sms.setTo(pDTO.getPhoneNum());
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
    public UserInfoDTO searchPhoneNumOrPasswordProc(UserInfoDTO pDTO) throws Exception {
        log.info("{}.searchPhoneNumOrPasswordProc Start!",this.getClass().getName());

        UserInfoDTO rDTO=userInfoMapper.getPhoneNum(pDTO);

        log.info("{}.searchPhoneNumOrPasswordProc End!",this.getClass().getName());

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
