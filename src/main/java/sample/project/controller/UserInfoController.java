package sample.project.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import sample.project.dto.MsgDTO;
import sample.project.dto.UserInfoDTO;
import sample.project.service.IUserInfoService;
import sample.project.util.CmmUtil;
import sample.project.util.EncryptUtil;

import java.util.Optional;

@Slf4j
@RequestMapping(value = "/user")
@RequiredArgsConstructor
@Controller
public class UserInfoController {
    private final IUserInfoService userInfoService;
    @GetMapping(value = "userRegForm")
    public String userRegForm() {
        log.info("{}.user/userRegForm",this.getClass().getName());

        return "/user/userRegForm";
    }

    @ResponseBody
    @PostMapping(value = "getPhoneNumExists")
    public UserInfoDTO getPhoneNumExists(HttpServletRequest request) throws Exception{

        log.info("{}.getPhoneNumExists Start!",this.getClass().getName());

        String phoneNum= CmmUtil.nvl(request.getParameter("phoneNum"));

        log.info("phoneNum : {}",phoneNum);

        UserInfoDTO pDTO=new UserInfoDTO();
        pDTO.setPhoneNum(phoneNum);

        UserInfoDTO rDTO= Optional.ofNullable(userInfoService.getPhoneNumExists(pDTO)).orElseGet(UserInfoDTO::new);

        log.info("{}.getPhoneNumExists End!",this.getClass().getName());

        return rDTO;
    }

    @ResponseBody
    @PostMapping(value = "insertUserInfo")
    public MsgDTO insertUserInfo(HttpServletRequest request){

        log.info("{}.insertUserInfo Start!", this.getClass().getName());

        int res=0;
        String msg="";
        MsgDTO dto;

        UserInfoDTO pDTO;

        try {
            String phoneNum=CmmUtil.nvl(request.getParameter("phoneNum"));
            String userName=CmmUtil.nvl(request.getParameter("userName"));
            String password=CmmUtil.nvl(request.getParameter("password"));

            log.info("phoneNum : "+phoneNum);
            log.info("userName : "+userName);
            log.info("password : "+password);

            pDTO=new UserInfoDTO();

            pDTO.setPhoneNum(phoneNum);
            pDTO.setUserName(userName);

            pDTO.setPassword(EncryptUtil.encHashSHA256(password));

            res= userInfoService.insertUserInfo(pDTO);

            log.info("회원가입 결과(res) : "+res);

            if(res==1){
                msg="회원가입되었습니다.";
            }
            else if (res==2) {
                msg="이미 가입된 번호입니다.";
            }
            else{
                msg="오류로 인해 회원가입이 실패하였습니다.";
            }

        }
        catch (Exception e){
            msg="실패하였습니다. : "+e;
            log.info(e.toString());
        }
        finally {
            dto=new MsgDTO();
            dto.setResult(res);
            dto.setMsg(msg);

            log.info("{}.insertUserInfo End!", this.getClass().getName());
        }

        return dto;
    }

    @GetMapping(value = "login")
    public String login(){
        log.info("{}.login Start!",this.getClass().getName());
        log.info("{}.login End!",this.getClass().getName());
        return "user/login";
    }

    @ResponseBody
    @PostMapping(value = "loginProc")
    public MsgDTO loginProc(HttpServletRequest request, HttpSession session){
        log.info("{}.loginProc Start!",this.getClass().getName());

        int res=0;
        String msg="";
        MsgDTO dto;

        UserInfoDTO pDTO;

        try {
            String phoneNum=CmmUtil.nvl(request.getParameter("phoneNum"));
            String password=CmmUtil.nvl(request.getParameter("password"));

            log.info("phoneNum : {} / password : {}",phoneNum,password);

            pDTO=new UserInfoDTO();
            pDTO.setPhoneNum(phoneNum);
            pDTO.setPassword(EncryptUtil.encHashSHA256(password));

            UserInfoDTO rDTO=userInfoService.getLogin(pDTO);

            if(!CmmUtil.nvl(rDTO.getPhoneNum()).isEmpty()){
                res=1;
                msg="로그인이 성공했습니다.";

                session.setAttribute("SS_PHONE_NUM",phoneNum);
                session.setAttribute("SS_USER_NAME",CmmUtil.nvl(rDTO.getUserName()));
            }
            else{
                msg="아이디와 비밀번호가 올바르지 않습니다.";
            }
        }
        catch (Exception e){
            msg="시스템 문제로 로그인이 실패했습니다.";
            res=2;
            log.info(e.toString());
        }
        finally {
            dto=new MsgDTO();
            dto.setResult(res);
            dto.setMsg(msg);

            log.info("{}.loginProc End!",this.getClass().getName());
        }

        return dto;
    }

