<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Danh Sách Danh Mục - Quản Lý Sinh Viên</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
	body {
		background: #0f0f23;
		color: #ffffff;
		font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
		min-height: 100vh;
	}
	.card {
		background: #16213e;
		border: 1px solid rgba(255, 255, 255, 0.1);
		border-radius: 16px;
		box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
	}
	.card-header {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		color: white;
		border-radius: 16px 16px 0 0 !important;
		padding: 20px 24px;
		font-weight: 600;
		border: none;
	}
	.btn-primary { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border: none; }
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
</style>
<div class="row">
	<div class="col-12">
		<div class="page-header">
			<h1 class="page-title">
				<i class="fas fa-folder"></i> Danh Sách Danh Mục
			</h1>
			<div class="action-buttons">
				<a href="<c:url value='/admin/categories/add' />" class="btn btn-success">
					<i class="fas fa-plus"></i> Thêm Danh Mục Mới
				</a>
				<a href="<c:url value='/home' />" class="btn btn-info">
					<i class="fas fa-home"></i> Về Trang Chủ
				</a>
			</div>
		</div>
		
		<div class="card">
			<div class="card-header">
				<h4 class="mb-0"><i class="fas fa-list"></i> Quản Lý Danh Mục</h4>
			</div>
			<div class="card-body">
				<!-- Hiển thị thông báo -->
				<c:if test="${message != null}">
					<div class="alert alert-success alert-dismissible fade show" role="alert">
						<i class="fas fa-check-circle"></i> ${message}
						<button type="button" class="btn-close" data-bs-dismiss="alert" style="filter: brightness(0) invert(1);"></button>
					</div>
				</c:if>
				
				<c:if test="${error != null}">
					<div class="alert alert-danger alert-dismissible fade show" role="alert">
						<i class="fas fa-exclamation-circle"></i> ${error}
						<button type="button" class="btn-close" data-bs-dismiss="alert" style="filter: brightness(0) invert(1);"></button>
					</div>
				</c:if>
				
				<div class="table-responsive">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>ID</th>
								<th>Tên Danh Mục</th>
								<th>Mã Danh Mục</th>
								<th>Hình Ảnh</th>
								<th>Trạng Thái</th>
								<th>Người Dùng</th>
								<th>Số Video</th>
								<th>Thao Tác</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${categories}" var="category">
								<tr>
									<td><strong style="color: rgba(102, 126, 234, 1);">${category.categoryId}</strong></td>
									<td><strong>${category.categoryname}</strong></td>
									<td>${category.categorycode}</td>
									<td>
										<c:if test="${not empty category.images}">
											<c:choose>
												<c:when test="${category.images.startsWith('http')}">
													<img src="${category.images}" width="50px" height="50px" class="img-thumbnail" style="object-fit: cover; border-radius: 8px; border: 2px solid rgba(102, 126, 234, 0.3);" />
												</c:when>
												<c:otherwise>
													<img src="<c:url value='/images/${category.images}' />" width="50px" height="50px" class="img-thumbnail" style="object-fit: cover; border-radius: 8px; border: 2px solid rgba(102, 126, 234, 0.3);" />
												</c:otherwise>
											</c:choose>
										</c:if>
										<c:if test="${empty category.images}">
											<div style="width: 50px; height: 50px; border-radius: 8px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); display: flex; align-items: center; justify-content: center; color: white; font-weight: 700;">
												<i class="fas fa-folder"></i>
											</div>
										</c:if>
									</td>
									<td>
										<c:if test="${category.status}">
											<span class="badge bg-success">Hoạt động</span>
										</c:if>
										<c:if test="${!category.status}">
											<span class="badge bg-danger">Không hoạt động</span>
										</c:if>
									</td>
									<td>${category.user != null ? category.user.fullname : 'N/A'}</td>
									<td>
										<span class="badge bg-info">${category.videos != null ? category.videos.size() : 0}</span>
									</td>
									<td>
										<div class="d-flex gap-2">
											<a href="<c:url value='/admin/categories/edit/${category.categoryId}' />" 
											   class="btn btn-sm btn-warning">
												<i class="fas fa-edit"></i> Sửa
											</a>
											<a href="<c:url value='/admin/categories/delete/${category.categoryId}' />" 
											   class="btn btn-sm btn-danger"
											   onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục ${category.categoryname}?')">
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
