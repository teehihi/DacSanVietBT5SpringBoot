<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<style>
	.navbar-custom {
		background: rgba(20, 25, 40, 0.95) !important;
		backdrop-filter: blur(20px);
		box-shadow: 0 4px 30px rgba(0, 0, 0, 0.5);
		padding: 18px 0;
		border-bottom: 1px solid rgba(255, 107, 53, 0.2);
		position: sticky;
		top: 0;
		z-index: 1000;
		transition: all 0.3s ease;
	}
	
	.navbar-custom:hover {
		box-shadow: 0 6px 40px rgba(255, 107, 53, 0.15);
	}
	
	.navbar-brand-custom {
		font-size: 24px;
		font-weight: 700;
		color: white !important;
		display: flex;
		align-items: center;
		gap: 15px;
		text-decoration: none;
		transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
		background: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
		background-clip: text;
	}
	
	.navbar-brand-custom:hover {
		transform: scale(1.05) translateY(-2px);
		background: linear-gradient(135deg, #f7931e 0%, #ff6b35 100%);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
		background-clip: text;
		filter: drop-shadow(0 4px 8px rgba(255, 107, 53, 0.3));
	}
	
	.brand-logo {
		width: 45px;
		height: 45px;
		border-radius: 12px;
		transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
		box-shadow: 0 4px 15px rgba(255, 107, 53, 0.3);
	}
	
	.brand-logo:hover {
		transform: rotate(5deg) scale(1.1);
		box-shadow: 0 8px 25px rgba(255, 107, 53, 0.5);
	}
	
	.nav-link-custom {
		color: rgba(255, 255, 255, 0.8) !important;
		font-weight: 500;
		padding: 12px 20px !important;
		border-radius: 12px;
		transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
		margin: 0 6px;
		position: relative;
		overflow: hidden;
	}
	
	.nav-link-custom::before {
		content: '';
		position: absolute;
		bottom: 0;
		left: 50%;
		transform: translateX(-50%);
		width: 0;
		height: 3px;
		background: linear-gradient(135deg, #ff6b35 0%, #f7931e 100%);
		transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
		border-radius: 2px;
	}
	
	.nav-link-custom::after {
		content: '';
		position: absolute;
		top: 0;
		left: -100%;
		width: 100%;
		height: 100%;
		background: linear-gradient(90deg, transparent, rgba(255, 107, 53, 0.1), transparent);
		transition: left 0.6s ease;
	}
	
	.nav-link-custom:hover {
		background: rgba(255, 107, 53, 0.15);
		color: white !important;
		transform: translateY(-3px);
		box-shadow: 0 8px 25px rgba(255, 107, 53, 0.2);
	}
	
	.nav-link-custom:hover::before {
		width: 90%;
	}
	
	.nav-link-custom:hover::after {
		left: 100%;
	}
	
	.navbar-text-custom {
		color: rgba(255, 255, 255, 0.9);
		display: flex;
		align-items: center;
		gap: 10px;
		margin-right: 20px;
		font-size: 14px;
		font-weight: 500;
	}
	
	.btn-logout-custom {
		background: rgba(239, 68, 68, 0.2);
		border: 1px solid rgba(239, 68, 68, 0.4);
		color: #ef4444;
		border-radius: 10px;
		padding: 10px 20px;
		font-weight: 600;
		transition: all 0.3s ease;
		text-decoration: none;
	}
	
	.btn-logout-custom:hover {
		background: #ef4444;
		color: white;
		transform: translateY(-2px);
		box-shadow: 0 4px 15px rgba(239, 68, 68, 0.4);
	}
	
	.badge-admin {
		background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
		padding: 4px 12px;
		border-radius: 12px;
		font-size: 11px;
		font-weight: 700;
		text-transform: uppercase;
		letter-spacing: 0.5px;
		box-shadow: 0 2px 8px rgba(239, 68, 68, 0.3);
	}
	
	.user-avatar {
		width: 40px;
		height: 40px;
		border-radius: 50%;
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		display: flex;
		align-items: center;
		justify-content: center;
		color: white;
		font-weight: 700;
		font-size: 16px;
		border: 2px solid rgba(102, 126, 234, 0.3);
		transition: all 0.3s ease;
		overflow: hidden;
		position: relative;
	}
	
	.user-avatar img {
		width: 100%;
		height: 100%;
		object-fit: cover;
		border-radius: 50%;
		border: none !important;
	}
	
	.user-avatar:hover {
		transform: scale(1.1);
		box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
	}
	
	.btn-outline-light-custom {
		border: 1px solid rgba(255, 255, 255, 0.3);
		color: rgba(255, 255, 255, 0.9);
		border-radius: 10px;
		padding: 10px 20px;
		font-weight: 600;
		transition: all 0.3s ease;
		background: rgba(255, 255, 255, 0.05);
	}
	
	.btn-outline-light-custom:hover {
		background: rgba(255, 255, 255, 0.15);
		border-color: rgba(255, 255, 255, 0.5);
		color: white;
		transform: translateY(-2px);
	}
	
	.btn-light-custom {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		border: none;
		color: white;
		border-radius: 10px;
		padding: 10px 20px;
		font-weight: 600;
		transition: all 0.3s ease;
	}
	
	.btn-light-custom:hover {
		transform: translateY(-2px);
		box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
		color: white;
	}
</style>
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
	<div class="container-fluid px-4">
		<a class="navbar-brand navbar-brand-custom" href="<c:url value='/home' />">
			<img src="https://files.catbox.moe/c373f9.webp" alt="Logo" class="brand-logo">
			<span>Đặc Sản Việt</span>
		</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" 
			style="border-color: rgba(255,255,255,0.3);">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<c:if test="${sessionScope.user != null}">
				<ul class="navbar-nav me-auto">
					<li class="nav-item">
						<a class="nav-link nav-link-custom" href="<c:url value='/home' />">
							<i class="fas fa-home"></i> Trang Chủ
						</a>
					</li>
					<c:if test="${sessionScope.user.admin}">
						<li class="nav-item">
							<a class="nav-link nav-link-custom" href="<c:url value='/admin/users' />">
								<i class="fas fa-users"></i> Người Dùng
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link nav-link-custom" href="<c:url value='/admin/categories' />">
								<i class="fas fa-utensils"></i> Danh Mục Món
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link nav-link-custom" href="<c:url value='/admin/videos' />">
								<i class="fas fa-video"></i> Video Món Ăn
							</a>
						</li>
					</c:if>
				</ul>
				<div class="d-flex align-items-center gap-3">
					<a href="<c:url value='/profile' />" class="d-flex align-items-center gap-2 text-decoration-none" style="cursor: pointer;">
						<div class="user-avatar" style="cursor: pointer;">
							<c:choose>
								<c:when test="${sessionScope.user.images != null && !empty sessionScope.user.images}">
									<c:choose>
										<c:when test="${sessionScope.user.images.startsWith('http')}">
											<img src="${sessionScope.user.images}" 
												alt="Avatar" 
												style="width: 40px; height: 40px; border-radius: 50%; object-fit: cover; border: 2px solid rgba(102, 126, 234, 0.3);">
										</c:when>
										<c:otherwise>
											<img src="<c:url value='/images/${sessionScope.user.images}' />" 
												alt="Avatar" 
												style="width: 40px; height: 40px; border-radius: 50%; object-fit: cover; border: 2px solid rgba(102, 126, 234, 0.3);">
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${sessionScope.user.fullname != null && !empty sessionScope.user.fullname}">
											${sessionScope.user.fullname.substring(0, 1).toUpperCase()}
										</c:when>
										<c:otherwise>
											${sessionScope.user.username.substring(0, 1).toUpperCase()}
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="navbar-text-custom d-none d-md-block">
							<strong>${sessionScope.user.fullname != null ? sessionScope.user.fullname : sessionScope.user.username}</strong>
							<c:if test="${sessionScope.user.admin}">
								<span class="badge-admin ms-2">ADMIN</span>
							</c:if>
						</div>
					</a>
					<a href="<c:url value='/logout' />" class="btn btn-logout-custom">
						<i class="fas fa-sign-out-alt"></i> Đăng Xuất
					</a>
				</div>
			</c:if>
			<c:if test="${sessionScope.user == null}">
				<div class="ms-auto d-flex gap-2">
					<a href="<c:url value='/login' />" class="btn btn-outline-light-custom">
						<i class="fas fa-sign-in-alt"></i> Đăng Nhập
					</a>
					<a href="<c:url value='/register' />" class="btn btn-light-custom">
						<i class="fas fa-user-plus"></i> Đăng Ký
					</a>
				</div>
			</c:if>
		</div>
	</div>
</nav>
