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
    /* --- CẤU HÌNH CHUNG ĐỒNG BỘ VỚI TRANG CHỦ --- */
	body {
		background: #080b12; /* Màu nền tối đồng bộ */
		color: #ffffff;
		font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
		min-height: 100vh;
	}
	
	.profile-container {
		max-width: 900px;
		margin: 0 auto;
		padding: 40px 20px;
	}
	
    /* --- HEADER PROFILE (Thay Gradient Tím bằng Cam Đỏ) --- */
	.profile-header {
		background: linear-gradient(105deg, #ea3c12 0%, #991e0e 100%);
		border-radius: 24px;
		padding: 40px;
		margin-bottom: 30px;
		text-align: center;
		box-shadow: 0 20px 60px rgba(234, 60, 18, 0.2); /* Bóng cam */
		position: relative;
		overflow: hidden;
	}
	
    /* Hiệu ứng nền động nhẹ */
	.profile-header::before {
		content: '';
		position: absolute;
		width: 200%;
		height: 200%;
		background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
		background-size: 50px 50px;
		animation: move 30s linear infinite;
		opacity: 0.3;
		top: -50%;
		left: -50%;
	}
	
	@keyframes move {
		0% { transform: rotate(0deg); }
		100% { transform: rotate(360deg); }
	}
	
	.profile-avatar {
		width: 130px;
		height: 130px;
		border-radius: 50%;
		background: rgba(255, 255, 255, 0.15);
		backdrop-filter: blur(5px);
		display: flex;
		align-items: center;
		justify-content: center;
		color: white;
		font-weight: 700;
		font-size: 50px;
		border: 4px solid rgba(255, 255, 255, 0.4);
		margin: 0 auto 20px;
		position: relative;
		z-index: 1;
		box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
	}
    
    .profile-avatar img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 50%;
    }
	
	.profile-name {
		font-size: 2.2rem;
		font-weight: 800;
		margin-bottom: 8px;
		position: relative;
		z-index: 1;
		text-shadow: 0 2px 10px rgba(0,0,0,0.2);
	}
	
	.profile-username {
		font-size: 1.1rem;
		opacity: 0.9;
		position: relative;
		z-index: 1;
		margin-bottom: 15px;
	}
	
	.profile-badge {
		display: inline-block;
		padding: 6px 18px;
		background: rgba(0, 0, 0, 0.2);
		border: 1px solid rgba(255,255,255,0.2);
		border-radius: 50px;
		font-weight: 600;
		font-size: 0.9rem;
		position: relative;
		z-index: 1;
	}
	
    /* --- CARD FORM (Thay nền xanh bằng nền tối #111621) --- */
	.profile-card {
		background: #111621;
		border: 1px solid rgba(255, 255, 255, 0.08);
		border-radius: 20px;
		padding: 35px;
		box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
		margin-bottom: 30px;
	}
	
	.profile-card h3 {
		color: white;
		font-weight: 700;
		margin-bottom: 25px;
		display: flex;
		align-items: center;
		gap: 12px;
		font-size: 1.4rem;
		border-bottom: 1px solid rgba(255, 255, 255, 0.1);
		padding-bottom: 15px;
	}
	
    /* Icon tiêu đề gradient cam */
	.profile-card h3 i {
		background: linear-gradient(to bottom right, #ff9800, #ff5722);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
	}
	
	.info-row {
		display: flex;
		align-items: center;
		padding: 18px 0;
		border-bottom: 1px dashed rgba(255, 255, 255, 0.1);
	}
	
	.info-row:last-child {
		border-bottom: none;
	}
	
	.info-label {
		font-weight: 600;
		color: #ff8a65; /* Màu chữ tiêu đề cam nhạt */
		min-width: 160px;
		display: flex;
		align-items: center;
		gap: 12px;
	}
	
	.info-label i {
		width: 20px;
		text-align: center;
        color: #ff5722;
	}
	
	.info-value {
		color: rgba(255, 255, 255, 0.9);
		flex: 1;
	}
	
    /* --- INPUT STYLING (Làm tối input) --- */
    .form-control {
        background-color: #1a202c !important; /* Nền input tối hơn nền card */
        border: 1px solid #2d3748;
        color: #fff !important;
        padding: 10px 15px;
        border-radius: 10px;
    }
    
    .form-control:focus {
        background-color: #1a202c !important;
        border-color: #ff5722; /* Viền cam khi focus */
        box-shadow: 0 0 0 4px rgba(255, 87, 34, 0.15);
    }
    
    .form-control::placeholder {
        color: #718096;
    }

    /* Input file custom */
	.form-control[type="file"]::-webkit-file-upload-button {
		background: linear-gradient(45deg, #ff5722, #ff8a50);
		color: white;
		border: none;
		padding: 8px 20px;
		border-radius: 6px;
		cursor: pointer;
		margin-right: 15px;
		font-weight: 600;
        transition: all 0.2s;
	}
	
	.form-control[type="file"]::-webkit-file-upload-button:hover {
		filter: brightness(1.1);
	}

    /* --- BUTTONS (Đồng bộ nút cam viên thuốc) --- */
	.btn-action {
		background-color: #ff5722;
        background-image: linear-gradient(45deg, #ff5722, #ff8a50);
		border: none;
		border-radius: 50px;
		padding: 12px 35px;
		font-weight: 600;
		color: white;
		text-decoration: none;
		display: inline-flex;
		align-items: center;
		gap: 10px;
		transition: all 0.3s ease;
		box-shadow: 0 4px 15px rgba(255, 87, 34, 0.3);
	}
    
    /* Nút phụ (Back) */
    .btn-secondary-action {
        background: #2d3748;
        color: white;
        border-radius: 50px;
        padding: 12px 30px;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 10px;
        transition: all 0.3s ease;
        border: 1px solid rgba(255,255,255,0.1);
    }

	.btn-action:hover {
		transform: translateY(-3px);
		box-shadow: 0 8px 20px rgba(255, 87, 34, 0.5);
		color: white;
	}
    
    .btn-secondary-action:hover {
        background: #4a5568;
        color: white;
        transform: translateY(-3px);
    }
    
    /* Badges */
	.badge {
		padding: 8px 16px;
		border-radius: 20px;
		font-weight: 600;
        letter-spacing: 0.5px;
	}
	
	.badge.bg-danger {
		background: linear-gradient(135deg, #ef4444 0%, #c62828 100%) !important;
	}
	
	.badge.bg-success {
		background: linear-gradient(135deg, #00c853 0%, #2e7d32 100%) !important;
	}
    
    /* Alert styling */
    .alert-custom {
        background: rgba(17, 22, 33, 0.9);
        border: 1px solid;
        backdrop-filter: blur(10px);
    }
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
    
	<div class="profile-container">
		<div class="profile-header">
			<div class="profile-avatar">
				<c:choose>
					<c:when test="${user.images != null && !empty user.images}">
                        <c:choose>
                            <c:when test="${user.images.startsWith('http')}">
                                <img src="${user.images}" alt="Avatar">
                            </c:when>
                            <c:otherwise>
                                <img src="<c:url value='/images/${user.images}' />" alt="Avatar">
                            </c:otherwise>
                        </c:choose>
					</c:when>
					<c:otherwise>
                        ${user.fullname != null ? user.fullname.substring(0, 1).toUpperCase() : user.username.substring(0, 1).toUpperCase()}
					</c:otherwise>
				</c:choose>
			</div>
			<h1 class="profile-name">
				${user.fullname != null ? user.fullname : user.username}
			</h1>
			<div class="profile-username">
				<i class="fas fa-at text-warning"></i> ${user.username}
			</div>
			<c:if test="${user.admin}">
				<span class="profile-badge">
					<i class="fas fa-crown text-warning"></i> Quản Trị Viên
				</span>
			</c:if>
		</div>
		
		<c:if test="${message != null}">
			<div class="alert alert-custom alert-dismissible fade show mb-4" role="alert" style="border-color: #00c853; color: #69f0ae;">
				<i class="fas fa-check-circle me-2"></i> ${message}
				<button type="button" class="btn-close" data-bs-dismiss="alert" style="filter: brightness(0) invert(1);"></button>
			</div>
		</c:if>
		
		<c:if test="${error != null}">
			<div class="alert alert-custom alert-dismissible fade show mb-4" role="alert" style="border-color: #ff5252; color: #ff8a80;">
				<i class="fas fa-exclamation-circle me-2"></i> ${error}
				<button type="button" class="btn-close" data-bs-dismiss="alert" style="filter: brightness(0) invert(1);"></button>
			</div>
		</c:if>
		
		<div class="profile-card">
			<h3><i class="fas fa-user-edit"></i> Chỉnh Sửa Thông Tin</h3>
			<form action="<c:url value='/profile/update' />" method="POST" enctype="multipart/form-data">
				<input type="hidden" name="username" value="${user.username}">
				<input type="hidden" name="isEdit" value="true">
				
				<div class="info-row">
					<div class="info-label">
						<i class="fas fa-user"></i> Username
					</div>
					<div class="info-value">
						<input type="text" class="form-control" value="${user.username}" readonly style="opacity: 0.7; cursor: not-allowed;">
					</div>
				</div>
				
				<div class="info-row">
					<div class="info-label">
						<i class="fas fa-id-card"></i> Họ Tên
					</div>
					<div class="info-value">
						<input type="text" class="form-control" name="fullname" value="${user.fullname != null ? user.fullname : ''}" placeholder="Nhập họ tên đầy đủ">
					</div>
				</div>
				
				<div class="info-row">
					<div class="info-label">
						<i class="fas fa-envelope"></i> Email
					</div>
					<div class="info-value">
						<input type="email" class="form-control" name="email" value="${user.email != null ? user.email : ''}" placeholder="example@email.com">
					</div>
				</div>
				
				<div class="info-row">
					<div class="info-label">
						<i class="fas fa-phone"></i> Điện Thoại
					</div>
					<div class="info-value">
						<input type="text" class="form-control" name="phone" value="${user.phone != null ? user.phone : ''}" placeholder="Nhập số điện thoại">
					</div>
				</div>
				
				<div class="info-row">
					<div class="info-label">
						<i class="fas fa-camera"></i> Avatar
					</div>
					<div class="info-value">
						<div class="mb-2">
							<input type="file" class="form-control" id="avatarFile" name="avatarFile" accept="image/*">
							<div class="form-text text-white-50 mt-1">Hỗ trợ: JPG, PNG, GIF (Max 10MB)</div>
						</div>
						<div class="mt-3">
							<label for="images" class="form-label text-white-50" style="font-size: 0.9rem;">Hoặc dùng URL ảnh:</label>
							<input type="text" class="form-control" id="images" name="images" 
								value="${user.images != null && user.images.startsWith('http') ? user.images : ''}" 
								placeholder="https://...">
						</div>
					</div>
				</div>
				
				<div class="info-row">
					<div class="info-label">
						<i class="fas fa-lock"></i> Mật Khẩu
					</div>
					<div class="info-value">
						<input type="password" class="form-control" name="password" placeholder="Nhập mật khẩu mới (nếu muốn đổi)">
					</div>
				</div>
				
				<div class="text-center mt-5">
					<button type="submit" class="btn-action">
						<i class="fas fa-save"></i> Lưu Thay Đổi
					</button>
				</div>
			</form>
		</div>
		
		<div class="profile-card">
			<h3><i class="fas fa-shield-alt"></i> Trạng Thái Tài Khoản</h3>
			<div class="info-row">
				<div class="info-label">
					<i class="fas fa-user-tag"></i> Vai Trò
				</div>
				<div class="info-value">
					<c:if test="${user.admin}">
						<span class="badge bg-danger">ADMINISTRATOR</span>
					</c:if>
					<c:if test="${!user.admin}">
						<span class="badge bg-secondary">MEMBER</span>
					</c:if>
				</div>
			</div>
			<div class="info-row">
				<div class="info-label">
					<i class="fas fa-signal"></i> Tình Trạng
				</div>
				<div class="info-value">
					<c:if test="${user.active}">
						<span class="badge bg-success">ĐANG HOẠT ĐỘNG</span>
					</c:if>
					<c:if test="${!user.active}">
						<span class="badge bg-danger">BỊ KHÓA</span>
					</c:if>
				</div>
			</div>
		</div>
		
		<div class="text-center mt-4 mb-5">
			<a href="<c:url value='/home' />" class="btn-secondary-action me-3">
				<i class="fas fa-arrow-left"></i> Về Trang Chủ
			</a>
			<c:if test="${isAdmin}">
				<a href="<c:url value='/admin/users' />" class="btn-secondary-action">
					<i class="fas fa-cogs"></i> Trang Quản Trị
				</a>
			</c:if>
		</div>
	</div>
    
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>