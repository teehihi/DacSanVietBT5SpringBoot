package LapTrinhWeb.SpringBoot.Config;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import LapTrinhWeb.SpringBoot.Entity.User;
import LapTrinhWeb.SpringBoot.Service.UserService;

@Component
public class AdminInitializer implements CommandLineRunner {

	@Autowired
	private UserService userService;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Override
	public void run(String... args) throws Exception {
		// Kiểm tra xem đã có admin chưa
		Optional<User> adminOpt = userService.findById("admin");
		
		if (adminOpt.isEmpty()) {
			// Tạo user admin mặc định
			User admin = new User();
			admin.setUsername("admin");
			admin.setPassword(passwordEncoder.encode("admin123")); // Password mặc định: admin123
			admin.setFullname("Administrator");
			admin.setEmail("admin@example.com");
			admin.setPhone("0123456789");
			admin.setAdmin(true);
			admin.setActive(true);
			
			userService.save(admin);
			System.out.println("==========================================");
			System.out.println("Đã tạo tài khoản ADMIN mặc định:");
			System.out.println("Username: admin");
			System.out.println("Password: admin123");
			System.out.println("VUI LÒNG ĐỔI MẬT KHẨU SAU KHI ĐĂNG NHẬP!");
			System.out.println("==========================================");
		}
	}
}

