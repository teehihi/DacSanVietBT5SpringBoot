package LapTrinhWeb.SpringBoot.Controller;

import java.util.Optional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import LapTrinhWeb.SpringBoot.Entity.User;
import LapTrinhWeb.SpringBoot.Model.UserModel;
import LapTrinhWeb.SpringBoot.Service.UserService;

@Controller
public class AuthController {

	@Autowired
	UserService userService;

	@Autowired
	PasswordEncoder passwordEncoder;

	@GetMapping("/register")
	public String register(ModelMap model) {
		UserModel userModel = new UserModel();
		model.addAttribute("user", userModel);
		return "auth/register";
	}

	@PostMapping("/register/save")
	public ModelAndView registerSave(ModelMap model, @ModelAttribute("user") UserModel userModel) {
		// Kiểm tra username đã tồn tại chưa
		Optional<User> existingUser = userService.findById(userModel.getUsername());
		if (existingUser.isPresent()) {
			model.addAttribute("error", "Username đã tồn tại! Vui lòng chọn username khác.");
			model.addAttribute("user", userModel);
			return new ModelAndView("auth/register", model);
		}

		User entity = new User();
		BeanUtils.copyProperties(userModel, entity);
		
		// Mã hóa password
		if (userModel.getPassword() != null && !userModel.getPassword().isEmpty()) {
			entity.setPassword(passwordEncoder.encode(userModel.getPassword()));
		}
		
		// Mặc định user mới không phải admin và đang active
		entity.setAdmin(false);
		entity.setActive(true);

		userService.save(entity);

		model.addAttribute("message", "Đăng ký thành công! Bạn có thể đăng nhập ngay bây giờ.");
		return new ModelAndView("redirect:/login?success=true", model);
	}

	@GetMapping("/login")
	public String login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout,
			@RequestParam(value = "success", required = false) String success,
			ModelMap model, HttpSession session) {
		// Nếu đã đăng nhập, redirect
		if (session != null && session.getAttribute("user") != null) {
			User user = (User) session.getAttribute("user");
			if (user != null && user.getAdmin() != null && user.getAdmin()) {
				return "redirect:/admin/users";
			} else {
				return "redirect:/home";
			}
		}
		
		if (error != null) {
			model.addAttribute("error", "Username hoặc password không đúng!");
		}
		if (logout != null) {
			model.addAttribute("message", "Bạn đã đăng xuất thành công!");
		}
		if (success != null) {
			model.addAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
		}
		return "auth/login";
	}

	@PostMapping("/login")
	public ModelAndView performLogin(@RequestParam String username, 
			@RequestParam String password,
			@RequestParam(value = "rememberMe", required = false) Boolean rememberMe,
			HttpSession session, ModelMap model,
			jakarta.servlet.http.HttpServletRequest request,
			jakarta.servlet.http.HttpServletResponse response) {
		Optional<User> userOpt = userService.findById(username);
		
		if (userOpt.isEmpty()) {
			model.addAttribute("error", "Username hoặc password không đúng!");
			return new ModelAndView("auth/login", model);
		}
		
		User user = userOpt.get();
		
		// Kiểm tra password
		if (!passwordEncoder.matches(password, user.getPassword())) {
			model.addAttribute("error", "Username hoặc password không đúng!");
			return new ModelAndView("auth/login", model);
		}
		
		// Kiểm tra user có active không
		if (user.getActive() == null || !user.getActive()) {
			model.addAttribute("error", "Tài khoản của bạn đã bị khóa!");
			return new ModelAndView("auth/login", model);
		}
		
		// Lưu user vào session
		session.setAttribute("user", user);
		
		// Xử lý "Ghi nhớ"
		if (rememberMe != null && rememberMe) {
			// Nếu chọn ghi nhớ: set session timeout 30 ngày (2592000 giây)
			session.setMaxInactiveInterval(30 * 24 * 60 * 60);
		} else {
			// Nếu không chọn: session hết khi đóng browser (default)
			// Không cần làm gì, session sẽ tự động hết khi đóng browser
		}
		
		// Redirect theo quyền
		if (user.getAdmin() != null && user.getAdmin()) {
			return new ModelAndView("redirect:/admin/users", model);
		} else {
			return new ModelAndView("redirect:/home", model);
		}
	}

	@GetMapping("/logout")
	public ModelAndView logout(HttpSession session, ModelMap model) {
		session.invalidate();
		model.addAttribute("message", "Bạn đã đăng xuất thành công!");
		return new ModelAndView("redirect:/login?logout=true", model);
	}
}

