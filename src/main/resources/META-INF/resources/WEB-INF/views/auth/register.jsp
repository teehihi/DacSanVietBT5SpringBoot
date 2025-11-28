<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đăng Ký - Quản Lý Sinh Viên</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
	* {
		margin: 0;
		padding: 0;
		box-sizing: border-box;
	}
	
	body {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
		min-height: 100vh;
		display: flex;
		align-items: center;
		justify-content: center;
		font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
		position: relative;
		overflow-x: hidden;
		padding: 20px 0;
	}
	
	body::before {
		content: '';
		position: absolute;
		width: 200%;
		height: 200%;
		background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
		background-size: 50px 50px;
		animation: move 20s linear infinite;
		opacity: 0.3;
	}
	
	@keyframes move {
		0% { transform: translate(0, 0); }
		100% { transform: translate(50px, 50px); }
	}
	
	.register-container {
		position: relative;
		z-index: 1;
		width: 100%;
		max-width: 600px;
		padding: 20px;
	}
	
	.register-card {
		background: rgba(255, 255, 255, 0.95);
		backdrop-filter: blur(10px);
		border-radius: 20px;
		box-shadow: 0 20px 60px rgba(0,0,0,0.3);
		overflow: hidden;
		transition: transform 0.3s ease;
	}
	
	.register-card:hover {
		transform: translateY(-5px);
	}
	
	.card-header-custom {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		color: white;
		padding: 30px;
		text-align: center;
		position: relative;
	}
	
	.card-header-custom::after {
		content: '';
		position: absolute;
		bottom: 0;
		left: 0;
		right: 0;
		height: 4px;
		background: linear-gradient(90deg, transparent, rgba(255,255,255,0.5), transparent);
	}
	
	.card-header-custom h3 {
		margin: 0;
		font-weight: 600;
		font-size: 28px;
		display: flex;
		align-items: center;
		justify-content: center;
		gap: 10px;
	}
	
	.card-body {
		padding: 40px;
	}
	
	.form-label {
		font-weight: 600;
		color: #333;
		margin-bottom: 8px;
	}
	
	.form-control {
		border-radius: 10px;
		border: 2px solid #e0e0e0;
		padding: 12px 15px;
		transition: all 0.3s ease;
		margin-bottom: 5px;
	}
	
	.form-control:focus {
		border-color: #667eea;
		box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
	}
	
	.btn-register-submit {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		border: none;
		border-radius: 10px;
		padding: 12px 30px;
		font-weight: 600;
		font-size: 16px;
		transition: all 0.3s ease;
		box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
	}
	
	.btn-register-submit:hover {
		transform: translateY(-2px);
		box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
	}
	
	.btn-login-link {
		border: 2px solid #667eea;
		color: #667eea;
		border-radius: 10px;
		padding: 12px 30px;
		font-weight: 600;
		transition: all 0.3s ease;
	}
	
	.btn-login-link:hover {
		background: #667eea;
		color: white;
		transform: translateY(-2px);
	}
	
	.alert {
		border-radius: 10px;
		border: none;
		margin-bottom: 20px;
	}
	
	.brand-logo {
		width: 60px;
		height: 60px;
		background: white;
		border-radius: 15px;
		display: flex;
		align-items: center;
		justify-content: center;
		margin: 0 auto 15px;
		box-shadow: 0 4px 15px rgba(0,0,0,0.1);
	}
	
	.brand-logo i {
		font-size: 32px;
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
		background-clip: text;
	}
	
	.text-danger {
		color: #dc3545 !important;
	}
	
	.text-muted {
		font-size: 0.875rem;
	}
</style>
</head>
<body>
	<div class="register-container">
		<div class="register-card">
			<div class="card-header-custom">
				<div class="brand-logo">
					<i class="fas fa-user-plus"></i>
				</div>
				<h3><i class="fas fa-user-plus"></i> Đăng Ký Tài Khoản</h3>
				<p class="mb-0 mt-2" style="opacity: 0.9;">Tạo tài khoản mới để bắt đầu</p>
			</div>
			<div class="card-body">
				<!-- Hiển thị lỗi -->
				<c:if test="${error != null}">
					<div class="alert alert-danger alert-dismissible fade show" role="alert">
						<i class="fas fa-exclamation-circle"></i> ${error}
						<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
					</div>
				</c:if>
				
				<form action="<c:url value='/register/save' />" method="POST">
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="username" class="form-label">Username <span class="text-danger">*</span></label>
							<input type="text" class="form-control" id="username" name="username" 
								value="${user.username}" placeholder="Nhập username" required>
							<small class="text-muted">Username sẽ được dùng để đăng nhập</small>
						</div>
						
						<div class="col-md-6 mb-3">
							<label for="password" class="form-label">Password <span class="text-danger">*</span></label>
							<input type="password" class="form-control" id="password" name="password" 
								placeholder="Nhập password" required minlength="6">
							<small class="text-muted">Tối thiểu 6 ký tự</small>
						</div>
					</div>
					
					<div class="mb-3">
						<label for="fullname" class="form-label">Họ Tên <span class="text-danger">*</span></label>
						<input type="text" class="form-control" id="fullname" name="fullname" 
							value="${user.fullname}" placeholder="Nhập họ tên đầy đủ" required>
					</div>
					
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="email" class="form-label">Email</label>
							<input type="email" class="form-control" id="email" name="email" 
								value="${user.email}" placeholder="example@email.com">
						</div>
						
						<div class="col-md-6 mb-3">
							<label for="phone" class="form-label">Điện Thoại</label>
							<input type="text" class="form-control" id="phone" name="phone" 
								value="${user.phone}" placeholder="0123456789">
						</div>
					</div>
					
					<div class="d-grid gap-2 mb-3">
						<button type="submit" class="btn btn-primary btn-register-submit">
							<i class="fas fa-user-plus"></i> Đăng Ký Ngay
						</button>
					</div>
					
					<div class="text-center">
						<a href="<c:url value='/login' />" class="btn btn-outline-primary btn-login-link w-100">
							<i class="fas fa-sign-in-alt"></i> Đã có tài khoản? Đăng nhập
						</a>
					</div>
					
					<hr class="my-4">
					
					<div class="alert alert-info">
						<strong><i class="fas fa-info-circle"></i> Lưu ý:</strong>
						<ul class="mb-0 mt-2" style="font-size: 0.9rem;">
							<li>Tài khoản mới đăng ký mặc định là <strong>User</strong></li>
							<li>Để trở thành <strong>Admin</strong>, vui lòng xem hướng dẫn trong file README</li>
						</ul>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
