<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Thông Tin Cá Nhân - Quản Lý Sinh Viên</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
	body {
		background: #0f0f23;
		color: #ffffff;
		font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
		min-height: 100vh;
	}
	
	.profile-container {
		max-width: 900px;
		margin: 0 auto;
		padding: 40px 20px;
	}
	
	.profile-header {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		border-radius: 20px;
		padding: 40px;
		margin-bottom: 30px;
		text-align: center;
		box-shadow: 0 20px 60px rgba(102, 126, 234, 0.3);
		position: relative;
		overflow: hidden;
	}
	
	.profile-header::before {
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
	
	.profile-avatar {
		width: 120px;
		height: 120px;
		border-radius: 50%;
		background: rgba(255, 255, 255, 0.2);
		backdrop-filter: blur(10px);
		display: flex;
		align-items: center;
		justify-content: center;
		color: white;
		font-weight: 700;
		font-size: 48px;
		border: 4px solid rgba(255, 255, 255, 0.3);
		margin: 0 auto 20px;
		position: relative;
		z-index: 1;
		box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
	}
	
	.profile-name {
		font-size: 2.5rem;
		font-weight: 800;
		margin-bottom: 10px;
		position: relative;
		z-index: 1;
		text-shadow: 2px 4px 8px rgba(0,0,0,0.3);
	}
	
	.profile-username {
		font-size: 1.2rem;
		opacity: 0.9;
		position: relative;
		z-index: 1;
	}
	
	.profile-badge {
		display: inline-block;
		margin-top: 15px;
		padding: 8px 20px;
		background: rgba(255, 255, 255, 0.2);
		backdrop-filter: blur(10px);
		border-radius: 20px;
		font-weight: 600;
		position: relative;
		z-index: 1;
	}
	
	.profile-card {
		background: linear-gradient(135deg, #16213e 0%, #1a1a2e 100%);
		border: 1px solid rgba(102, 126, 234, 0.2);
		border-radius: 20px;
		padding: 32px;
		box-shadow: 0 12px 40px rgba(0, 0, 0, 0.3);
		margin-bottom: 30px;
		backdrop-filter: blur(10px);
	}
	
	.profile-card h3 {
		color: white;
		font-weight: 700;
		margin-bottom: 24px;
		display: flex;
		align-items: center;
		gap: 12px;
		font-size: 1.5rem;
		border-bottom: 2px solid rgba(102, 126, 234, 0.3);
		padding-bottom: 15px;
	}
	
	.profile-card h3 i {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
		background-clip: text;
	}
	
	.info-row {
		display: flex;
		align-items: center;
		padding: 15px 0;
		border-bottom: 1px solid rgba(255, 255, 255, 0.1);
	}
	
	.info-row:last-child {
		border-bottom: none;
	}
	
	.info-label {
		font-weight: 600;
		color: rgba(102, 126, 234, 1);
		min-width: 150px;
		display: flex;
		align-items: center;
		gap: 10px;
	}
	
	.info-label i {
		width: 20px;
		text-align: center;
	}
	
	.info-value {
		color: rgba(255, 255, 255, 0.9);
		flex: 1;
	}
	
	.badge {
		padding: 6px 16px;
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
	
	.btn-back {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		border: none;
		border-radius: 10px;
		padding: 12px 30px;
		font-weight: 600;
		color: white;
		text-decoration: none;
		display: inline-flex;
		align-items: center;
		gap: 10px;
		transition: all 0.3s ease;
		box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
	}
	
	.btn-back:hover {
		transform: translateY(-2px);
		box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
		color: white;
	}
	
	.form-control[type="file"] {
		cursor: pointer;
	}
	
	.form-control[type="file"]::-webkit-file-upload-button {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		color: white;
		border: none;
		padding: 8px 16px;
		border-radius: 8px;
		cursor: pointer;
		margin-right: 10px;
		font-weight: 600;
	}
	
	.form-control[type="file"]::-webkit-file-upload-button:hover {
		opacity: 0.9;
	}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="profile-container">
		<div class="profile-header">
			<div class="profile-avatar">
				<c:choose>
					<c:when test="${user.fullname != null && !empty user.fullname}">
						${user.fullname.substring(0, 1).toUpperCase()}
					</c:when>
					<c:otherwise>
						${user.username.substring(0, 1).toUpperCase()}
					</c:otherwise>
				</c:choose>
			</div>
			<h1 class="profile-name">
				${user.fullname != null ? user.fullname : user.username}
			</h1>
			<div class="profile-username">
				<i class="fas fa-user"></i> @${user.username}
			</div>
			<c:if test="${user.admin}">
				<span class="profile-badge">
					<i class="fas fa-crown"></i> Quản Trị Viên
				</span>
			</c:if>
		</div>
		
		<!-- Hiển thị thông báo -->
		<c:if test="${message != null}">
			<div class="alert alert-success alert-dismissible fade show" role="alert" style="background: rgba(16, 185, 129, 0.2); border: 1px solid rgba(16, 185, 129, 0.3); color: #10b981; border-radius: 12px; margin-bottom: 20px;">
				<i class="fas fa-check-circle"></i> ${message}
				<button type="button" class="btn-close" data-bs-dismiss="alert" style="filter: brightness(0) invert(1);"></button>
			</div>
		</c:if>
		
		<c:if test="${error != null}">
			<div class="alert alert-danger alert-dismissible fade show" role="alert" style="background: rgba(239, 68, 68, 0.2); border: 1px solid rgba(239, 68, 68, 0.3); color: #ef4444; border-radius: 12px; margin-bottom: 20px;">
				<i class="fas fa-exclamation-circle"></i> ${error}
				<button type="button" class="btn-close" data-bs-dismiss="alert" style="filter: brightness(0) invert(1);"></button>
			</div>
		</c:if>
		
		<div class="profile-card">
			<h3><i class="fas fa-edit"></i> Chỉnh Sửa Thông Tin Cá Nhân</h3>
			<form action="<c:url value='/profile/update' />" method="POST" enctype="multipart/form-data">
				<input type="hidden" name="username" value="${user.username}">
				<input type="hidden" name="isEdit" value="true">
				
				<div class="info-row">
					<div class="info-label">
						<i class="fas fa-user"></i> Username:
					</div>
					<div class="info-value">
						<input type="text" class="form-control" value="${user.username}" readonly style="background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2); color: rgba(255,255,255,0.7);">
						<small class="text-muted" style="color: rgba(255,255,255,0.5);">Username không thể thay đổi</small>
					</div>
				</div>
				
				<div class="info-row">
					<div class="info-label">
						<i class="fas fa-id-card"></i> Họ Tên:
					</div>
					<div class="info-value">
						<input type="text" class="form-control" name="fullname" value="${user.fullname != null ? user.fullname : ''}" 
							placeholder="Nhập họ tên" style="background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2); color: white;">
					</div>
				</div>
				
				<div class="info-row">
					<div class="info-label">
						<i class="fas fa-envelope"></i> Email:
					</div>
					<div class="info-value">
						<input type="email" class="form-control" name="email" value="${user.email != null ? user.email : ''}" 
							placeholder="Nhập email" style="background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2); color: white;">
					</div>
				</div>
				
				<div class="info-row">
					<div class="info-label">
						<i class="fas fa-phone"></i> Điện Thoại:
					</div>
					<div class="info-value">
						<input type="text" class="form-control" name="phone" value="${user.phone != null ? user.phone : ''}" 
							placeholder="Nhập số điện thoại" style="background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2); color: white;">
					</div>
				</div>
				
				<div class="info-row">
					<div class="info-label">
						<i class="fas fa-image"></i> Ảnh Đại Diện:
					</div>
					<div class="info-value">
						<c:if test="${user.images != null && !empty user.images}">
							<div class="mb-2">
								<c:choose>
									<c:when test="${user.images.startsWith('http')}">
										<img src="${user.images}" 
											alt="Avatar" 
											style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover; border: 3px solid rgba(102, 126, 234, 0.5);">
									</c:when>
									<c:otherwise>
										<img src="<c:url value='/images/${user.images}' />" 
											alt="Avatar" 
											style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover; border: 3px solid rgba(102, 126, 234, 0.5);">
									</c:otherwise>
								</c:choose>
							</div>
						</c:if>
						<div class="mb-2">
							<label for="avatarFile" class="form-label" style="color: rgba(255,255,255,0.8);">
								<i class="fas fa-upload"></i> Tải ảnh đại diện mới:
							</label>
							<input type="file" class="form-control" id="avatarFile" name="avatarFile" 
								accept="image/*" 
								style="background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2); color: white;">
							<small class="text-muted" style="color: rgba(255,255,255,0.5);">
								Chấp nhận: JPG, PNG, GIF (tối đa 10MB)
							</small>
						</div>
						<div class="mb-2">
							<label for="images" class="form-label" style="color: rgba(255,255,255,0.8);">
								Hoặc nhập URL hình ảnh:
							</label>
							<input type="text" class="form-control" id="images" name="images" 
								value="${user.images != null && user.images.startsWith('http') ? user.images : ''}" 
								placeholder="https://example.com/image.jpg" 
								style="background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2); color: white;">
						</div>
					</div>
				</div>
				
				<div class="info-row">
					<div class="info-label">
						<i class="fas fa-lock"></i> Mật Khẩu Mới:
					</div>
					<div class="info-value">
						<input type="password" class="form-control" name="password" 
							placeholder="Để trống nếu không đổi mật khẩu" style="background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2); color: white;">
						<small class="text-muted" style="color: rgba(255,255,255,0.5);">Để trống nếu không muốn thay đổi mật khẩu</small>
					</div>
				</div>
				
				<div class="text-center mt-4">
					<button type="submit" class="btn-back">
						<i class="fas fa-save"></i> Lưu Thay Đổi
					</button>
				</div>
			</form>
		</div>
		
		<div class="profile-card">
			<h3><i class="fas fa-shield-alt"></i> Quyền Hạn & Trạng Thái</h3>
			<div class="info-row">
				<div class="info-label">
					<i class="fas fa-user-shield"></i> Quyền:
				</div>
				<div class="info-value">
					<c:if test="${user.admin}">
						<span class="badge bg-danger">Admin</span>
					</c:if>
					<c:if test="${!user.admin}">
						<span class="badge bg-secondary">User</span>
					</c:if>
				</div>
			</div>
			<div class="info-row">
				<div class="info-label">
					<i class="fas fa-toggle-on"></i> Trạng Thái:
				</div>
				<div class="info-value">
					<c:if test="${user.active}">
						<span class="badge bg-success">Hoạt động</span>
					</c:if>
					<c:if test="${!user.active}">
						<span class="badge bg-danger">Không hoạt động</span>
					</c:if>
				</div>
			</div>
		</div>
		
		<div class="text-center mt-4">
			<a href="<c:url value='/home' />" class="btn-back">
				<i class="fas fa-arrow-left"></i> Về Trang Chủ
			</a>
			<c:if test="${isAdmin}">
				<a href="<c:url value='/admin/users' />" class="btn-back ms-3">
					<i class="fas fa-cog"></i> Vào Trang Quản Trị
				</a>
			</c:if>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

