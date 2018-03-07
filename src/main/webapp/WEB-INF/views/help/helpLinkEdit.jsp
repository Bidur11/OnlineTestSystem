<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>
<div class="portlet box blue">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-edit"></i>Update Help Link
		</div>
	</div>
	<div class="portlet light">
		<form:form method="POST" class="register-form"
			modelAttribute="linkEdit">

			<div class="portlet-body form-group">
				<div class="row">
					<div class="col-md-3">
						Help Link
					</div>
					<div class="col-md-9">
						<form:input class="form-control" path="helpLink" type="text"
									value="${linkEdit.helpLink}" />
					</div>
				</div>
			</div>

			<div class="row">

				<a href="<c:url value = "/admin/allHelpLink" />" class="btn red">
					Cancel </a> <input type="submit" value="Update" class="btn green">

			</div>

		</form:form>
	</div>
</div>
