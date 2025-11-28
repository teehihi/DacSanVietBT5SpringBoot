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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import LapTrinhWeb.SpringBoot.Entity.User;
import LapTrinhWeb.SpringBoot.Model.UserModel;
import LapTrinhWeb.SpringBoot.Service.FileStorageService;
import LapTrinhWeb.SpringBoot.Service.UserService;

@Controller
public class ProfileController {

	@Autowired
	UserService userService;

	@Autowired
	PasswordEncoder passwordEncoder;

	@Autowired
	FileStorageService fileStorageService;

	@GetMapping("/profile")
	public String profile(ModelMap model, HttpSession session) {
		User user = null;
		if (session != null) {
			user = (User) session.getAttribute("user");
		}

		if (user == null) {
			return "redirect:/login";
		}

		// Load lại user từ DB để có thông tin mới nhất
		Optional<User> userOpt = userService.findById(user.getUsername());
		if (userOpt.isPresent()) {
			user = userOpt.get();
			session.setAttribute("user", user); // Cập nhật session
		}

		UserModel userModel = new UserModel();
		BeanUtils.copyProperties(user, userModel);
		userModel.setIsEdit(true);

		model.addAttribute("user", userModel);
		model.addAttribute("isAdmin", user.getAdmin() != null && user.getAdmin());
		return "profile";
	}

	@PostMapping("/profile/update")
	public ModelAndView updateProfile(ModelMap model, 
			@ModelAttribute("user") UserModel userModel,
			@org.springframework.web.bind.annotation.RequestParam(value = "avatarFile", required = false) MultipartFile avatarFile,
			HttpSession session) {
		User sessionUser = (User) session.getAttribute("user");
		if (sessionUser == null) {
			return new ModelAndView("redirect:/login", model);
		}

		// Chỉ cho phép sửa thông tin của chính mình
		if (!sessionUser.getUsername().equals(userModel.getUsername())) {
			model.addAttribute("error", "Bạn không có quyền sửa thông tin người khác!");
			return new ModelAndView("profile", model);
		}

		Optional<User> existingUser = userService.findById(userModel.getUsername());
		if (existingUser.isEmpty()) {
			model.addAttribute("error", "Người dùng không tồn tại!");
			return new ModelAndView("profile", model);
		}

		User entity = existingUser.get();
		String oldPassword = entity.getPassword();
		String oldImage = entity.getImages();

		// Copy properties nhưng không cho phép thay đổi admin và active
		entity.setFullname(userModel.getFullname());
		entity.setEmail(userModel.getEmail());
		entity.setPhone(userModel.getPhone());

		// Xử lý upload ảnh đại diện
		if (avatarFile != null && !avatarFile.isEmpty()) {
			try {
				// Xóa ảnh cũ nếu có và không phải URL
				if (oldImage != null && !oldImage.isEmpty() && !oldImage.startsWith("http")) {
					fileStorageService.deleteFile(oldImage);
				}
				
				// Lưu ảnh mới
				String newImagePath = fileStorageService.storeFile(avatarFile);
				entity.setImages(newImagePath);
			} catch (Exception e) {
				model.addAttribute("error", "Lỗi khi upload ảnh: " + e.getMessage());
				UserModel errorUserModel = new UserModel();
				BeanUtils.copyProperties(entity, errorUserModel);
				errorUserModel.setIsEdit(true);
				model.addAttribute("user", errorUserModel);
				return new ModelAndView("profile", model);
			}
		} else {
			// Nếu không upload ảnh mới, xử lý URL từ form
			if (userModel.getImages() != null && !userModel.getImages().isEmpty()) {
				// Nếu là URL hoặc đường dẫn hợp lệ thì lưu
				if (userModel.getImages().startsWith("http") || userModel.getImages().startsWith("/") || userModel.getImages().startsWith("uploads/")) {
					entity.setImages(userModel.getImages());
				} else {
					// Giữ nguyên ảnh cũ nếu input không hợp lệ
					entity.setImages(oldImage);
				}
			} else {
				// Giữ nguyên ảnh cũ nếu không có input
				entity.setImages(oldImage);
			}
		}

		// Xử lý password
		if (userModel.getPassword() != null && !userModel.getPassword().isEmpty()) {
			entity.setPassword(passwordEncoder.encode(userModel.getPassword()));
		} else {
			entity.setPassword(oldPassword);
		}

		userService.save(entity);

		// Cập nhật session với thông tin mới
		session.setAttribute("user", entity);
		
		// Reload lại user từ DB để đảm bảo có thông tin mới nhất
		Optional<User> updatedUser = userService.findById(entity.getUsername());
		if (updatedUser.isPresent()) {
			session.setAttribute("user", updatedUser.get());
		}

		model.addAttribute("message", "Cập nhật thông tin thành công!");
		return new ModelAndView("redirect:/profile", model);
	}
}

