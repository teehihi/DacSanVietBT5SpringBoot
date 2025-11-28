package LapTrinhWeb.SpringBoot.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;
import LapTrinhWeb.SpringBoot.Entity.User;

@Controller
public class HomeController {

	@GetMapping("/")
	public String index() {
		return "redirect:/home";
	}

	@GetMapping("/home")
	public String home(ModelMap model, HttpSession session) {
		User user = null;
		if (session != null) {
			user = (User) session.getAttribute("user");
		}
		model.addAttribute("user", user);
		model.addAttribute("isAdmin", user != null && user.getAdmin() != null && user.getAdmin());
		return "home";
	}
}