    @GetMapping(value = "loginResult")
    public String loginSuccess(){
        log.info("{}.user/loginResult Start!",this.getClass().getName());
        log.info("{}.user/loginResult End!",this.getClass().getName());
        return "user/loginResult";
    }

    @GetMapping(value = "searchPhoneNum")
    public String searchPhoneNum() {
        log.info("{}.user/searchPhoneNum Start!",this.getClass().getName());
        log.info("{}.user/searchPhoneNum End!",this.getClass().getName());
        return "user/searchPhoneNum";
    }

    @PostMapping(value = "searchPhoneNumProc")
    public String searchPhoneNumProc(HttpServletRequest request, ModelMap model) throws Exception{
        log.info("{}.searchPhoneNumProc Start!",this.getClass().getName());

        String userName=CmmUtil.nvl(request.getParameter("userName"));
        String email=CmmUtil.nvl(request.getParameter("email"));

        log.info("userName : {} / email : {}",userName,email);

        UserInfoDTO pDTO=new UserInfoDTO();
        pDTO.setUserName(userName);

        UserInfoDTO rDTO=Optional.ofNullable(userInfoService.searchPhoneNumOrPasswordProc(pDTO)).orElseGet(UserInfoDTO::new);

        model.addAttribute("rDTO",rDTO);

        log.info("{}.searchPhoneNumProc End!",this.getClass().getName());

        return "user/searchPhoneNumResult";
    }

    @GetMapping(value = "searchPassword")
    public String searchPassword(HttpSession session){
        log.info("{}.searchPassword Start!",this.getClass().getName());

        session.setAttribute("NEW_PASSWORD","");
        session.removeAttribute("NEW_PASSWORD");

        log.info("{}.searchPassword End!",this.getClass().getName());

        return "user/searchPassword";
    }

    @PostMapping(value = "searchPasswordProc")
    public String searchPasswordProc(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception{
        log.info("{}.searchPasswordProc Start!",this.getClass().getName());

        String phoneNum=CmmUtil.nvl(request.getParameter("phoneNum"));
        String userName=CmmUtil.nvl(request.getParameter("userName"));

        log.info("phoneNum : {} / userName : {} ",phoneNum,userName);

        UserInfoDTO pDTO=new UserInfoDTO();
        pDTO.setPhoneNum(phoneNum);
        pDTO.setUserName(userName);

        UserInfoDTO rDTO=Optional.ofNullable(userInfoService.searchPhoneNumOrPasswordProc(pDTO)).orElseGet(UserInfoDTO::new);
        model.addAttribute("rDTO",rDTO);
        session.setAttribute("NEW_PASSWORD",phoneNum);

        log.info("{}.searchPasswordProc End!",this.getClass().getName());

        return "user/newPassword";
    }

    @PostMapping(value = "newPasswordProc")
    public String newPasswordProc(HttpServletRequest request, ModelMap model, HttpSession session) throws  Exception{
        log.info("{}.user/newPasswordProc Start!",this.getClass().getName());

        String msg;
        String newPassword= CmmUtil.nvl((String) session.getAttribute("NEW_PASSWORD"));

        if(!newPassword.isEmpty()){
            String password=CmmUtil.nvl(request.getParameter("password"));
            log.info("password : {}",password);

            UserInfoDTO pDTO=new UserInfoDTO();
            pDTO.setPhoneNum(newPassword);
            pDTO.setPassword(EncryptUtil.encHashSHA256(password));

            userInfoService.newPasswordProc(pDTO);

            session.setAttribute("NEW_PASSWORD","");
            session.removeAttribute("NEW_PASSWORD");

            msg="비밀번호가 재설정되었습니다.";
        }
        else{
            msg="비정상 접근입니다.";
        }

        model.addAttribute("msg",msg);

        log.info("{}.user/newPasswordProc End!",this.getClass().getName());

        return "user/newPasswordResult";
    }

}
