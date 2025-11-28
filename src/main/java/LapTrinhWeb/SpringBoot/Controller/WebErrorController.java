package LapTrinhWeb.SpringBoot.Controller;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;

@Controller
public class WebErrorController implements ErrorController {

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request, Model model) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        
        if (status != null) {
            Integer statusCode = Integer.valueOf(status.toString());
            model.addAttribute("status", statusCode);
            
            switch (statusCode) {
                case 404:
                    model.addAttribute("errorMessage", "Trang không tồn tại");
                    break;
                case 403:
                    model.addAttribute("errorMessage", "Không có quyền truy cập");
                    break;
                case 400:
                    model.addAttribute("errorMessage", "Yêu cầu không hợp lệ");
                    break;
                case 500:
                    model.addAttribute("errorMessage", "Lỗi máy chủ nội bộ");
                    break;
                default:
                    model.addAttribute("errorMessage", "Có lỗi xảy ra");
                    break;
            }
        }
        
        return "error";
    }
}