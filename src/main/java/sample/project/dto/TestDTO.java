package sample.project.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@JsonInclude(JsonInclude.Include.NON_DEFAULT)
public class TestDTO {
    private String testSeq;
    private String testDt;
    private String testRes;
    private String phoneNum;
}
