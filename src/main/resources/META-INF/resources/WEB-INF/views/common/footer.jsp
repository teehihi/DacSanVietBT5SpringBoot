<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<style>
	footer {
		background: linear-gradient(135deg, #0f0f23 0%, #1a1a2e 100%);
		color: rgba(255, 255, 255, 0.8);
		padding: 40px 0 20px;
		margin-top: 60px;
		border-top: 1px solid rgba(102, 126, 234, 0.2);
		position: relative;
	}
	
	footer::before {
		content: '';
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		height: 1px;
		background: linear-gradient(90deg, transparent, rgba(102, 126, 234, 0.5), transparent);
	}
	
	.footer-content {
		text-align: center;
	}
	
	.footer-content p {
		margin: 12px 0;
		font-size: 14px;
		color: rgba(255, 255, 255, 0.7);
	}
	
	.footer-content a {
		color: rgba(102, 126, 234, 1);
		text-decoration: none;
		transition: all 0.3s ease;
		display: inline-flex;
		align-items: center;
		gap: 8px;
		font-weight: 500;
	}
	
	.footer-content a:hover {
		color: rgba(118, 75, 162, 1);
		transform: translateY(-2px);
		text-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
	}
	
	.footer-content i {
		font-size: 18px;
	}
	
	.footer-content strong {
		color: rgba(102, 126, 234, 1);
		font-weight: 700;
	}
</style>
<footer>
	<div class="container">
		<div class="footer-content">
			<p class="mb-2">
				&copy; 2025 <strong>Quản Lý Sinh Viên</strong> - Bài Tập 5 Spring Boot
			</p>
			<p class="mb-0">
				<a href="https://github.com/teehihi/QuanLySinhVienBT5SpringBoot.git" 
				   target="_blank" rel="noopener noreferrer">
					<i class="fab fa-github"></i>
					<span>GitHub Repository</span>
				</a>
			</p>
		</div>
	</div>
</footer>
