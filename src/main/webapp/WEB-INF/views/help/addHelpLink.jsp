<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>


<div class="portlet box blue">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-edit"></i>Upload New Heading
		</div>
	</div>
	<div class="portlet-body">
		<form:form method="POST" enctype="multipart/form-data"
			class="register-form" action="addHelpLink"
			modelAttribute="fileUpload">
			<div class="form-group row">
				<div class="col-md-3">
					<form:label path="helpLink" class="control-label">Help Link</form:label>
				</div>
				<div class="col-md-9">
					<form:input path="helpLink" class="form-control placeholder-no-fix"
						type="text" placeholder="help link name" required="required"
						name="helpLink" />
					<form:errors path="helpLink" cssClass="text-danger" />
				</div>
			</div>
			<div class="form-actions">
				<a href="<c:url value = "/admin/allHelpLink" />" class="btn red"> Cancel </a> <input
					type="submit" value="Save" id="register-submit-btn"
					class="btn btn-success">
			</div>
		</form:form>
	</div>
</div>