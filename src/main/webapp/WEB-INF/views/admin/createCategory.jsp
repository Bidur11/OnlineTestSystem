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
				<strong>Success!</strong> Successfully added new Category!
			</div>
		</c:if>
		<!-- 		checking category already exists or not -->
		<c:if test="${success.equals('')}">
			<div class="alert alert-success">
				<strong style="color: #d54425">Failed!</strong> Category name
				already exists!!
			</div>
		</c:if>
		<!-- BEGIN REGISTRATION FORM -->
		<form:form method="POST" class="register-form" action="createCategory"
			modelAttribute="Category">
			<p class="hint">Enter information below:</p>
			<div class="form-group">
				<form:label path="name"
					class="control-label visible-ie8 visible-ie9">Category Name</form:label>
				<form:input path="name" id="categoryInput"
					class="form-control placeholder-no-fix" type="text"
					placeholder="Category Name" name="name" required="true"/>
				<form:errors path="name" cssClass="text-danger" />
			</div>
			<form:hidden path="enabled" value="TRUE" />
			<div class="form-actions">
				<button type="submit" id="register-submit-btn"
					class="btn btn-success uppercase">Submit</button>
				<a href="categories" class="btn btn-primary"> CANCEL</a>
			</div>
		</form:form>
	</div>
</div>
