<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>


<div class="portlet box blue">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-edit"></i>Upload Image and description
		</div>
	</div>
	<div class="portlet-body">
		<form:form method="POST" enctype="multipart/form-data"
			class="register-form" action="uploadDescription"
			modelAttribute="helpDescription">
			<div class="form-group row">
					<div class="col-md-3">
						<%-- <form:label path="fileId" class="control-label">FileId</form:label> --%>
					</div>
					<div class="col-md-9">
						<form:input path="fileId" class="form-control placeholder-no-fix" type="hidden" name="fileId" value="${fileId}" readonly="true"/>
					</div>
				</div>
				<div class="form-group row">
					<div class="col-md-3">
					<%-- 	<form:label path="imgName" class="control-label">Image Name</form:label> --%>
					</div>
					<div class="col-md-9">
						<form:input path="imgName" class="form-control placeholder-no-fix" type="hidden" placeholder="Image name" name="imgName" />
						<form:errors path="imgName" cssClass="text-danger" />
					</div>
				</div>
				 <div class="form-group row">
					<div class="col-md-3">
						<form:label path="description" class="control-label">Image Description</form:label>
					</div>
					<div class="col-md-9">
						<form:input path="description" class="form-control placeholder-no-fix" type="text" placeholder="Specific help links" required="required" name="description" />
						<form:errors path="description" cssClass="text-danger" />
					</div>
				</div>
				 <div class="form-group row">
					<div class="col-md-3">
						<form:label path="stepId" class="control-label">Image Step ID</form:label>
					</div>
					<div class="col-md-9">
						<form:input path="stepId" class="form-control placeholder-no-fix" type="text" placeholder="Image Step Id" required="required" name="stepId" />
						<form:errors path="stepId" cssClass="text-danger" />
					</div>
				</div>
				<div class="form-group row">
					<div class="col-md-3">
						<form:label path="file" class="control-label">Upload Image File</form:label>
					</div>
					<div class="col-md-9">
						<form:input type="file" path="file" required="required"
								id="file" class="form-control input-sm" name="file"/>
						<form:errors path="file" cssClass="text-danger" />
					</div>
				</div> 
			<div class="form-actions">	
				<a href="<c:url value = "/admin/allHelpLink" />" class="btn red"> Cancel </a>			
				<input type="submit" value="Save" id="register-submit-btn" class="btn btn-success">
			</div>
		</form:form>		
	</div>
</div>