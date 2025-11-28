package LapTrinhWeb.SpringBoot.Service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import LapTrinhWeb.SpringBoot.Entity.Category;

public interface CategoryService {
	List<Category> findAll();
	Optional<Category> findById(Integer id);
	Category save(Category category);
	void deleteById(Integer id);
	List<Category> findByCategorynameContaining(String name);
	Page<Category> findByCategorynameContaining(String name, Pageable pageable);
	List<Category> findByUserUsername(String username);
}

