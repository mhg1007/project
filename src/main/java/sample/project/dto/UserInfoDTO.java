package sample.project.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@JsonInclude(JsonInclude.Include.NON_DEFAULT)
public class UserInfoDTO {
    private String phoneNum;
    private String userName;
    private String password;
    private String existsYn;
    private int authNumber;
}
