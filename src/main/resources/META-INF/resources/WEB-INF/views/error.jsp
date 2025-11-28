<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Lỗi - Quản Lý Sinh Viên</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<style>
	body {
		background: #0f0f23;
		color: #ffffff;
		font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
		min-height: 100vh;
		display: flex;
		align-items: center;
		justify-content: center;
		position: relative;
		overflow: hidden;
	}
	
	body::before {
		content: '';
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background: 
			radial-gradient(circle at 20% 50%, rgba(102, 126, 234, 0.1) 0%, transparent 50%),
			radial-gradient(circle at 80% 80%, rgba(118, 75, 162, 0.1) 0%, transparent 50%);
		z-index: 0;
		pointer-events: none;
	}
	
	.error-container {
		text-align: center;
		position: relative;
		z-index: 1;
		max-width: 600px;
		padding: 40px;
	}
	
	.error-icon {
		font-size: 120px;
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
		background-clip: text;
		margin-bottom: 30px;
		animation: bounce 2s infinite;
	}
	
	@keyframes bounce {
		0%, 20%, 50%, 80%, 100% {
			transform: translateY(0);
		}
		40% {
			transform: translateY(-10px);
		}
		60% {
			transform: translateY(-5px);
		}
	}
	
	.error-title {
		font-size: 3rem;
		font-weight: 800;
		margin-bottom: 20px;
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		-webkit-background-clip: text;
		-webkit-text-fill-color: transparent;
		background-clip: text;
	}
	
	.error-message {
		font-size: 1.2rem;
		color: rgba(255, 255, 255, 0.8);
		margin-bottom: 40px;
		line-height: 1.6;
	}
	
	.error-details {
		background: rgba(16, 21, 62, 0.6);
		border: 1px solid rgba(102, 126, 234, 0.2);
		border-radius: 16px;
		padding: 20px;
		margin-bottom: 40px;
		backdrop-filter: blur(10px);
	}
	
	.error-code {
		font-size: 1.5rem;
		font-weight: 700;
		color: #ef4444;
		margin-bottom: 10px;
	}
	
	.btn-home {
		background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		border: none;
		border-radius: 12px;
		padding: 15px 30px;
		font-weight: 600;
		color: white;
		text-decoration: none;
		display: inline-flex;
		align-items: center;
		gap: 10px;
		transition: all 0.3s ease;
		box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
		font-size: 1.1rem;
	}
	
	.btn-home:hover {
		transform: translateY(-2px);
		box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
		color: white;
	}
	
	.floating-shapes {
		position: absolute;
		width: 100%;
		height: 100%;
		overflow: hidden;
		z-index: 0;
	}
	
	.shape {
		position: absolute;
		opacity: 0.1;
		animation: float 6s ease-in-out infinite;
	}
	
	.shape:nth-child(1) {
		top: 10%;
		left: 10%;
		animation-delay: 0s;
	}
	
	.shape:nth-child(2) {
		top: 20%;
		right: 10%;
		animation-delay: 2s;
	}
	
	.shape:nth-child(3) {
		bottom: 10%;
		left: 20%;
		animation-delay: 4s;
	}
	
	@keyframes float {
		0%, 100% {
			transform: translateY(0px) rotate(0deg);
		}
		50% {
			transform: translateY(-20px) rotate(180deg);
		}
	}
</style>
</head>
<body>
	<div class="floating-shapes">
		<i class="fas fa-exclamation-triangle shape" style="font-size: 60px; color: #667eea;"></i>
		<i class="fas fa-cog shape" style="font-size: 40px; color: #764ba2;"></i>
		<i class="fas fa-bug shape" style="font-size: 50px; color: #ef4444;"></i>
	</div>
	
	<div class="error-container">
		<div class="error-icon">
			<i class="fas fa-exclamation-triangle"></i>
		</div>
		
		<h1 class="error-title">Oops! Có Lỗi Xảy Ra</h1>
		
		<p class="error-message">
			Xin lỗi, đã có lỗi xảy ra khi xử lý yêu cầu của bạn. 
			Vui lòng thử lại sau hoặc liên hệ với quản trị viên.
		</p>
		
		<div class="error-details">
			<div class="error-code">
				<i class="fas fa-code"></i> 
				Mã lỗi: ${status != null ? status : '500'}
			</div>
			<div style="color: rgba(255, 255, 255, 0.7);">
				<c:choose>
					<c:when test="${status == 404}">
						Trang bạn tìm kiếm không tồn tại.
					</c:when>
					<c:when test="${status == 403}">
						Bạn không có quyền truy cập trang này.
					</c:when>
					<c:when test="${status == 400}">
						Yêu cầu không hợp lệ.
					</c:when>
					<c:otherwise>
						Lỗi máy chủ nội bộ.
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		
		<div class="d-flex gap-3 justify-content-center flex-wrap">
			<a href="<c:url value='/home' />" class="btn-home">
				<i class="fas fa-home"></i> Về Trang Chủ
			</a>
			<a href="javascript:history.back()" class="btn-home" style="background: rgba(255, 255, 255, 0.1); box-shadow: 0 4px 15px rgba(255, 255, 255, 0.1);">
				<i class="fas fa-arrow-left"></i> Quay Lại
			</a>
		</div>
	</div>
</body>
</html>