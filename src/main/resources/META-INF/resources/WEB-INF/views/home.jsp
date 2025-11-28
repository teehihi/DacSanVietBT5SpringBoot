<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Trang Chủ - Đặc Sản Việt</title>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
/* Reset và Font chữ */
body {
	background-color: #080b12; /* Nền trang trùng màu tối nhất của gradient */
	color: #fff;
	font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
	overflow-x: hidden;
}

/* --- HERO SECTION --- */
.hero-section {
    background-image:
		/* Lớp 1: Ánh sáng vàng cam ở góc trên bên phải (Top Right) */
		radial-gradient( circle at 90% 10%, rgba( 255, 180, 0, 0.15) 0%,
		transparent 50%),
		/* Lớp 2: Ánh sáng đỏ hồng ở góc trên bên trái (Top Left) */
        radial-gradient( circle at 10% 10%, rgba( 255, 50, 50, 0.2) 0%,
		transparent 50%),
		/* Lớp 3: Nền tổng thể ở giữa (Radial từ tâm ra tối dần) */
        radial-gradient( circle at center, #3d1010 0%, #0a0202 100%);
	background-repeat: no-repeat;
	background-size: cover;
	min-height: 100vh;
	border-radius: 24px;
	margin-top: 30px;
	margin-bottom: 40px;
	position: relative;
	overflow: hidden;
	padding: 80px 60px; /* Tăng padding để thoáng hơn */
	display: flex;
	align-items: center;
	min-height: 500px; /* Tăng chiều cao để chứa ảnh đẹp hơn */
	box-shadow: 0 20px 60px rgba(234, 60, 18, 0.15); /* Bóng đổ nhẹ màu cam */
}

/* Nội dung chữ bên trái */
.hero-content {
	z-index: 2;
	position: relative;
	max-width: 550px;
}

.hero-title {
	font-size: 5rem; /* Chữ to hơn */
	font-weight: 800;
	line-height: 1.1;
	color: #fff;
	margin-bottom: 24px;
	text-shadow: 0 4px 10px rgba(0,0,0,0.2);
}

.hero-subtitle {
	font-size: 1.15rem;
	color: rgba(255, 255, 255, 0.95);
	margin-bottom: 40px;
	font-weight: 400;
	line-height: 1.6;
	max-width: 480px;
}

/* Nút bấm Admin */
.btn-hero {
	background-color: #ff5722; /* Cam tươi */
	background-image: linear-gradient(45deg, #ff5722, #ff8a50);
	color: #fff;
	font-weight: 600;
	padding: 14px 40px;
	border-radius: 50px;
	border: none;
	font-size: 1rem;
	transition: all 0.3s ease;
	box-shadow: 0 10px 25px rgba(255, 87, 34, 0.4); /* Bóng nút phát sáng */
}

.btn-hero:hover {
	transform: translateY(-4px);
	box-shadow: 0 15px 35px rgba(255, 87, 34, 0.6);
	color: #fff;
	filter: brightness(1.1);
}

/* Ảnh món ăn bên phải */
.hero-image-container {
	position: absolute;
	right: 50px; /* Căn lề phải chuẩn */
	top: 50%;
	transform: translateY(-50%);
	width: 480px;
	max-width: 45%;
	z-index: 1;
	transition: transform 0.5s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.hero-image-container img {
	width: 100%;
	height: auto;
	object-fit: contain;
	/* Bóng đổ rất quan trọng để tách ảnh khỏi nền tối */
	filter: drop-shadow(10px 20px 30px rgba(0, 0, 0, 0.6));
}

.hero-section:hover .hero-image-container {
	transform: translateY(-52%) scale(1.02); /* Hiệu ứng nổi nhẹ */
}

/* ================= FEATURE CARDS (CodePen Style Glow) ================= */
.feature-card {
    position: relative;
    background: #111621; /* Nền gốc */
    border-radius: 20px;
    padding: 35px 25px;
    text-align: center;
    height: 100%;
    /* Quan trọng: Để ẩn phần gradient thừa ra ngoài */
    overflow: hidden; 
    /* Quan trọng: Để xếp chồng các lớp pseudo-element */
    z-index: 1; 
    transition: transform 0.3s ease;
    border: 1px solid rgba(255, 255, 255, 0.05); /* Viền mờ khi chưa hover */
}

/* 1. Tạo lớp nền đen bên trong đè lên gradient (để tạo cảm giác viền mỏng) */
.feature-card::after {
    content: '';
    position: absolute;
    /* inset: khoảng cách từ mép vào, chính là độ dày của viền sáng */
    inset: 2px; 
    background: #111621; /* Trùng màu nền thẻ */
    border-radius: 18px; /* Bo góc nhỏ hơn thẻ cha chút xíu */
    z-index: -1; /* Nằm dưới nội dung nhưng nằm trên gradient xoay */
}

/* 2. Tạo Gradient xoay tròn (Hiệu ứng ánh sáng) */
.feature-card::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    width: 200%; /* Kích thước lớn hơn thẻ để khi xoay vẫn phủ kín */
    height: 200%;
    /* Gradient quét dạng nón: Trong suốt -> Cam nhạt -> Cam đậm */
    background: conic-gradient(
        from 0deg, 
        transparent 0%, 
        transparent 70%, 
        #ff9800 80%, 
        #ff5722 90%, 
        #ffffff 100%
    );
    /* Căn giữa và định vị */
    transform: translate(-50%, -50%) rotate(0deg);
    z-index: -2; /* Nằm dưới cùng */
    opacity: 0; /* Mặc định ẩn */
    transition: opacity 0.3s ease;
}

/* 3. Hiệu ứng khi Hover */
.feature-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 10px 40px rgba(255, 87, 34, 0.2); /* Bóng đổ cam nhẹ */
    border-color: transparent; /* Ẩn viền tĩnh đi */
}

.feature-card:hover::before {
    opacity: 1; /* Hiện gradient */
    animation: rotateBorder 3s linear infinite; /* Kích hoạt xoay */
}

/* Animation xoay vòng tròn */
@keyframes rotateBorder {
    from { transform: translate(-50%, -50%) rotate(0deg); }
    to { transform: translate(-50%, -50%) rotate(360deg); }
}

/* Đảm bảo nội dung bên trong nổi lên trên nền giả */
.icon-wrapper, .card-title, .card-desc {
    position: relative;
    z-index: 2;
}

.icon-wrapper {
    margin-bottom: 15px;
    font-size: 2.5rem;
    display: inline-block;
    transition: transform 0.3s;
}

.feature-card:hover .icon-wrapper {
    transform: scale(1.1); /* Phóng to icon nhẹ khi hover */
}

/* Icon màu cam đặc trưng */
.icon-orange {
    background: linear-gradient(to bottom right, #ff9800, #ff5722);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    filter: drop-shadow(0 2px 5px rgba(255, 87, 34, 0.3));
}

.card-title {
    font-size: 1.2rem;
    font-weight: 700;
    color: #fff;
    margin-bottom: 8px;
}

.card-desc {
    color: #8b9bb4;
    font-size: 0.9rem;
    line-height: 1.5;
}

/* Responsive */
@media ( max-width : 991px) {
	.hero-section {
		flex-direction: column;
		text-align: center;
		padding: 50px 20px;
		background: linear-gradient(180deg, #ea3c12 0%, #0b0f19 80%);
	}
	.hero-content {
		margin-bottom: 40px;
		margin-right: 0;
	}
	.hero-image-container {
		position: relative;
		right: auto;
		top: auto;
		transform: none !important;
		width: 70%;
		max-width: 350px;
	}
}

/* User Info Box */
.user-welcome-strip {
	background: rgba(255, 255, 255, 0.05);
	border-radius: 12px;
	padding: 10px 20px;
	margin-bottom: 0px; /* Sát vào hero hơn */
	font-size: 0.9rem;
	display: flex;
	justify-content: space-between;
	align-items: center;
    border: 1px solid rgba(255,255,255,0.1);
}
</style>
</head>

<body>

	<jsp:include page="/WEB-INF/views/common/header.jsp" />

	<div class="container">

		<c:if test="${user != null}">
			<div class="user-welcome-strip mt-4 mb-3">
				<span>Xin chào, <strong style="color: #ff8a65;">${user.fullname}</strong></span>
				<span class="badge bg-dark border border-secondary">${user.admin ? 'Admin' : 'Member'}</span>
			</div>
		</c:if>

		<div class="hero-section">
			<div class="hero-content">
				<h1 class="hero-title">
					Đặc Sản Việt
				</h1>
				<p class="hero-subtitle">
                    Khám phá hương vị Việt – kết nối văn hoá & ẩm thực ba miền.
                    Tinh hoa hội tụ trong từng món ăn.
                </p>
				<a href="<c:url value='/admin/users' />" class="btn btn-hero">
					Vào Trang Admin
				</a>
			</div>

			<div class="hero-image-container">
                <img src="https://files.catbox.moe/e88ufq.webp"
					alt="Bun Bo Hue Vietnam Special">
			</div>
		</div>

        <div class="row g-4 mb-5">
			<div class="col-md-4">
				<a href="<c:url value='/admin/users' />" class="text-decoration-none">
					<div class="feature-card">
						<div class="icon-wrapper">
							<i class="fa-solid fa-users icon-orange"></i>
						</div>
						<h4 class="card-title">Quản Lý Người Dùng</h4>
						<p class="card-desc">
							Hệ thống phân quyền & quản lý <br> tài khoản thành viên
						</p>
					</div>
				</a>
			</div>

			<div class="col-md-4">
				<a href="<c:url value='/admin/categories' />" class="text-decoration-none">
					<div class="feature-card">
						<div class="icon-wrapper">
							<i class="fa-solid fa-utensils icon-orange"></i>
						</div>
						<h4 class="card-title">Danh Mục Món Ăn</h4>
						<p class="card-desc">
							Thư viện ẩm thực phong phú <br> theo vùng miền Việt Nam
						</p>
					</div>
				</a>
			</div>

			<div class="col-md-4">
				<a href="<c:url value='/admin/videos' />" class="text-decoration-none">
					<div class="feature-card">
						<div class="icon-wrapper">
							<i class="fa-solid fa-play icon-orange"></i>
						</div>
						<h4 class="card-title">Video Hướng Dẫn</h4>
						<p class="card-desc">
							Trải nghiệm nấu ăn trực quan <br> qua video chất lượng cao
						</p>
					</div>
				</a>
			</div>
		</div>

	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>