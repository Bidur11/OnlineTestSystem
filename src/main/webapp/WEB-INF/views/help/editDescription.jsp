<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>
<div class="portlet box blue">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-edit"></i>Update Description
		</div>
	</div>
	<div class="portlet light">
		<form:form method="POST" 
			class="register-form" modelAttribute="descriptionEdit">

			<div class="portlet-body form-group">
				<div class="row">
					<div class="col-md-3">
						Help description
					</div>
					<div class="col-md-9">
						<form:input class="form-control" path="description" type="text"
						value="${descriptionEdit.description}" />
						<form:errors path="description" cssClass="text-danger" />
						
					</div>
				</div>
				<div class="row">
					<div class="col-md-3">
						Step ID
					</div>
					<div class="col-md-9">
						<form:input class="form-control" path="stepId" type="text"
						value="${descriptionEdit.stepId}" />
						<form:errors path="stepId" cssClass="text-danger" />
					</div>
				</div>
	</div> 

			<div class="row">

				<a href = "<c:url value = "/admin/allDescription/${fileId}" />" class="btn red"> Cancel </a>
				<input type="submit" value="Update" class="btn green">

			</div>

		</form:form>
	</div>
</div>
