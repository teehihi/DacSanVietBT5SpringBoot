<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đăng Nhập - Đặc Sản Việt</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
	/* --- CẤU HÌNH NỀN TỐI --- */
	body {
		background-color: #080b12;
		/* Gradient nền giống Hero Section */
		background-image: radial-gradient(circle at 10% 20%, rgba(255, 87, 34, 0.1) 0%, transparent 40%),
						  radial-gradient(circle at 90% 80%, rgba(234, 60, 18, 0.1) 0%, transparent 40%);
		min-height: 100vh;
		display: flex;
		align-items: center;
		justify-content: center;
		font-family: 'Segoe UI', sans-serif;
		color: #fff;
		position: relative;
		overflow: hidden;
	}

	/* Hiệu ứng hạt bụi bay (Animation) */
	body::before {
		content: '';
		position: absolute;
		width: 100%;
		height: 100%;
		background: url('data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAiIGhlaWdodD0iMjAiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PGNpcmNsZSBjeD0iMSIgY3k9IjEiIHI9IjEiIGZpbGw9InJnYmEoMjU1LDI1NSwyNTUsMC4xKSIvPjwvc3ZnPg==');
		animation: moveBackground 50s linear infinite;
		opacity: 0.5;
		z-index: 0;
	}
	
	@keyframes moveBackground {
		from { background-position: 0 0; }
		to { background-position: 1000px 1000px; }
	}

	.login-container {
		position: relative;
		z-index: 1;
		width: 100%;
		max-width: 420px;
		padding: 20px;
	}

	/* --- CARD GIAO DIỆN --- */
	.login-card {
		background: #111621; /* Nền card tối */
		border: 1px solid rgba(255, 255, 255, 0.08);
		border-radius: 24px;
		box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5); /* Bóng đen sâu */
		overflow: hidden;
		padding: 40px 30px;
	}

	/* Logo & Tiêu đề */
	.brand-header {
		text-align: center;
		margin-bottom: 30px;
	}

	.brand-logo {
		width: 70px;
		height: 70px;
		border-radius: 18px;
		margin-bottom: 15px;
		box-shadow: 0 0 20px rgba(255, 87, 34, 0.3);
		object-fit: cover;
	}

	.login-title {
		font-weight: 700;
		font-size: 1.8rem;
		margin-bottom: 5px;
		color: #fff;
	}

	.login-subtitle {
		color: #a0aec0;
		font-size: 0.95rem;
	}

	/* --- FORM INPUTS --- */
	.form-label {
		color: #e2e8f0;
		font-weight: 500;
		font-size: 0.9rem;
	}

	.input-group-text {
		background: #1a202c;
		border: 1px solid #2d3748;
		border-right: none;
		color: #ff7043; /* Icon màu cam */
		border-radius: 12px 0 0 12px;
	}

	.form-control {
		background: #1a202c;
		border: 1px solid #2d3748;
		border-left: none;
		color: #fff;
		padding: 12px 15px;
		border-radius: 0 12px 12px 0;
	}

	.form-control:focus {
		background: #1a202c;
		color: #fff;
		border-color: #ff5722;
		box-shadow: none;
	}

	.form-control:focus + .input-group-text,
	.input-group:focus-within .input-group-text {
		border-color: #ff5722;
	}

	.form-control::placeholder {
		color: #718096;
	}

	/* --- BUTTONS --- */
	.btn-login {
		background: linear-gradient(45deg, #ff5722, #ff8a50);
		border: none;
		border-radius: 50px;
		padding: 12px;
		font-weight: 700;
		width: 100%;
		color: white;
		margin-top: 10px;
		transition: all 0.3s;
		box-shadow: 0 5px 15px rgba(255, 87, 34, 0.3);
	}

	.btn-login:hover {
		transform: translateY(-2px);
		box-shadow: 0 8px 25px rgba(255, 87, 34, 0.5);
		color: white;
	}

	.divider {
		display: flex;
		align-items: center;
		text-align: center;
		color: #718096;
		margin: 25px 0;
		font-size: 0.85rem;
	}

	.divider::before, .divider::after {
		content: '';
		flex: 1;
		border-bottom: 1px solid rgba(255,255,255,0.1);
	}

	.divider span {
		padding: 0 10px;
	}

	.btn-register-link {
		background: transparent;
		border: 1px solid rgba(255,255,255,0.2);
		color: #e2e8f0;
		border-radius: 50px;
		padding: 10px;
		width: 100%;
		font-weight: 600;
		transition: all 0.3s;
		display: block;
		text-align: center;
		text-decoration: none;
	}

	.btn-register-link:hover {
		border-color: #ff5722;
		color: #ff5722;
		background: rgba(255, 87, 34, 0.05);
	}

	/* Checkbox & Alerts */
	.form-check-input {
		background-color: #2d3748;
		border-color: #4a5568;
		cursor: pointer;
	}
	
	.form-check-input:checked {
		background-color: #ff5722;
		border-color: #ff5722;
	}
	
	.form-check-label {
		color: #a0aec0;
		font-size: 0.9rem;
		cursor: pointer;
	}

	.alert {
		background: rgba(255, 50, 50, 0.1);
		border: 1px solid rgba(255, 50, 50, 0.2);
		color: #ff8a80;
		font-size: 0.9rem;
		border-radius: 12px;
	}
	
	.alert-success {
		background: rgba(0, 200, 83, 0.1);
		border-color: rgba(0, 200, 83, 0.2);
		color: #69f0ae;
	}
</style>
</head>
<body>
	<div class="login-container">
		<div class="login-card">
			<div class="brand-header">
				<img src="https://files.catbox.moe/c373f9.webp" alt="Logo" class="brand-logo">
				<h3 class="login-title">Đăng Nhập</h3>
				<p class="login-subtitle">Chào mừng bạn trở lại với Đặc Sản Việt</p>
			</div>

			<c:if test="${message != null}">
				<div class="alert alert-success alert-dismissible fade show">
					<i class="fas fa-check-circle me-2"></i> ${message}
					<button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert"></button>
				</div>
			</c:if>
			
			<c:if test="${error != null}">
				<div class="alert alert-danger alert-dismissible fade show">
					<i class="fas fa-exclamation-triangle me-2"></i> ${error}
					<button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert"></button>
				</div>
			</c:if>

			<form action="<c:url value='/login' />" method="POST">
				<div class="mb-4">
					<label for="username" class="form-label">Tên đăng nhập</label>
					<div class="input-group">
						<span class="input-group-text"><i class="fas fa-user"></i></span>
						<input type="text" class="form-control" id="username" name="username" 
							placeholder="Nhập username" required autofocus>
					</div>
				</div>
				
				<div class="mb-4">
					<label for="password" class="form-label">Mật khẩu</label>
					<div class="input-group">
						<span class="input-group-text"><i class="fas fa-lock"></i></span>
						<input type="password" class="form-control" id="password" name="password" 
							placeholder="Nhập mật khẩu" required>
					</div>
				</div>
				
				<div class="d-flex justify-content-between align-items-center mb-4">
					<div class="form-check">
						<input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe" value="true">
						<label class="form-check-label" for="rememberMe">Ghi nhớ tôi</label>
					</div>
					<a href="#" class="text-decoration-none" style="color: #ff7043; font-size: 0.9rem;">Quên mật khẩu?</a>
				</div>
				
				<button type="submit" class="btn btn-login">
					ĐĂNG NHẬP
				</button>
				
				<div class="divider">
					<span>Chưa có tài khoản?</span>
				</div>
				
				<a href="<c:url value='/register' />" class="btn btn-register-link">
					Tạo tài khoản mới
				</a>
			</form>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>