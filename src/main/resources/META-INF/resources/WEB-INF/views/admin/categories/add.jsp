<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add/Edit Category</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
	<section class="row">
		<div class="col-6 offset-3 mt-4">
			<form action="<c:url value='/admin/categories/saveOrUpdate' />"
				method="POST" enctype="multipart/form-data">
				
				<div class="card">
					<div class="card-header">
						<h2>Add/Update Category</h2>
					</div>
					<div class="card-body">
						
						<div class="mb-3">
							<label for="id" class="form-label">Category ID:</label> 
							<input type="text" readonly="readonly" class="form-control"
								value="${category.id}" id="id" name="id" 
								placeholder="Auto Generated">
						</div>

						<div class="mb-3">
							<label for="categoryName" class="form-label">Category Name:</label> 
							<input type="text" class="form-control"
								value="${category.categoryName}" id="categoryName" name="categoryName"
								placeholder="Enter Category Name" required>
						</div>

						<div class="mb-3">
							<label for="imageFile" class="form-label">Category Image:</label>
							<input type="file" class="form-control" id="imageFile" name="imageFile">
						</div>
						
						<c:if test="${not empty category.images}">
							<div class="mb-3">
								<label class="form-label">Current Image:</label><br>
								<img src="/images/${category.images}" width="100px" class="img-thumbnail" />
								<input type="hidden" name="images" value="${category.images}">
							</div>
						</c:if>

						<input type="hidden" name="isEdit" value="${not empty category.id}">

					</div>
					
					<div class="card-footer text-muted">
						<a href="<c:url value='/admin/categories/add'/>"
							class="btn btn-secondary"><i class="fas fa-plus"></i> New</a> 
						
						<a href="<c:url value='/admin/categories' />" class="btn btn-success">
							<i class="fas fa-list"></i> List Categories</a>
						
						<button class="btn btn-primary" type="submit">
							<i class="fas fa-save"></i> <span>Save</span>
						</button>
					</div>
				</div>
			</form>
		</div>
	</section>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>