<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đăng Nhập - Quản Lý Sinh Viên</title>
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
		overflow: hidden;
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
	
	.login-container {
		position: relative;
		z-index: 1;
		width: 100%;
		max-width: 450px;
		padding: 20px;
	}
	
	.login-card {
		background: rgba(255, 255, 255, 0.95);
		backdrop-filter: blur(10px);
		border-radius: 20px;
		box-shadow: 0 20px 60px rgba(0,0,0,0.3);
		overflow: hidden;
		transition: transform 0.3s ease;
	}
	
	.login-card:hover {
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
	
	.card-header-custom i {
		font-size: 32px;
	}
	
	.card-body {
		padding: 40px;
	}
	
	.form-label {
		font-weight: 600;
		color: #333;
		margin-bottom: 8px;
	}
	
	.input-group {
		margin-bottom: 20px;
	}
	
	.input-group-text {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		color: white;
		border: none;
		border-radius: 10px 0 0 10px;
		width: 50px;
		justify-content: center;
	}
	
	.form-control {
		border-radius: 0 10px 10px 0;
		border: 2px solid #e0e0e0;
		padding: 12px 15px;
		transition: all 0.3s ease;
	}
	
	.form-control:focus {
		border-color: #667eea;
		box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
	}
	
	.btn-login {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		border: none;
		border-radius: 10px;
		padding: 12px 30px;
		font-weight: 600;
		font-size: 16px;
		transition: all 0.3s ease;
		box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
	}
	
	.btn-login:hover {
		transform: translateY(-2px);
		box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
	}
	
	.btn-register {
		border: 2px solid #667eea;
		color: #667eea;
		border-radius: 10px;
		padding: 12px 30px;
		font-weight: 600;
		transition: all 0.3s ease;
	}
	
	.btn-register:hover {
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
	
	.form-check {
		display: flex;
		align-items: center;
		gap: 10px;
		padding: 10px;
		background: rgba(102, 126, 234, 0.05);
		border-radius: 8px;
		transition: all 0.3s ease;
	}
	
	.form-check:hover {
		background: rgba(102, 126, 234, 0.1);
	}
	
	.form-check-input {
		width: 20px;
		height: 20px;
		cursor: pointer;
		border: 2px solid #667eea;
		border-radius: 4px;
	}
	
	.form-check-input:checked {
		background-color: #667eea;
		border-color: #667eea;
	}
	
	.form-check-label {
		cursor: pointer;
		color: #333;
		font-weight: 500;
		margin: 0;
	}
	
	.form-check-label i {
		color: #667eea;
		margin-right: 5px;
	}
</style>
</head>
<body>
	<div class="login-container">
		<div class="login-card">
			<div class="card-header-custom">
				<div class="brand-logo">
					<i class="fas fa-graduation-cap"></i>
				</div>
				<h3><i class="fas fa-sign-in-alt"></i> Đăng Nhập</h3>
				<p class="mb-0 mt-2" style="opacity: 0.9;">Chào mừng bạn trở lại!</p>
			</div>
			<div class="card-body">
				<!-- Hiển thị thông báo -->
				<c:if test="${message != null}">
					<div class="alert alert-success alert-dismissible fade show" role="alert">
						<i class="fas fa-check-circle"></i> ${message}
						<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
					</div>
				</c:if>
				
				<!-- Hiển thị lỗi -->
				<c:if test="${error != null}">
					<div class="alert alert-danger alert-dismissible fade show" role="alert">
						<i class="fas fa-exclamation-circle"></i> ${error}
						<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
					</div>
				</c:if>
				
						<form action="<c:url value='/login' />" method="POST">
					<div class="mb-4">
						<label for="username" class="form-label">Username</label>
						<div class="input-group">
							<span class="input-group-text"><i class="fas fa-user"></i></span>
							<input type="text" class="form-control" id="username" name="username" 
								placeholder="Nhập username của bạn" required autofocus>
						</div>
					</div>
					
					<div class="mb-4">
						<label for="password" class="form-label">Password</label>
						<div class="input-group">
							<span class="input-group-text"><i class="fas fa-lock"></i></span>
							<input type="password" class="form-control" id="password" name="password" 
								placeholder="Nhập password của bạn" required>
						</div>
					</div>
					
					<div class="mb-4">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe" value="true">
							<label class="form-check-label" for="rememberMe">
								<i class="fas fa-bookmark"></i> Ghi nhớ đăng nhập
							</label>
						</div>
					</div>
					
					<div class="d-grid gap-2 mb-3">
						<button type="submit" class="btn btn-primary btn-login">
							<i class="fas fa-sign-in-alt"></i> Đăng Nhập
						</button>
					</div>
					
					<div class="text-center">
						<a href="<c:url value='/register' />" class="btn btn-outline-primary btn-register w-100">
							<i class="fas fa-user-plus"></i> Chưa có tài khoản? Đăng ký ngay
						</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
