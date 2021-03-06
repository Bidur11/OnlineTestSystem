<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>
<div class="content">
	<c:if test="${not empty error}">
			<%@ include file="/WEB-INF/views/logPopUp.jsp"%>
	</c:if>
	<c:if test="${not empty error}">
		<div class="alert alert-warning">
			<strong>Warning!</strong> ${error} <br /> ${error2}
		</div>
	</c:if>
	<c:if test="${not empty success}">
		<div class="alert alert-success">
			<strong>Success!</strong> Successfully imported Data!
		</div>
	</c:if>


	<c:choose>
		<c:when test="${sessionScope.role == 'dba'}"></c:when>
		<c:otherwise>
			<div class="portlet box blue">
				<div class="portlet-title">
					<div class="caption">
						<i class="fa fa-edit"></i>Import Student Data ${sessionScope.role}
					</div>
				</div>
				<div class="portlet-body form">

					<form:form method="POST" class="register-form1"
						action="uploadStudents" enctype="multipart/form-data">
						<div class="form-body">
							<div class="form-group last">
								<label class="col-md-3 control-label">Excel file</label>
								<div class="col-md-4">
									<div class="input-group">
										<input type="file" name="ExcelFile" class="form-control"
											placeholder="Import Student Record" required="true" />
									</div>
								</div>
							</div>
						</div>
						<br />
						<div class="form-actions">
							<div class="row">
								<div class="col-md-offset-3 col-md-9">
									<button type="submit" class="btn green">Import Student</button>
								</div>
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</c:otherwise>
	</c:choose>



</div>

<div class="content margin-top-10">
	<div class="portlet box blue">
		<div class="portlet-title">
			<div class="caption">
				<i class="fa fa-edit"></i>Import Question Data
			</div>
		</div>
		<div class="portlet-body form">
			<form:form method="POST" class="register-form" action="importData"
				enctype="multipart/form-data">
				<div class="form-body">
					<div class="form-group last">
						<label class="col-md-3 control-label">Excel file</label>
						<div class="col-md-4">
							<div class="input-group">
								<input type="file" name="ExcelFile" class="form-control"
									placeholder="Import Question Record" required="true">
							</div>
						</div>
					</div>
				</div>
				<br />
				<div class="form-actions">
					<div class="row">
						<div class="col-md-offset-3 col-md-9">
							<button type="submit" class="btn green">Import Questions</button>
						</div>
					</div>
				</div>
			</form:form>
		</div>
	</div>
</div>
