package LapTrinhWeb.SpringBoot.Controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import LapTrinhWeb.SpringBoot.Entity.Category;
import LapTrinhWeb.SpringBoot.Entity.User;
import LapTrinhWeb.SpringBoot.Model.CategoryModel;
import LapTrinhWeb.SpringBoot.Service.CategoryService;
import LapTrinhWeb.SpringBoot.Service.FileStorageService;
import LapTrinhWeb.SpringBoot.Service.UserService;

@Controller
@RequestMapping("/admin/categories")
public class CategoryController {

	@Autowired
	CategoryService categoryService;

	@Autowired
	UserService userService;

	@Autowired
	FileStorageService fileStorageService;

	@GetMapping("add")
	public String add(ModelMap model) {
		System.out.println("CategoryController.add() called - DEBUG");
		try {
			CategoryModel cateModel = new CategoryModel();
			cateModel.setIsEdit(false);
			model.addAttribute("category", cateModel);
			List<User> users = userService.findAll();
			model.addAttribute("users", users);
			System.out.println("CategoryController.add() - returning view: admin/categories/addOrEdit");
			return "admin/categories/addoredit";
		} catch (Exception e) {
			System.err.println("Error in CategoryController.add(): " + e.getMessage());
			e.printStackTrace();
			throw e;
		}
	}

	@GetMapping({ "", "/" })
	public String list(ModelMap model) {
		try {
			List<Category> list = categoryService.findAll();
			model.addAttribute("categories", list);
			return "admin/categories/list";
		} catch (Exception e) {
			model.addAttribute("error", "Lỗi khi tải danh sách danh mục: " + e.getMessage());
			return "admin/categories/list";
		}
	}

	@PostMapping("saveOrUpdate")
	public ModelAndView saveOrUpdate(ModelMap model, @ModelAttribute("category") CategoryModel cateModel,
			@org.springframework.web.bind.annotation.RequestParam(value = "imageFile", required = false) MultipartFile imageFile) {

		Category entity;

		try {
			// Nếu là edit
			if (cateModel.getIsEdit() != null && cateModel.getIsEdit() && cateModel.getCategoryId() != null) {

				Optional<Category> optCate = categoryService.findById(cateModel.getCategoryId());

				if (optCate.isPresent()) {
					entity = optCate.get();

					String oldImage = entity.getImages();

					// Copy properties nhưng loại bỏ images để xử lý thủ công
					BeanUtils.copyProperties(cateModel, entity, "images", "user");

					// Upload ảnh mới
					if (imageFile != null && !imageFile.isEmpty()) {

						if (oldImage != null && !oldImage.isEmpty() && !oldImage.startsWith("http")) {
							fileStorageService.deleteFile(oldImage);
						}

						String newImagePath = fileStorageService.storeFile(imageFile);
						entity.setImages(newImagePath);

					} else {
						if (cateModel.getImages() != null && !cateModel.getImages().isEmpty()) {
							entity.setImages(cateModel.getImages());
						} else {
							entity.setImages(oldImage);
						}
					}

				} else {
					// Nếu không tìm thấy -> tạo mới
					entity = new Category();
					BeanUtils.copyProperties(cateModel, entity, "images", "user");

					if (imageFile != null && !imageFile.isEmpty()) {
						String newImagePath = fileStorageService.storeFile(imageFile);
						entity.setImages(newImagePath);
					} else if (cateModel.getImages() != null) {
						entity.setImages(cateModel.getImages());
					}
				}

			} else {
				// Tạo mới
				entity = new Category();
				BeanUtils.copyProperties(cateModel, entity, "images", "user");

				if (imageFile != null && !imageFile.isEmpty()) {
					String newImagePath = fileStorageService.storeFile(imageFile);
					entity.setImages(newImagePath);
				} else if (cateModel.getImages() != null) {
					entity.setImages(cateModel.getImages());
				}
			}

			// Gán user cho category
			if (cateModel.getUsername() != null && !cateModel.getUsername().isEmpty()) {
				Optional<User> optUser = userService.findById(cateModel.getUsername());
				optUser.ifPresent(entity::setUser);
			}

		} catch (Exception e) {
			model.addAttribute("error", "Lỗi khi xử lý dữ liệu: " + e.getMessage());
			model.addAttribute("category", cateModel);
			model.addAttribute("users", userService.findAll());
			return new ModelAndView("admin/categories/addOrEdit", model);
		}

		// Lưu
		categoryService.save(entity);

		String message = cateModel.getIsEdit() ? "Cập nhật danh mục thành công!" : "Thêm danh mục thành công!";

		model.addAttribute("message", message);
		return new ModelAndView("redirect:/admin/categories", model);
	}

	@GetMapping("edit/{id}")
	public ModelAndView edit(ModelMap model, @PathVariable("id") Integer id) {
		Optional<Category> opt = categoryService.findById(id);
		CategoryModel cateModel = new CategoryModel();

		if (opt.isPresent()) {
			Category entity = opt.get();
			BeanUtils.copyProperties(entity, cateModel);

			if (entity.getUser() != null) {
				cateModel.setUsername(entity.getUser().getUsername());
			}

			cateModel.setIsEdit(true);

			model.addAttribute("category", cateModel);
			model.addAttribute("users", userService.findAll());

			return new ModelAndView("admin/categories/addOrEdit", model);
		}

		model.addAttribute("message", "Danh mục không tồn tại!");
		return new ModelAndView("redirect:/admin/categories", model);
	}

	@GetMapping("delete/{id}")
	public ModelAndView delete(ModelMap model, @PathVariable("id") Integer id) {
		categoryService.deleteById(id);
		model.addAttribute("message", "Xóa danh mục thành công!");
		return new ModelAndView("redirect:/admin/categories", model);
	}
}
