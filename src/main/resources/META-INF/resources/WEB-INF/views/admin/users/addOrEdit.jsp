<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${user.isEdit ? 'Sửa Người Dùng' : 'Thêm Người Dùng Mới'} - Đặc Sản Việt</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
	body {
		background: linear-gradient(135deg, #0f1419 0%, #1a1f2e 50%, #0f1419 100%);
		color: #ffffff;
		font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
		min-height: 100vh;
		position: relative;
		overflow-x: hidden;
	}
	
	body::before {
		content: '';
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background: 
			radial-gradient(circle at 20% 50%, rgba(255, 107, 53, 0.1) 0%, transparent 50%),
			radial-gradient(circle at 80% 80%, rgba(247, 147, 30, 0.1) 0%, transparent 50%);
		z-index: 0;
		pointer-events: none;
	}
	
	.container-fluid {
		position: relative;
		z-index: 1;
	}
	.card {
		background: rgba(22, 33, 62, 0.9);
		border: 1px solid rgba(255, 107, 53, 0.2);
		border-radius: 20px;
		box-shadow: 0 15px 50px rgba(0, 0, 0, 0.4);
		backdrop-filter: blur(15px);
		transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
		overflow: hidden;
	}
	
	.card:hover {
		transform: translateY(-5px);
		box-shadow: 0 25px 60px rgba(255, 107, 53, 0.15);
		border-color: rgba(255, 107, 53, 0.4);
	}
	
	.card-header {
		background: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%);
		color: white;
		border-radius: 20px 20px 0 0 !important;
		padding: 25px 30px;
		font-weight: 700;
		border: none;
		position: relative;
		overflow: hidden;
	}
	
	.card-header::before {
		content: '';
		position: absolute;
		top: 0;
		left: -100%;
		width: 100%;
		height: 100%;
		background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
		transition: left 0.8s ease;
	}
	
	.card-header:hover::before {
		left: 100%;
	}
	
	.btn-primary { 
		background: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%); 
		border: none; 
		border-radius: 12px;
		padding: 12px 25px;
		font-weight: 600;
		transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
		box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3);
	}
	
	.btn-primary:hover {
		transform: translateY(-3px);
		box-shadow: 0 8px 25px rgba(255, 107, 53, 0.5);
		background: linear-gradient(135deg, #f7931e 0%, #ff6b35 100%);
	}
	.btn-success { background: #10b981; border: none; }
	.btn-danger { background: #ef4444; border: none; }
	.btn-warning { background: #f59e0b; border: none; }
	.btn-info { background: #3b82f6; border: none; }
	.btn-success { background: linear-gradient(135deg, #10b981 0%, #059669 100%); border: none; border-radius: 12px; transition: all 0.4s ease; }
	.btn-info { background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%); border: none; border-radius: 12px; transition: all 0.4s ease; }
	.btn-secondary { background: linear-gradient(135deg, #6b7280 0%, #4b5563 100%); border: none; border-radius: 12px; transition: all 0.4s ease; }
	
	.form-control, .form-select { 
		background: rgba(26, 26, 46, 0.8); 
		border: 2px solid rgba(255, 107, 53, 0.2); 
		color: #ffffff; 
		border-radius: 12px;
		padding: 15px 20px;
		transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
		backdrop-filter: blur(10px);
	}
	
	.form-control:focus, .form-select:focus { 
		background: rgba(26, 26, 46, 0.9); 
		border-color: #ff6b35; 
		color: #ffffff; 
		box-shadow: 0 0 0 0.25rem rgba(255, 107, 53, 0.25);
		transform: translateY(-2px);
	}
	
	.form-label { 
		color: rgba(255, 255, 255, 0.9); 
		font-weight: 600; 
		margin-bottom: 10px;
		font-size: 1.1rem;
	}
	
	.alert-danger { 
		background: rgba(239, 68, 68, 0.15); 
		color: #ef4444; 
		border: 2px solid rgba(239, 68, 68, 0.3); 
		border-radius: 12px;
		backdrop-filter: blur(10px);
	}
	
	.text-danger { color: #ef4444 !important; }
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
	.form-container {
		max-width: 800px;
		margin: 0 auto;
	}
	
	.page-title {
		color: white;
		font-weight: 700;
		font-size: 1.75rem;
		display: flex;
		align-items: center;
		gap: 12px;
		margin-bottom: 30px;
	}
	
	.page-title i {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
		background-clip: text;
	}
	
	.form-actions {
		display: flex;
		gap: 12px;
		justify-content: flex-end;
		padding-top: 20px;
		border-top: 1px solid rgba(255, 255, 255, 0.1);
		margin-top: 30px;
	}
	
	.text-danger {
		color: #ef4444 !important;
	}
</style>
<div class="form-container">
	<h1 class="page-title">
		<i class="fas fa-user"></i> 
		${user.isEdit ? 'Sửa Người Dùng' : 'Thêm Người Dùng Mới'}
	</h1>
	
	<div class="card">
		<div class="card-header">
			<h4 class="mb-0">
				<i class="fas fa-user-edit"></i> 
				${user.isEdit ? 'Chỉnh Sửa Thông Tin Người Dùng' : 'Thông Tin Người Dùng Mới'}
			</h4>
		</div>
		<div class="card-body">
			<!-- Hiển thị thông báo lỗi -->
			<c:if test="${error != null}">
				<div class="alert alert-danger alert-dismissible fade show" role="alert">
					<i class="fas fa-exclamation-circle"></i> ${error}
					<button type="button" class="btn-close" data-bs-dismiss="alert" style="filter: brightness(0) invert(1);"></button>
				</div>
			</c:if>
			
			<form action="<c:url value="/admin/users/saveOrUpdate" />" method="POST" enctype="multipart/form-data">
				<input type="hidden" name="isEdit" value="${user.isEdit}">
				
				<div class="row">
					<div class="col-md-6 mb-3">
						<label for="username" class="form-label">Username: <span class="text-danger">*</span></label>
						<input type="text" class="form-control" value="${user.username}"
							id="username" name="username" placeholder="Nhập username" 
							${user.isEdit ? 'readonly' : 'required'}>
					</div>
					
					<div class="col-md-6 mb-3">
						<label for="password" class="form-label">Password: 
							<c:if test="${!user.isEdit}">
								<span class="text-danger">*</span>
							</c:if>
						</label>
						<input type="password" class="form-control" 
							id="password" name="password" 
							placeholder="${user.isEdit ? 'Để trống nếu không đổi password' : 'Nhập password'}" 
							${user.isEdit ? '' : 'required'}>
						<c:if test="${user.isEdit}">
							<small class="text-muted" style="color: rgba(255,255,255,0.6);">Để trống nếu không muốn thay đổi password</small>
						</c:if>
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-6 mb-3">
						<label for="fullname" class="form-label">Họ Tên: <span class="text-danger">*</span></label>
						<input type="text" class="form-control" value="${user.fullname}"
							id="fullname" name="fullname" placeholder="Nhập họ tên" required>
					</div>
					
					<div class="col-md-6 mb-3">
						<label for="email" class="form-label">Email:</label>
						<input type="email" class="form-control" value="${user.email}"
							id="email" name="email" placeholder="Nhập email">
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-6 mb-3">
						<label for="phone" class="form-label">Điện Thoại:</label>
						<input type="text" class="form-control" value="${user.phone}"
							id="phone" name="phone" placeholder="Nhập số điện thoại">
					</div>
					
					<div class="col-md-6 mb-3">
						<label class="form-label">Hình Ảnh Đại Diện:</label>
						
						<!-- Hiển thị ảnh hiện tại nếu có -->
						<c:if test="${user.images != null && !empty user.images}">
							<div class="mb-2">
								<img src="<c:url value='/images/${user.images}' />" 
									alt="Avatar hiện tại" 
									style="width: 80px; height: 80px; border-radius: 50%; object-fit: cover; border: 2px solid rgba(102, 126, 234, 0.5);">
								<p class="text-muted mt-1" style="color: rgba(255,255,255,0.6); font-size: 0.8rem;">Ảnh hiện tại</p>
							</div>
						</c:if>
						
						<!-- Upload file ảnh -->
						<div class="mb-2">
							<label for="avatarFile" class="form-label" style="font-size: 0.9rem;">Tải ảnh mới:</label>
							<input type="file" class="form-control" id="avatarFile" name="avatarFile" 
								accept="image/*" style="font-size: 0.9rem;">
							<small class="text-muted" style="color: rgba(255,255,255,0.6); font-size: 0.75rem;">
								JPG, PNG, GIF (max 10MB)
							</small>
						</div>
						
						<!-- Hoặc nhập URL -->
						<div class="mb-2">
							<label for="images" class="form-label" style="font-size: 0.9rem;">Hoặc URL:</label>
							<input type="text" class="form-control" value="${user.images != null && user.images.startsWith('http') ? user.images : ''}"
								id="images" name="images" placeholder="https://example.com/image.jpg" style="font-size: 0.9rem;">
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-6 mb-3">
						<label for="admin" class="form-label">Quyền Admin:</label>
						<select class="form-select" id="admin" name="admin">
							<option value="false" ${user.admin == null || !user.admin ? 'selected' : ''}>User</option>
							<option value="true" ${user.admin != null && user.admin ? 'selected' : ''}>Admin</option>
						</select>
					</div>
					
					<div class="col-md-6 mb-3">
						<label for="active" class="form-label">Trạng Thái:</label>
						<select class="form-select" id="active" name="active">
							<option value="true" ${user.active == null || user.active ? 'selected' : ''}>Hoạt động</option>
							<option value="false" ${user.active != null && !user.active ? 'selected' : ''}>Không hoạt động</option>
						</select>
					</div>
				</div>
				
				<div class="form-actions">
					<a href="<c:url value="/admin/users/add"/>" class="btn btn-secondary">
						<i class="fas fa-plus"></i> Mới
					</a>
					<a href="<c:url value="/admin/users" />" class="btn btn-info">
						<i class="fas fa-list"></i> Danh Sách
					</a>
					<button class="btn btn-primary" type="submit">
						<i class="fas fa-save"></i>
						${user.isEdit ? 'Cập Nhật' : 'Lưu'}
					</button>
				</div>
			</form>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
