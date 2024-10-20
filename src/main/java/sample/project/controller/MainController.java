package sample.project.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@RequestMapping(value = "/")
@Controller
public class MainController {
    @GetMapping(value = "index")
    public String index(){
        return "/index";
    }
}
