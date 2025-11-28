<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="uri" value="${pageContext.request.requestURI}" />

<style>
	/* --- NAVBAR STYLES --- */
	.navbar-custom {
		background: rgba(11, 15, 25, 0.95) !important; /* Nền tối đậm */
		backdrop-filter: blur(20px);
		box-shadow: 0 4px 30px rgba(0, 0, 0, 0.5);
		padding: 15px 0;
		border-bottom: 1px solid rgba(255, 255, 255, 0.05);
		position: sticky;
		top: 0;
		z-index: 1000;
	}

	/* Logo */
	.brand-logo {
		width: 45px;
		height: 45px;
		border-radius: 12px;
		/* Hiệu ứng bóng cam nhẹ cho logo */
		box-shadow: 0 0 15px rgba(255, 87, 34, 0.2); 
		transition: transform 0.3s ease;
		object-fit: cover;
	}

	.navbar-brand:hover .brand-logo {
		transform: scale(1.1) rotate(5deg);
	}

	/* --- THÔNG TIN SINH VIÊN (Đã giữ lại và làm đẹp hơn) --- */
	.student-info-badge {
		display: flex;
		align-items: center;
		padding: 8px 16px;
		margin-left: 15px;
		background: rgba(255, 255, 255, 0.05); /* Nền kính mờ */
		border: 1px solid rgba(255, 255, 255, 0.1);
		border-radius: 50px;
		color: #a0aec0;
		font-size: 0.85rem;
		font-weight: 500;
		transition: all 0.3s ease;
	}

	.student-info-badge:hover {
		background: rgba(255, 87, 34, 0.1);
		border-color: rgba(255, 87, 34, 0.3);
		color: #ffccbc;
	}
	
	.student-info-badge i {
		margin-right: 8px;
		color: #ff5722;
	}

	/* --- MENU LINKS & ACTIVE STATE --- */
	.nav-link-custom {
		color: #a0aec0 !important;
		font-weight: 600;
		font-size: 0.95rem;
		padding: 10px 20px !important;
		border-radius: 30px;
		margin: 0 5px;
		transition: all 0.3s ease;
		display: flex;
		align-items: center;
		gap: 8px;
		border: 1px solid transparent;
	}

	.nav-link-custom:hover {
		color: #fff !important;
		background: rgba(255, 255, 255, 0.05);
	}

	/* Khi đang ở trang đó (Active) */
	.nav-link-custom.active {
		background: linear-gradient(90deg, rgba(255, 87, 34, 0.15), rgba(255, 87, 34, 0.05));
		color: #ff7043 !important; /* Màu cam sáng */
		border-color: rgba(255, 87, 34, 0.3);
		box-shadow: 0 0 15px rgba(255, 87, 34, 0.1);
	}
	
	.nav-link-custom.active i {
		color: #ff5722;
	}

	/* --- USER PROFILE AREA --- */
	.user-avatar-small {
		width: 36px;
		height: 36px;
		border-radius: 50%;
		object-fit: cover;
		border: 2px solid rgba(255, 87, 34, 0.5);
	}

	.btn-logout-icon {
		width: 36px;
		height: 36px;
		display: flex;
		align-items: center;
		justify-content: center;
		border-radius: 50%;
		background: rgba(239, 68, 68, 0.1);
		color: #ef5350;
		transition: all 0.2s;
		border: 1px solid rgba(239, 68, 68, 0.2);
	}
	
	.btn-logout-icon:hover {
		background: #ef5350;
		color: white;
		transform: rotate(90deg);
	}
</style>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
	<div class="container-fluid px-4">
		
		<div class="d-flex align-items-center">
			<a class="navbar-brand me-0" href="<c:url value='/home' />">
				<img src="https://files.catbox.moe/c373f9.webp" alt="Logo" class="brand-logo">
			</a>
			
			<div class="student-info-badge d-none d-md-flex">
				<i class="fas fa-graduation-cap"></i>
				<span>Nguyễn Nhật Thiên - 23110153</span>
			</div>
		</div>

		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarNav">
			<c:if test="${sessionScope.user != null}">
				
				<ul class="navbar-nav mx-auto">
					<li class="nav-item">
						<a class="nav-link nav-link-custom ${uri.contains('/home') ? 'active' : ''}" 
						   href="<c:url value='/home' />">
							<i class="fas fa-home"></i> Trang Chủ
						</a>
					</li>

					<c:if test="${sessionScope.user.admin}">
						<li class="nav-item">
							<a class="nav-link nav-link-custom ${uri.contains('/users') ? 'active' : ''}" 
							   href="<c:url value='/admin/users' />">
								<i class="fas fa-users"></i> Người Dùng
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link nav-link-custom ${uri.contains('/categories') ? 'active' : ''}" 
							   href="<c:url value='/admin/categories' />">
								<i class="fas fa-utensils"></i> Danh Mục
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link nav-link-custom ${uri.contains('/videos') ? 'active' : ''}" 
							   href="<c:url value='/admin/videos' />">
								<i class="fas fa-play-circle"></i> Video
							</a>
						</li>
					</c:if>
				</ul>

				<div class="d-flex align-items-center gap-3">
					<a href="<c:url value='/profile' />" class="d-flex align-items-center gap-2 text-decoration-none text-white">
						<div class="text-end d-none d-lg-block" style="line-height: 1.2;">
							<div style="font-weight: 600; font-size: 0.9rem;">${sessionScope.user.fullname}</div>
							<div style="font-size: 0.75rem; color: #ff8a65;">
								${sessionScope.user.admin ? 'Administrator' : 'Member'}
							</div>
						</div>
						
						<c:choose>
							<c:when test="${not empty sessionScope.user.images}">
								<img src="${sessionScope.user.images.startsWith('http') ? sessionScope.user.images : pageContext.request.contextPath.concat('/images/').concat(sessionScope.user.images)}" 
									 class="user-avatar-small" alt="Avt">
							</c:when>
							<c:otherwise>
								<div class="user-avatar-small d-flex align-items-center justify-content-center bg-secondary text-white fw-bold">
									${sessionScope.user.fullname.charAt(0)}
								</div>
							</c:otherwise>
						</c:choose>
					</a>
					
					<a href="<c:url value='/logout' />" class="btn-logout-icon" title="Đăng Xuất">
						<i class="fas fa-power-off"></i>
					</a>
				</div>
			</c:if>

			<c:if test="${sessionScope.user == null}">
				<div class="ms-auto d-flex gap-2">
					<a href="<c:url value='/login' />" class="btn btn-outline-light rounded-pill px-4">Đăng Nhập</a>
					<a href="<c:url value='/register' />" class="btn btn-warning rounded-pill px-4 fw-bold">Đăng Ký</a>
				</div>
			</c:if>
		</div>
	</div>
</nav>