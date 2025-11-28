<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Trang Chủ - Quản Lý Sinh Viên</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
	body {
		background: #0f0f23;
		color: #ffffff;
		font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
		min-height: 100vh;
	}
	
	.hero-section {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
		padding: 100px 0;
		color: white;
		text-align: center;
		border-radius: 24px;
		margin-bottom: 50px;
		position: relative;
		overflow: hidden;
		box-shadow: 0 20px 60px rgba(102, 126, 234, 0.3);
	}
	
	.hero-section::before {
		content: '';
		position: absolute;
		width: 200%;
		height: 200%;
		background: radial-gradient(circle, rgba(255,255,255,0.15) 1px, transparent 1px);
		background-size: 60px 60px;
		animation: move 25s linear infinite;
		opacity: 0.4;
	}
	
	@keyframes move {
		0% { transform: translate(0, 0); }
		100% { transform: translate(60px, 60px); }
	}
	
	.hero-content {
		position: relative;
		z-index: 1;
	}
	
	.hero-section h1 {
		font-size: 3.5rem;
		font-weight: 800;
		margin-bottom: 24px;
		text-shadow: 2px 4px 8px rgba(0,0,0,0.3);
		letter-spacing: -1px;
	}
	
	.hero-section p {
		font-size: 1.3rem;
		margin-bottom: 40px;
		opacity: 0.95;
		font-weight: 400;
		line-height: 1.6;
	}
	
	.btn-admin {
		background: rgba(255, 255, 255, 0.2);
		backdrop-filter: blur(10px);
		border: 2px solid rgba(255, 255, 255, 0.3);
		border-radius: 16px;
		padding: 16px 48px;
		font-weight: 700;
		font-size: 18px;
		transition: all 0.3s ease;
		box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
		color: white;
		text-decoration: none;
		display: inline-flex;
		align-items: center;
		gap: 12px;
	}
	
	.btn-admin:hover {
		background: rgba(255, 255, 255, 0.3);
		transform: translateY(-4px);
		box-shadow: 0 12px 40px rgba(0, 0, 0, 0.3);
		color: white;
		border-color: rgba(255, 255, 255, 0.5);
	}
	
	.user-info-card {
		background: linear-gradient(135deg, #16213e 0%, #1a1a2e 100%);
		border: 1px solid rgba(102, 126, 234, 0.2);
		border-radius: 20px;
		padding: 32px;
		box-shadow: 0 12px 40px rgba(0, 0, 0, 0.3);
		margin-bottom: 40px;
		backdrop-filter: blur(10px);
	}
	
	.user-info-card h3 {
		color: white;
		font-weight: 700;
		margin-bottom: 20px;
		display: flex;
		align-items: center;
		gap: 12px;
		font-size: 1.5rem;
	}
	
	.user-info-card h3 i {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
		background-clip: text;
	}
	
	.user-info-card hr {
		border-color: rgba(102, 126, 234, 0.3);
		margin: 24px 0;
	}
	
	.user-info-card p {
		color: rgba(255, 255, 255, 0.9);
		margin-bottom: 16px;
		font-size: 1rem;
	}
	
	.user-info-card strong {
		color: rgba(102, 126, 234, 1);
		font-weight: 600;
	}
	
	.feature-card {
		background: linear-gradient(135deg, #16213e 0%, #1a1a2e 100%);
		border: 1px solid rgba(102, 126, 234, 0.2);
		border-radius: 20px;
		box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
		transition: all 0.4s ease;
		height: 100%;
		padding: 40px 30px;
		text-align: center;
		backdrop-filter: blur(10px);
		position: relative;
		overflow: hidden;
	}
	
	.feature-card::before {
		content: '';
		position: absolute;
		top: 0;
		left: 0;
		right: 0;
		height: 4px;
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		transform: scaleX(0);
		transition: transform 0.4s ease;
	}
	
	.feature-card:hover {
		transform: translateY(-12px);
		box-shadow: 0 16px 48px rgba(102, 126, 234, 0.3);
		border-color: rgba(102, 126, 234, 0.5);
	}
	
	.feature-card:hover::before {
		transform: scaleX(1);
	}
	
	.feature-icon {
		font-size: 64px;
		margin-bottom: 24px;
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
		background-clip: text;
		display: inline-block;
		transition: transform 0.3s ease;
	}
	
	.feature-card:hover .feature-icon {
		transform: scale(1.1) rotate(5deg);
	}
	
	.feature-card h4 {
		color: white;
		font-weight: 700;
		margin-bottom: 16px;
		font-size: 1.3rem;
	}
	
	.feature-card p {
		color: rgba(255, 255, 255, 0.7);
		font-size: 0.95rem;
		line-height: 1.6;
		margin: 0;
	}
	
	.badge {
		padding: 8px 16px;
		border-radius: 20px;
		font-weight: 600;
		font-size: 0.85rem;
	}
	
	.badge.bg-danger {
		background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%) !important;
	}
	
	.badge.bg-success {
		background: linear-gradient(135deg, #10b981 0%, #059669 100%) !important;
	}
	
	.badge.bg-secondary {
		background: linear-gradient(135deg, #6b7280 0%, #4b5563 100%) !important;
	}
	
	@media (max-width: 768px) {
		.hero-section h1 {
			font-size: 2.5rem;
		}
		
		.hero-section p {
			font-size: 1.1rem;
		}
	}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="container-fluid px-4" style="padding-top: 20px;">
		<div class="hero-section">
			<div class="hero-content">
				<h1><i class="fas fa-graduation-cap"></i> Chào Mừng Đến Hệ Thống Quản Lý Sinh Viên</h1>
				<p>Quản lý thông tin người dùng, danh mục và video một cách dễ dàng và hiệu quả</p>
				<c:if test="${isAdmin}">
					<a href="<c:url value='/admin/users' />" class="btn-admin">
						<i class="fas fa-cog"></i> Vào Trang Quản Trị
					</a>
				</c:if>
			</div>
		</div>

		<div class="container">
			<c:if test="${user != null}">
				<div class="user-info-card">
					<h3><i class="fas fa-user"></i> Thông Tin Người Dùng</h3>
					<hr>
					<div class="row">
						<div class="col-md-6">
							<p><strong>Username:</strong> ${user.username}</p>
							<p><strong>Họ Tên:</strong> ${user.fullname != null ? user.fullname : 'Chưa cập nhật'}</p>
							<p><strong>Email:</strong> ${user.email != null ? user.email : 'Chưa cập nhật'}</p>
						</div>
						<div class="col-md-6">
							<p><strong>Điện Thoại:</strong> ${user.phone != null ? user.phone : 'Chưa cập nhật'}</p>
							<p><strong>Quyền:</strong> 
								<c:if test="${user.admin}">
									<span class="badge bg-danger">Admin</span>
								</c:if>
								<c:if test="${!user.admin}">
									<span class="badge bg-secondary">User</span>
								</c:if>
							</p>
							<p><strong>Trạng Thái:</strong> 
								<c:if test="${user.active}">
									<span class="badge bg-success">Hoạt động</span>
								</c:if>
								<c:if test="${!user.active}">
									<span class="badge bg-danger">Không hoạt động</span>
								</c:if>
							</p>
						</div>
					</div>
				</div>
			</c:if>
			
			<div class="row">
				<div class="col-md-4 mb-4">
					<a href="<c:url value='/admin/users' />" style="text-decoration: none; color: inherit;">
						<div class="card feature-card">
							<div class="feature-icon">
								<i class="fas fa-users"></i>
							</div>
							<h4>Quản Lý Người Dùng</h4>
							<p>Quản lý thông tin tất cả người dùng trong hệ thống một cách hiệu quả và dễ dàng</p>
						</div>
					</a>
				</div>
				<div class="col-md-4 mb-4">
					<a href="<c:url value='/admin/categories' />" style="text-decoration: none; color: inherit;">
						<div class="card feature-card">
							<div class="feature-icon">
								<i class="fas fa-folder"></i>
							</div>
							<h4>Quản Lý Danh Mục</h4>
							<p>Tổ chức và quản lý các danh mục video với giao diện trực quan và thân thiện</p>
						</div>
					</a>
				</div>
				<div class="col-md-4 mb-4">
					<a href="<c:url value='/admin/videos' />" style="text-decoration: none; color: inherit;">
						<div class="card feature-card">
							<div class="feature-icon">
								<i class="fas fa-video"></i>
							</div>
							<h4>Quản Lý Video</h4>
							<p>Quản lý video với tính năng tìm kiếm thông minh và phân loại linh hoạt</p>
						</div>
					</a>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
