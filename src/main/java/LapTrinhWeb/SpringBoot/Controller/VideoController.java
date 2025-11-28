package LapTrinhWeb.SpringBoot.Controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.multipart.MultipartFile;

import LapTrinhWeb.SpringBoot.Entity.Category;
import LapTrinhWeb.SpringBoot.Entity.Video;
import LapTrinhWeb.SpringBoot.Model.VideoModel;
import LapTrinhWeb.SpringBoot.Service.CategoryService;
import LapTrinhWeb.SpringBoot.Service.VideoService;
import LapTrinhWeb.SpringBoot.Service.FileStorageService;

@Controller
@RequestMapping("/admin/videos")
public class VideoController {

	@Autowired
	VideoService videoService;

	@Autowired
	CategoryService categoryService;

	@Autowired
	FileStorageService fileStorageService;

	@GetMapping("add")
	public String add(ModelMap model) {
		VideoModel videoModel = new VideoModel();
		videoModel.setIsEdit(false);
		model.addAttribute("video", videoModel);
		List<Category> categories = categoryService.findAll();
		model.addAttribute("categories", categories);
		return "admin/videos/addOrEdit";
	}

	@GetMapping({"", "/"})
	public String list(ModelMap model, 
			@RequestParam(value = "search", required = false) String search,
			@RequestParam(value = "page", required = false, defaultValue = "0") int page,
			@RequestParam(value = "size", required = false, defaultValue = "10") int size) {
		try {
			List<Video> list;
			if (search != null && !search.isEmpty()) {
				Pageable pageable = PageRequest.of(page, size);
				Page<Video> pageResult = videoService.findByTitleContaining(search, pageable);
				list = pageResult.getContent();
				model.addAttribute("totalPages", pageResult.getTotalPages());
				model.addAttribute("currentPage", page);
				model.addAttribute("search", search);
			} else {
				list = videoService.findAll();
			}
			model.addAttribute("videos", list);
			return "admin/videos/list";
		} catch (Exception e) {
			model.addAttribute("error", "Lỗi khi tải danh sách video: " + e.getMessage());
			return "admin/videos/list";
		}
	}

	@PostMapping("saveOrUpdate")
	public ModelAndView saveOrUpdate(ModelMap model, 
			@ModelAttribute("video") VideoModel videoModel,
			@org.springframework.web.bind.annotation.RequestParam(value = "posterFile", required = false) MultipartFile posterFile) {
		Video entity;
		
		try {
			// Nếu là edit, lấy video hiện tại
			if (videoModel.getIsEdit() != null && videoModel.getIsEdit() && videoModel.getVideold() != null) {
				Optional<Video> existingVideo = videoService.findById(videoModel.getVideold());
				if (existingVideo.isPresent()) {
					entity = existingVideo.get();
				} else {
					entity = new Video();
				}
			} else {
				entity = new Video();
			}
			
			// Copy properties thủ công
			if (videoModel.getTitle() != null) {
				entity.setTitle(videoModel.getTitle());
			}
			if (videoModel.getViews() != null) {
				entity.setViews(videoModel.getViews());
			}
			if (videoModel.getDescription() != null) {
				entity.setDescription(videoModel.getDescription());
			}
			if (videoModel.getActive() != null) {
				entity.setActive(videoModel.getActive());
			}
			
			// Xử lý upload poster
			String oldPoster = entity.getPoster();
			if (posterFile != null && !posterFile.isEmpty()) {
				// Xóa poster cũ nếu có
				if (oldPoster != null && !oldPoster.isEmpty() && !oldPoster.startsWith("http")) {
					fileStorageService.deleteFile(oldPoster);
				}
				
				// Lưu poster mới
				String newPosterPath = fileStorageService.storeFile(posterFile);
				entity.setPoster(newPosterPath);
			} else {
				// Nếu không upload poster mới, sử dụng URL từ form hoặc giữ nguyên
				if (videoModel.getPoster() != null && !videoModel.getPoster().isEmpty()) {
					entity.setPoster(videoModel.getPoster());
				} else if (oldPoster != null) {
					entity.setPoster(oldPoster);
				}
			}
		} catch (Exception e) {
			model.addAttribute("error", "Lỗi khi xử lý dữ liệu: " + e.getMessage());
			model.addAttribute("video", videoModel);
			List<Category> categories = categoryService.findAll();
			model.addAttribute("categories", categories);
			return new ModelAndView("admin/videos/addOrEdit", model);
		}

		if (videoModel.getCategoryId() != null) {
			Optional<Category> optCategory = categoryService.findById(videoModel.getCategoryId());
			if (optCategory.isPresent()) {
				entity.setCategory(optCategory.get());
			}
		}

		videoService.save(entity);

		String message = "";
		if (videoModel.getIsEdit() != null && videoModel.getIsEdit()) {
			message = "Cập nhật video thành công!";
		} else {
			message = "Thêm video thành công!";
		}

		model.addAttribute("message", message);
		return new ModelAndView("redirect:/admin/videos", model);
	}

	@GetMapping("edit/{id}")
	public ModelAndView edit(ModelMap model, @PathVariable("id") Integer id) {
		Optional<Video> optVideo = videoService.findById(id);
		VideoModel videoModel = new VideoModel();

		if (optVideo.isPresent()) {
			Video entity = optVideo.get();
			BeanUtils.copyProperties(entity, videoModel);
			if (entity.getCategory() != null) {
				videoModel.setCategoryId(entity.getCategory().getCategoryId());
			}
			videoModel.setIsEdit(true);
			model.addAttribute("video", videoModel);
			List<Category> categories = categoryService.findAll();
			model.addAttribute("categories", categories);
			return new ModelAndView("admin/videos/addOrEdit", model);
		}

		model.addAttribute("message", "Video không tồn tại!");
		return new ModelAndView("redirect:/admin/videos", model);
	}

	@GetMapping("delete/{id}")
	public ModelAndView delete(ModelMap model, @PathVariable("id") Integer id) {
		videoService.deleteById(id);
		model.addAttribute("message", "Xóa video thành công!");
		return new ModelAndView("redirect:/admin/videos", model);
	}
}

