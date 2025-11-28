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
import org.springframework.web.servlet.ModelAndView;

import LapTrinhWeb.SpringBoot.Entity.Category;
import LapTrinhWeb.SpringBoot.Entity.User;
import LapTrinhWeb.SpringBoot.Model.CategoryModel;
import LapTrinhWeb.SpringBoot.Service.CategoryService;
import LapTrinhWeb.SpringBoot.Service.UserService;

@Controller
@RequestMapping("/admin/categories")
public class CategoryController {

	@Autowired
	CategoryService categoryService;

	@Autowired
	UserService userService;

	@GetMapping("add")
	public String add(ModelMap model) {
		CategoryModel cateModel = new CategoryModel();
		cateModel.setIsEdit(false);
		model.addAttribute("category", cateModel);
		List<User> users = userService.findAll();
		model.addAttribute("users", users);
		return "admin/categories/addOrEdit";
	}

	@GetMapping({"", "/"})
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
	public ModelAndView saveOrUpdate(ModelMap model, @ModelAttribute("category") CategoryModel cateModel) {
		Category entity;
		
		// Nếu là edit, lấy category hiện tại
		if (cateModel.getIsEdit() != null && cateModel.getIsEdit() && cateModel.getCategoryId() != null) {
			Optional<Category> existingCategory = categoryService.findById(cateModel.getCategoryId());
			if (existingCategory.isPresent()) {
				entity = existingCategory.get();
			} else {
				entity = new Category();
			}
		} else {
			entity = new Category();
		}
		
		// Copy properties nhưng giữ lại categoryId và user
		entity.setCategoryname(cateModel.getCategoryname());
		entity.setCategorycode(cateModel.getCategorycode());
		entity.setImages(cateModel.getImages());
		// Xử lý status từ form (có thể là string "true"/"false")
		if (cateModel.getStatus() != null) {
			entity.setStatus(cateModel.getStatus());
		} else {
			entity.setStatus(true); // Mặc định
		}

		if (cateModel.getUsername() != null && !cateModel.getUsername().isEmpty()) {
			Optional<User> optUser = userService.findById(cateModel.getUsername());
			if (optUser.isPresent()) {
				entity.setUser(optUser.get());
			}
		}

		categoryService.save(entity);

		String message = "";
		if (cateModel.getIsEdit() != null && cateModel.getIsEdit()) {
			message = "Cập nhật danh mục thành công!";
		} else {
			message = "Thêm danh mục thành công!";
		}

		model.addAttribute("message", message);
		return new ModelAndView("redirect:/admin/categories", model);
	}

	@GetMapping("edit/{id}")
	public ModelAndView edit(ModelMap model, @PathVariable("id") Integer id) {
		Optional<Category> optCategory = categoryService.findById(id);
		CategoryModel cateModel = new CategoryModel();

		if (optCategory.isPresent()) {
			Category entity = optCategory.get();
			BeanUtils.copyProperties(entity, cateModel);
			if (entity.getUser() != null) {
				cateModel.setUsername(entity.getUser().getUsername());
			}
			cateModel.setIsEdit(true);
			model.addAttribute("category", cateModel);
			List<User> users = userService.findAll();
			model.addAttribute("users", users);
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

