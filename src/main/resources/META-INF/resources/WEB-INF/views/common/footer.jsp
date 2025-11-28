<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<style>
	footer {
		/* Nền tối, chuyển nhẹ từ đen sang đen xám */
		background: linear-gradient(to top, #000000 0%, #0b0f19 100%);
		color: #a0aec0; /* Màu chữ xám sáng */
		padding: 50px 0 30px;
		margin-top: 80px;
		position: relative;
		font-family: 'Segoe UI', sans-serif;
	}
	
	/* Đường kẻ phát sáng màu cam ở trên cùng */
	footer::before {
		content: '';
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		height: 1px;
		/* Gradient cam mờ dần về 2 bên */
		background: linear-gradient(90deg, transparent, rgba(255, 87, 34, 0.8), transparent);
		box-shadow: 0 0 10px rgba(255, 87, 34, 0.5); /* Hiệu ứng tỏa sáng */
	}
	
	.footer-content {
		text-align: center;
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 15px;
	}
	
	/* Tên thương hiệu Gradient */
	.brand-name {
		font-weight: 800;
		background: linear-gradient(135deg, #ff9800 0%, #ff5722 100%);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
		font-size: 1.1rem;
		letter-spacing: 0.5px;
	}
	
	.copyright-text {
		font-size: 0.95rem;
		margin: 0;
		opacity: 0.8;
	}

	/* Nút GitHub style kính mờ */
	.github-link {
		color: #fff;
		text-decoration: none;
		transition: all 0.3s ease;
		display: inline-flex;
		align-items: center;
		gap: 10px;
		font-weight: 500;
		padding: 10px 24px;
		border-radius: 50px;
		background: rgba(255, 255, 255, 0.05);
		border: 1px solid rgba(255, 255, 255, 0.1);
		margin-top: 10px;
	}
	
	.github-link:hover {
		background: rgba(255, 87, 34, 0.1); /* Nền cam nhạt khi hover */
		border-color: #ff5722;
		color: #ff7043;
		transform: translateY(-3px);
		box-shadow: 0 5px 15px rgba(0,0,0,0.3);
	}
	
	.github-link i {
		font-size: 20px;
	}
</style>

<footer>
	<div class="container">
		<div class="footer-content">
			<p class="copyright-text">
				&copy; 2025 <span class="brand-name">Đặc Sản Việt</span>. All rights reserved.
			</p>
			
			<div style="font-size: 0.85rem; color: #718096;">
				Bài Tập 5 Spring Boot - GVHD: Nguyen Huu Trung
			</div>

			<a href="https://github.com/teehihi/QuanLySinhVienBT5SpringBoot.git" 
			   target="_blank" rel="noopener noreferrer" class="github-link">
				<i class="fab fa-github"></i>
				<span>Source Code on GitHub</span>
			</a>
		</div>
	</div>
</footer>