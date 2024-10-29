package sample.project.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import sample.project.dto.MsgDTO;
import sample.project.dto.TrainDTO;
import sample.project.service.ITrainService;
import sample.project.util.CmmUtil;
import sample.project.util.EncryptUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Slf4j
@RequestMapping(value = "/train")
@RequiredArgsConstructor
@Controller
public class TrainController {

    private final ITrainService trainService;

    @GetMapping(value = "start")
    public String trainMainPage(){
        return "train/start";
    }

    @GetMapping(value = "train{id}")
    public String trainPage(@PathVariable String id){
        return "train/train"+id;
    }

    @GetMapping(value = "resultList")
    public String resultList(HttpSession session, ModelMap model) throws Exception{
        log.info("{}.resultList start!", this.getClass().getName());

        String phoneNum= CmmUtil.nvl((String) session.getAttribute("SS_PHONE_NUM"));
        log.info("phoneNum : {}", EncryptUtil.decAES128CBC(phoneNum));

        TrainDTO pDTO=new TrainDTO();
        pDTO.setPhoneNum(phoneNum);

        List<TrainDTO> rList = Optional.ofNullable(trainService.getTrainList(pDTO)).orElseGet(ArrayList::new);
        model.addAttribute("rList",rList);

        log.info("{}.resultList End!", this.getClass().getName());

        return "train/resultList";
    }

    @GetMapping(value = "trainList")
    public String trainList(){
        log.info("{}.trainList start!", this.getClass().getName());
        log.info("{}.trainList End!", this.getClass().getName());
        return "train/trainList";
    }

    @ResponseBody
    @PostMapping(value = "trainProc")
    public MsgDTO trainProc(HttpServletRequest request, HttpSession session){
        log.info("{}.trainProc start!", this.getClass().getName());

        int res=0;
        String msg="";
        MsgDTO dto;

        TrainDTO pDTO;

        try {
            String result = CmmUtil.nvl(request.getParameter("result"));
            String type = CmmUtil.nvl(request.getParameter("type"));
            log.info("result: {}, type:{}", result, type);

            pDTO=new TrainDTO();
            String phoneNum=CmmUtil.nvl((String) session.getAttribute("SS_PHONE_NUM"));

            pDTO.setTrainType(type);
            pDTO.setTrainRes(result);
            pDTO.setPhoneNum(phoneNum);

            trainService.insertTrain(pDTO);

            res=1;
            msg="결과가 서버에 등록되었습니다.";

        }
        catch (Exception e){
            msg="트레이닝 결과 등록 실패 : "+e;
            log.info(e.toString());
        }
        finally {
            dto=new MsgDTO();
            dto.setResult(res);
            dto.setMsg(msg);

            log.info("{}.trainProc End!", this.getClass().getName());
        }
        return dto;
    }

    @GetMapping(value = "result")
    public String trainResultProc(HttpSession session, ModelMap model) throws Exception{
        log.info("{}.trainResult start!", this.getClass().getName());

        TrainDTO pDTO=new TrainDTO();

        String phoneNum=CmmUtil.nvl((String) session.getAttribute("SS_PHONE_NUM"));

        pDTO.setPhoneNum(phoneNum);

        TrainDTO rDTO=Optional.ofNullable(trainService.getTrainLatest(pDTO)).orElseGet(TrainDTO::new);

        model.addAttribute("rDTO",rDTO);

        log.info("{}.trainResult end!", this.getClass().getName());

        return "train/result";
    }

}
