<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<div class="portlet box blue">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-edit"></i>Create Category
		</div>
	</div>
	<div class="portlet-body">
		<c:if test="${not empty success}">
			<div class="alert alert-success">
				<strong>Success!</strong> Successfully added new Sub Category!
			</div>
		</c:if>
		<c:if test="${success.equals('')}">

			<!-- 		failed message if sub category already exists during sub category addition  -->
			<div class="alert alert-success">
				<strong style="color: #d54425">Failed!</strong> Sub category already
				exists!
			</div>
		</c:if>
		<!-- BEGIN REGISTRATION FORM -->
		<form:form method="POST" class="register-form"
			action="createSubCategory" modelAttribute="Subcategory">
			<p class="hint">Enter information below:</p>
			<div class="form-group">
				<form:label class="control-label" path="category">Choose Category</form:label>
				<form:select id="selectedCategory"
					class="select2_category form-control category" path="categoryId"
					name="categoryId" data-placeholder="Choose a Category" tabindex="1">
					<c:forEach items="${categories}" var="category">
						<option value="${category.id}">${category.name}</option>
					</c:forEach>
				</form:select>
				<form:errors cssClass="text-danger" />
			</div>
			<div class="form-group">
				<form:label path="name"
					class="control-label visible-ie8 visible-ie9">Subcategory Name</form:label>
				<form:input path="name"
					class="form-control placeholder-no-fix" id="subcategoryDropdown"
					type="text" placeholder="Sub Category Name" name="name" required="true"/>
				<form:errors path="name" cssClass="text-danger" />
			</div>
			<form:hidden path="enabled" value="TRUE" />
			<c:if test="${categories != null}">
				<div class="form-actions">
					<button type="submit" id="register-submit-btn"
						class="btn btn-success uppercase">Submit</button>
					<a href="subCategories" class="btn btn-primary"> CANCEL</a>
				</div>
			</c:if>
		</form:form>
	</div>
</div>
