<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Danh Sách Người Dùng - Đặc Sản Việt</title>
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
		transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
		box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3);
	}
	
	.btn-primary:hover {
		transform: translateY(-3px);
		box-shadow: 0 8px 25px rgba(255, 107, 53, 0.5);
	}
	.btn-success { background: #10b981; border: none; }
	.btn-danger { background: #ef4444; border: none; }
	.btn-warning { background: #f59e0b; border: none; }
	.btn-info { background: #3b82f6; border: none; }
	.table { background: #16213e; color: #ffffff; }
	.table thead { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
	.table tbody tr { border-color: rgba(255, 255, 255, 0.1); }
	.table tbody tr:hover { background-color: rgba(102, 126, 234, 0.1); }
	.table td, .table th { border-color: rgba(255, 255, 255, 0.1); }
	.badge.bg-success { background: #10b981 !important; }
	.badge.bg-danger { background: #ef4444 !important; }
	.badge.bg-info { background: #3b82f6 !important; }
	.alert-success { background: rgba(16, 185, 129, 0.2); color: #10b981; border: 1px solid rgba(16, 185, 129, 0.3); }
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
	.page-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 30px;
	}
	
	.page-title {
		color: white;
		font-weight: 700;
		font-size: 2rem;
		display: flex;
		align-items: center;
		gap: 12px;
		margin: 0;
	}
	
	.page-title i {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
		background-clip: text;
	}
	
	.action-buttons {
		display: flex;
		gap: 12px;
	}
	
	.btn-sm {
		padding: 6px 16px;
		font-size: 0.875rem;
		border-radius: 8px;
		font-weight: 600;
		transition: all 0.3s ease;
	}
	
	.btn-sm:hover {
		transform: translateY(-2px);
	}
	
	.img-thumbnail {
		border-radius: 8px;
		border: 2px solid rgba(102, 126, 234, 0.3);
	}
	
	.badge.bg-info {
		background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%) !important;
	}
</style>
<div class="row">
	<div class="col-12">
		<div class="page-header">
			<h1 class="page-title">
				<i class="fas fa-users"></i> Danh Sách Người Dùng
			</h1>
			<div class="action-buttons">
				<a href="<c:url value='/admin/users/add' />" class="btn btn-success">
					<i class="fas fa-plus"></i> Thêm Người Dùng Mới
				</a>
				<a href="<c:url value='/home' />" class="btn btn-info">
					<i class="fas fa-home"></i> Về Trang Chủ
				</a>
			</div>
		</div>
		
		<div class="card">
			<div class="card-header">
				<h4 class="mb-0"><i class="fas fa-list"></i> Quản Lý Người Dùng</h4>
			</div>
			<div class="card-body">
				<!-- Hiển thị thông báo -->
				<c:if test="${message != null}">
					<div class="alert alert-success alert-dismissible fade show" role="alert">
						<i class="fas fa-check-circle"></i> ${message}
						<button type="button" class="btn-close" data-bs-dismiss="alert" style="filter: brightness(0) invert(1);"></button>
					</div>
				</c:if>
				
				<div class="table-responsive">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>Username</th>
								<th>Họ Tên</th>
								<th>Email</th>
								<th>Điện Thoại</th>
								<th>Hình Ảnh</th>
								<th>Admin</th>
								<th>Trạng Thái</th>
								<th>Số Danh Mục</th>
								<th>Thao Tác</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${users}" var="user">
								<tr>
									<td><strong style="color: rgba(102, 126, 234, 1);">${user.username}</strong></td>
									<td>${user.fullname != null ? user.fullname : '-'}</td>
									<td>${user.email != null ? user.email : '-'}</td>
									<td>${user.phone != null ? user.phone : '-'}</td>
									<td>
										<c:if test="${not empty user.images}">
											<c:choose>
												<c:when test="${user.images.startsWith('http')}">
													<img src="${user.images}" width="50px" height="50px" class="img-thumbnail" style="object-fit: cover;" />
												</c:when>
												<c:otherwise>
													<img src="<c:url value='/images/${user.images}' />" width="50px" height="50px" class="img-thumbnail" style="object-fit: cover;" />
												</c:otherwise>
											</c:choose>
										</c:if>
										<c:if test="${empty user.images}">
											<div style="width: 50px; height: 50px; border-radius: 8px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); display: flex; align-items: center; justify-content: center; color: white; font-weight: 700;">
												${user.username.substring(0, 1).toUpperCase()}
											</div>
										</c:if>
									</td>
									<td>
										<c:if test="${user.admin}">
											<span class="badge bg-danger">Admin</span>
										</c:if>
										<c:if test="${!user.admin}">
											<span class="badge bg-secondary">User</span>
										</c:if>
									</td>
									<td>
										<c:if test="${user.active}">
											<span class="badge bg-success">Hoạt động</span>
										</c:if>
										<c:if test="${!user.active}">
											<span class="badge bg-danger">Không hoạt động</span>
										</c:if>
									</td>
									<td>
										<span class="badge bg-info">${user.categories != null ? user.categories.size() : 0}</span>
									</td>
									<td>
										<div class="d-flex gap-2">
											<a href="<c:url value='/admin/users/edit/${user.username}' />" 
											   class="btn btn-sm btn-warning">
												<i class="fas fa-edit"></i> Sửa
											</a>
											<a href="<c:url value='/admin/users/delete/${user.username}' />" 
											   class="btn btn-sm btn-danger"
											   onclick="return confirm('Bạn có chắc chắn muốn xóa người dùng ${user.username}?')">
												<i class="fas fa-trash"></i> Xóa
											</a>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>