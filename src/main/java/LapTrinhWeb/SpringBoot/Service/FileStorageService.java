package LapTrinhWeb.SpringBoot.Service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileStorageService {

	private final Path fileStorageLocation;

	public FileStorageService() {
		// Tạo thư mục uploads trong thư mục static
		this.fileStorageLocation = Paths.get("src/main/resources/static/images/uploads")
				.toAbsolutePath().normalize();
		try {
			Files.createDirectories(this.fileStorageLocation);
		} catch (Exception ex) {
			throw new RuntimeException("Không thể tạo thư mục lưu file.", ex);
		}
	}

	public String storeFile(MultipartFile file) {
		if (file == null || file.isEmpty()) {
			return null;
		}

		// Lấy tên file gốc
		String originalFilename = StringUtils.cleanPath(file.getOriginalFilename());
		
		try {
			// Kiểm tra tên file có chứa ký tự không hợp lệ
			if (originalFilename.contains("..")) {
				throw new RuntimeException("Tên file không hợp lệ: " + originalFilename);
			}

			// Tạo tên file mới với UUID để tránh trùng lặp
			String fileExtension = "";
			int lastDotIndex = originalFilename.lastIndexOf(".");
			if (lastDotIndex > 0) {
				fileExtension = originalFilename.substring(lastDotIndex);
			}
			String newFilename = UUID.randomUUID().toString() + fileExtension;

			// Lưu file
			Path targetLocation = this.fileStorageLocation.resolve(newFilename);
			Files.copy(file.getInputStream(), targetLocation, StandardCopyOption.REPLACE_EXISTING);

			// Trả về đường dẫn tương đối để lưu vào DB
			return "uploads/" + newFilename;
		} catch (IOException ex) {
			throw new RuntimeException("Không thể lưu file: " + originalFilename, ex);
		}
	}

	public boolean deleteFile(String filename) {
		if (filename == null || filename.isEmpty()) {
			return false;
		}

		try {
			// Xử lý đường dẫn tương đối
			String actualFilename = filename;
			if (filename.startsWith("uploads/")) {
				actualFilename = filename.substring(8); // Bỏ "uploads/" prefix
			}
			
			Path filePath = this.fileStorageLocation.resolve(actualFilename);
			return Files.deleteIfExists(filePath);
		} catch (IOException ex) {
			System.err.println("Lỗi khi xóa file: " + ex.getMessage());
			return false;
		}
	}
}

