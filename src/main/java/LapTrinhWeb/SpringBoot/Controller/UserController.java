package LapTrinhWeb.SpringBoot.Controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.multipart.MultipartFile;

import LapTrinhWeb.SpringBoot.Entity.User;
import LapTrinhWeb.SpringBoot.Model.UserModel;
import LapTrinhWeb.SpringBoot.Service.UserService;
import LapTrinhWeb.SpringBoot.Service.FileStorageService;

@Controller
@RequestMapping("/admin/users")
public class UserController {

	@Autowired
	UserService userService;

	@Autowired
	PasswordEncoder passwordEncoder;

	@Autowired
	FileStorageService fileStorageService;

	@GetMapping("add")
	public String add(ModelMap model) {
		UserModel userModel = new UserModel();
		userModel.setIsEdit(false);
		model.addAttribute("user", userModel);
		return "admin/users/addOrEdit";
	}

	@GetMapping({"", "/"})
	public String list(ModelMap model) {
		try {
			List<User> list = userService.findAll();
			model.addAttribute("users", list);
			return "admin/users/list";
		} catch (Exception e) {
			model.addAttribute("error", "Lỗi khi tải danh sách người dùng: " + e.getMessage());
			return "admin/users/list";
		}
	}

	@PostMapping("saveOrUpdate")
	public ModelAndView saveOrUpdate(ModelMap model, 
			@ModelAttribute("user") UserModel userModel,
			@org.springframework.web.bind.annotation.RequestParam(value = "avatarFile", required = false) MultipartFile avatarFile) {
		User entity;
		
		try {
			// Nếu là edit, lấy user hiện tại từ DB
			if (userModel.getIsEdit() != null && userModel.getIsEdit() && userModel.getUsername() != null) {
				Optional<User> existingUser = userService.findById(userModel.getUsername());
				if (existingUser.isPresent()) {
					entity = existingUser.get();
					// Copy properties nhưng xử lý password và images riêng
					String oldPassword = entity.getPassword();
					String oldImage = entity.getImages();
					BeanUtils.copyProperties(userModel, entity, "password", "images");
					
					// Xử lý upload ảnh đại diện
					if (avatarFile != null && !avatarFile.isEmpty()) {
						// Xóa ảnh cũ nếu có
						if (oldImage != null && !oldImage.isEmpty() && !oldImage.startsWith("http")) {
							fileStorageService.deleteFile(oldImage);
						}
						
						// Lưu ảnh mới
						String newImagePath = fileStorageService.storeFile(avatarFile);
						entity.setImages(newImagePath);
					} else {
						// Nếu không upload ảnh mới, sử dụng URL từ form hoặc giữ nguyên
						if (userModel.getImages() != null && !userModel.getImages().isEmpty()) {
							entity.setImages(userModel.getImages());
						} else {
							entity.setImages(oldImage);
						}
					}
					
					// Nếu password mới được nhập
					if (userModel.getPassword() != null && !userModel.getPassword().isEmpty()) {
						// Mã hóa password mới
						entity.setPassword(passwordEncoder.encode(userModel.getPassword()));
					} else {
						// Giữ nguyên password cũ nếu không nhập password mới
						entity.setPassword(oldPassword);
					}
				} else {
					// User không tồn tại, tạo mới
					entity = new User();
					BeanUtils.copyProperties(userModel, entity, "images");
					
					// Xử lý ảnh cho user mới
					if (avatarFile != null && !avatarFile.isEmpty()) {
						String newImagePath = fileStorageService.storeFile(avatarFile);
						entity.setImages(newImagePath);
					} else if (userModel.getImages() != null && !userModel.getImages().isEmpty()) {
						entity.setImages(userModel.getImages());
					}
					
					if (userModel.getPassword() != null && !userModel.getPassword().isEmpty()) {
						entity.setPassword(passwordEncoder.encode(userModel.getPassword()));
					}
				}
			} else {
				// Tạo mới
				entity = new User();
				BeanUtils.copyProperties(userModel, entity, "images");
				
				// Xử lý ảnh cho user mới
				if (avatarFile != null && !avatarFile.isEmpty()) {
					String newImagePath = fileStorageService.storeFile(avatarFile);
					entity.setImages(newImagePath);
				} else if (userModel.getImages() != null && !userModel.getImages().isEmpty()) {
					entity.setImages(userModel.getImages());
				}
				
				if (userModel.getPassword() != null && !userModel.getPassword().isEmpty()) {
					entity.setPassword(passwordEncoder.encode(userModel.getPassword()));
				}
			}
		} catch (Exception e) {
			model.addAttribute("error", "Lỗi khi xử lý dữ liệu: " + e.getMessage());
			model.addAttribute("user", userModel);
			return new ModelAndView("admin/users/addOrEdit", model);
		}

		userService.save(entity);

		String message = "";
		if (userModel.getIsEdit() != null && userModel.getIsEdit()) {
			message = "Cập nhật người dùng thành công!";
		} else {
			message = "Thêm người dùng thành công!";
		}

		model.addAttribute("message", message);
		return new ModelAndView("redirect:/admin/users", model);
	}

	@GetMapping("edit/{id}")
	public ModelAndView edit(ModelMap model, @PathVariable("id") String id) {
		Optional<User> optUser = userService.findById(id);
		UserModel userModel = new UserModel();

		if (optUser.isPresent()) {
			User entity = optUser.get();
			BeanUtils.copyProperties(entity, userModel);
			userModel.setIsEdit(true);
			model.addAttribute("user", userModel);
			return new ModelAndView("admin/users/addOrEdit", model);
		}

		model.addAttribute("message", "Người dùng không tồn tại!");
		return new ModelAndView("redirect:/admin/users", model);
	}

	@GetMapping("delete/{id}")
	public ModelAndView delete(ModelMap model, @PathVariable("id") String id) {
		userService.deleteById(id);
		model.addAttribute("message", "Xóa người dùng thành công!");
		return new ModelAndView("redirect:/admin/users", model);
	}
}

