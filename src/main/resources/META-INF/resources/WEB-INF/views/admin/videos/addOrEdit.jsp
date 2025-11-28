<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${video.isEdit ? 'Sửa Video' : 'Thêm Video Mới'} - Đặc Sản Việt</title>
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
	
	.form-container {
		max-width: 1000px;
		margin: 0 auto;
		padding: 40px 20px;
	}
	
	.page-title {
		color: white;
		font-weight: 800;
		font-size: 2.2rem;
		display: flex;
		align-items: center;
		gap: 15px;
		margin-bottom: 35px;
		text-shadow: 2px 4px 8px rgba(0,0,0,0.3);
	}
	
	.page-title i {
		background: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
		background-clip: text;
		font-size: 2.5rem;
		animation: pulse 2s infinite;
	}
	
	@keyframes pulse {
		0%, 100% { transform: scale(1); }
		50% { transform: scale(1.1); }
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
	
	.btn-success { 
		background: linear-gradient(135deg, #10b981 0%, #059669 100%); 
		border: none; 
		border-radius: 12px;
		transition: all 0.4s ease;
	}
	
	.btn-info { 
		background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%); 
		border: none; 
		border-radius: 12px;
		transition: all 0.4s ease;
	}
	
	.btn-secondary { 
		background: linear-gradient(135deg, #6b7280 0%, #4b5563 100%); 
		border: none; 
		border-radius: 12px;
		transition: all 0.4s ease;
	}
	
	.form-control, .form-select, .form-control[type="file"] { 
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
	
	.form-actions {
		display: flex;
		gap: 15px;
		justify-content: flex-end;
		padding-top: 25px;
		border-top: 2px solid rgba(255, 107, 53, 0.1);
		margin-top: 35px;
	}
	
	textarea.form-control {
		min-height: 120px;
		resize: vertical;
	}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp" />

<div class="container-fluid px-4 py-4">
	<div class="form-container">
		<h1 class="page-title">
			<i class="fas fa-video"></i> 
			${video.isEdit ? 'Sửa Video Món Ăn' : 'Thêm Video Món Ăn Mới'}
		</h1>
		
		<div class="card">
			<div class="card-header">
				<h4 class="mb-0">
					<i class="fas fa-edit"></i> 
					${video.isEdit ? 'Chỉnh Sửa Thông Tin Video' : 'Thông Tin Video Mới'}
				</h4>
			</div>
			<div class="card-body p-4">
				<!-- Hiển thị thông báo lỗi -->
				<c:if test="${error != null}">
					<div class="alert alert-danger alert-dismissible fade show" role="alert">
						<i class="fas fa-exclamation-circle"></i> ${error}
						<button type="button" class="btn-close" data-bs-dismiss="alert" style="filter: brightness(0) invert(1);"></button>
					</div>
				</c:if>
				
				<form action="<c:url value="/admin/videos/saveOrUpdate" />" method="POST" enctype="multipart/form-data">
					<input type="hidden" name="isEdit" value="${video.isEdit}">
					<c:if test="${video.isEdit}">
						<input type="hidden" name="videold" value="${video.videold}">
					</c:if>
					
					<div class="row">
						<div class="col-md-8 mb-4">
							<label for="title" class="form-label">Tiêu Đề Video: <span class="text-danger">*</span></label>
							<input type="text" class="form-control" value="${video.title}"
								id="title" name="title" placeholder="VD: Cách làm Phở Bò truyền thống..." required>
						</div>
						
						<div class="col-md-4 mb-4">
							<label for="views" class="form-label">Lượt Xem:</label>
							<input type="number" class="form-control" value="${video.views != null ? video.views : 0}"
								id="views" name="views" min="0" placeholder="0">
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-12 mb-4">
							<label for="description" class="form-label">Mô Tả Video:</label>
							<textarea class="form-control" id="description" name="description" 
								placeholder="Mô tả chi tiết về video, nguyên liệu, cách làm...">${video.description}</textarea>
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-12 mb-4">
							<label class="form-label">Poster/Thumbnail Video:</label>
							
							<!-- Hiển thị poster hiện tại nếu có -->
							<c:if test="${video.poster != null && !empty video.poster}">
								<div class="mb-3">
									<c:choose>
										<c:when test="${video.poster.startsWith('http')}">
											<img src="${video.poster}" 
												alt="Poster hiện tại" 
												style="width: 200px; height: 120px; border-radius: 15px; object-fit: cover; border: 3px solid rgba(255, 107, 53, 0.5);">
										</c:when>
										<c:otherwise>
											<img src="<c:url value='/images/${video.poster}' />" 
												alt="Poster hiện tại" 
												style="width: 200px; height: 120px; border-radius: 15px; object-fit: cover; border: 3px solid rgba(255, 107, 53, 0.5);">
										</c:otherwise>
									</c:choose>
									<p class="text-muted mt-2" style="color: rgba(255,255,255,0.6);">Poster hiện tại</p>
								</div>
							</c:if>
							
							<!-- Upload file poster -->
							<div class="mb-3">
								<label for="posterFile" class="form-label">Tải poster mới:</label>
								<input type="file" class="form-control" id="posterFile" name="posterFile" 
									accept="image/*">
								<small class="text-muted" style="color: rgba(255,255,255,0.6);">
									Chấp nhận: JPG, PNG, GIF (tối đa 10MB)
								</small>
							</div>
							
							<!-- Hoặc nhập URL -->
							<div class="mb-3">
								<label for="poster" class="form-label">Hoặc nhập URL poster:</label>
								<input type="text" class="form-control" value="${video.poster != null && video.poster.startsWith('http') ? video.poster : ''}"
									id="poster" name="poster" placeholder="https://example.com/poster.jpg">
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-6 mb-4">
							<label for="categoryId" class="form-label">Danh Mục: <span class="text-danger">*</span></label>
							<select class="form-select" id="categoryId" name="categoryId" required>
								<option value="">-- Chọn danh mục --</option>
								<c:forEach items="${categories}" var="category">
									<option value="${category.categoryId}" ${video.categoryId == category.categoryId ? 'selected' : ''}>
										${category.categoryname}
									</option>
								</c:forEach>
							</select>
						</div>
						
						<div class="col-md-6 mb-4">
							<label for="active" class="form-label">Trạng Thái:</label>
							<select class="form-select" id="active" name="active">
								<option value="true" ${video.active == null || video.active ? 'selected' : ''}>Hoạt động</option>
								<option value="false" ${video.active != null && !video.active ? 'selected' : ''}>Không hoạt động</option>
							</select>
						</div>
					</div>
					
					<div class="form-actions">
						<a href="<c:url value="/admin/videos/add"/>" class="btn btn-secondary">
							<i class="fas fa-plus"></i> Mới
						</a>
						<a href="<c:url value="/admin/videos" />" class="btn btn-info">
							<i class="fas fa-list"></i> Danh Sách
						</a>
						<button class="btn btn-primary" type="submit">
							<i class="fas fa-save"></i>
							${video.isEdit ? 'Cập Nhật' : 'Lưu'}
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>