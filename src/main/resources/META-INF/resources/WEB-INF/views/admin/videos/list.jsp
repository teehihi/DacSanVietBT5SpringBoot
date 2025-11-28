<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Danh Sách Video - Đặc Sản Việt</title>
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
	.table { 
		background: transparent; 
		color: #ffffff; 
		border-radius: 15px;
		overflow: hidden;
	}
	.table thead { 
		background: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%); 
		color: white;
	}
	.table tbody tr { 
		border-color: rgba(255, 107, 53, 0.2); 
		background: rgba(22, 33, 62, 0.6);
		transition: all 0.3s ease;
	}
	.table tbody tr:hover { 
		background: rgba(255, 107, 53, 0.15);
		transform: translateX(5px);
	}
	.table td, .table th { 
		border-color: rgba(255, 107, 53, 0.2); 
		padding: 15px;
		vertical-align: middle;
	}
	.badge.bg-success { background: #10b981 !important; }
	.badge.bg-danger { background: #ef4444 !important; }
	.badge.bg-info { background: #3b82f6 !important; }
	.alert-success { background: rgba(16, 185, 129, 0.2); color: #10b981; border: 1px solid rgba(16, 185, 129, 0.3); }
	.form-control { background: #1a1a2e; border: 1px solid rgba(255, 255, 255, 0.1); color: #ffffff; }
	.form-control:focus { background: #1a1a2e; border-color: #667eea; color: #ffffff; }
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
		flex-wrap: wrap;
		gap: 20px;
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
	
	.search-section {
		display: flex;
		gap: 12px;
		align-items: center;
		flex-wrap: wrap;
	}
	
	.pagination .page-link {
		background: var(--bg-card);
		border-color: rgba(102, 126, 234, 0.3);
		color: rgba(102, 126, 234, 1);
	}
	
	.pagination .page-item.active .page-link {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		border-color: rgba(102, 126, 234, 0.5);
		color: white;
	}
	
	.pagination .page-link:hover {
		background: rgba(102, 126, 234, 0.2);
		border-color: rgba(102, 126, 234, 0.5);
		color: white;
	}
</style>
<div class="row">
	<div class="col-12">
		<div class="page-header">
			<h1 class="page-title">
				<i class="fas fa-video"></i> Danh Sách Video
			</h1>
			<div class="d-flex gap-2 flex-wrap">
				<a href="<c:url value='/admin/videos/add' />" class="btn btn-success">
					<i class="fas fa-plus"></i> Thêm Video Mới
				</a>
				<a href="<c:url value='/home' />" class="btn btn-info">
					<i class="fas fa-home"></i> Về Trang Chủ
				</a>
			</div>
		</div>
		
		<div class="card">
			<div class="card-header">
				<h4 class="mb-0"><i class="fas fa-list"></i> Quản Lý Video</h4>
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
				
				<div class="search-section mb-4">
					<form action="<c:url value='/admin/videos' />" method="GET" class="d-flex gap-2 flex-grow-1">
						<input type="text" class="form-control" name="search" 
							value="${search}" placeholder="Tìm kiếm theo tiêu đề...">
						<button type="submit" class="btn btn-primary">
							<i class="fas fa-search"></i> Tìm Kiếm
						</button>
						<c:if test="${not empty search}">
							<a href="<c:url value='/admin/videos' />" class="btn btn-secondary">
								<i class="fas fa-times"></i> Xóa
							</a>
						</c:if>
					</form>
				</div>
				
				<div class="table-responsive">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>ID</th>
								<th>Tiêu Đề</th>
								<th>Poster</th>
								<th>Lượt Xem</th>
								<th>Mô Tả</th>
								<th>Danh Mục</th>
								<th>Trạng Thái</th>
								<th>Thao Tác</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${videos}" var="video">
								<tr>
									<td><strong style="color: rgba(102, 126, 234, 1);">${video.videold}</strong></td>
									<td><strong>${video.title}</strong></td>
									<td>
										<c:if test="${not empty video.poster}">
											<c:choose>
												<c:when test="${video.poster.startsWith('http')}">
													<img src="${video.poster}" width="80px" height="60px" class="img-thumbnail" style="object-fit: cover; border-radius: 8px; border: 2px solid rgba(102, 126, 234, 0.3);" />
												</c:when>
												<c:otherwise>
													<img src="<c:url value='/images/${video.poster}' />" width="80px" height="60px" class="img-thumbnail" style="object-fit: cover; border-radius: 8px; border: 2px solid rgba(102, 126, 234, 0.3);" />
												</c:otherwise>
											</c:choose>
										</c:if>
										<c:if test="${empty video.poster}">
											<div style="width: 80px; height: 60px; border-radius: 8px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); display: flex; align-items: center; justify-content: center; color: white; font-size: 24px;">
												<i class="fas fa-video"></i>
											</div>
										</c:if>
									</td>
									<td>
										<span class="badge bg-info">
											<i class="fas fa-eye"></i> ${video.views}
										</span>
									</td>
									<td>
										<c:if test="${not empty video.description}">
											${video.description.length() > 50 ? 
												video.description.substring(0, 50) + '...' : 
												video.description}
										</c:if>
										<c:if test="${empty video.description}">
											<span style="color: rgba(255,255,255,0.5);">-</span>
										</c:if>
									</td>
									<td>${video.category != null ? video.category.categoryname : 'N/A'}</td>
									<td>
										<c:if test="${video.active}">
											<span class="badge bg-success">Hoạt động</span>
										</c:if>
										<c:if test="${!video.active}">
											<span class="badge bg-danger">Không hoạt động</span>
										</c:if>
									</td>
									<td>
										<div class="d-flex gap-2">
											<a href="<c:url value='/admin/videos/edit/${video.videold}' />" 
											   class="btn btn-sm btn-warning">
												<i class="fas fa-edit"></i> Sửa
											</a>
											<a href="<c:url value='/admin/videos/delete/${video.videold}' />" 
											   class="btn btn-sm btn-danger"
											   onclick="return confirm('Bạn có chắc chắn muốn xóa video ${video.title}?')">
												<i class="fas fa-trash"></i> Xóa
											</a>
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
				<c:if test="${totalPages != null && totalPages > 1}">
					<nav aria-label="Page navigation" class="mt-4">
						<ul class="pagination justify-content-center">
							<li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
								<a class="page-link" href="<c:url value='/admin/videos?page=${currentPage - 1}&search=${search}' />">Previous</a>
							</li>
							<c:forEach var="i" begin="0" end="${totalPages - 1}">
								<li class="page-item ${currentPage == i ? 'active' : ''}">
									<a class="page-link" href="<c:url value='/admin/videos?page=${i}&search=${search}' />">${i + 1}</a>
								</li>
							</c:forEach>
							<li class="page-item ${currentPage >= totalPages - 1 ? 'disabled' : ''}">
								<a class="page-link" href="<c:url value='/admin/videos?page=${currentPage + 1}&search=${search}' />">Next</a>
							</li>
						</ul>
					</nav>
				</c:if>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
