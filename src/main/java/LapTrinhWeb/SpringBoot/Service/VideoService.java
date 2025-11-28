package LapTrinhWeb.SpringBoot.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import LapTrinhWeb.SpringBoot.Entity.Video;

public interface VideoService {
	List<Video> findAll();
	Optional<Video> findById(Integer id);
	Video save(Video video);
	void deleteById(Integer id);
	List<Video> findByTitleContaining(String title);
	Page<Video> findByTitleContaining(String title, Pageable pageable);
	List<Video> findByCategoryCategoryId(Integer categoryId);
}

