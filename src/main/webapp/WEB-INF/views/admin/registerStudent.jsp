<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<link href="<c:url value="/metronic/assets/global/css/bootstrap-datetimepicker.min.css" />" rel="stylesheet" type="text/css"/>

<script src="<c:url value="/metronic/assets/global/scripts/moment.js" />" type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/global/scripts/bootstrap-datetimepicker.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/admin/pages/scripts/registerStudent.js" />" type="text/javascript"></script>

<div class="portlet box blue">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-edit"></i>Student Registration
		</div>
	</div>
	<div class="portlet-body">
		<p class="hint">Enter student information below:</p>
		<c:if test="${not empty success}">
			<div class="alert alert-success" >
				<strong>Success!</strong> Successfully added new Student!
			</div>
		</c:if>
		<c:if test="${not empty error}">
			<div class="alert alert-warning" >
				<strong>Warning!</strong> Student ID is duplicated!
			</div>
		</c:if>
		<c:if test="${not empty duplicateEmailError}">
			<div class="alert alert-warning" >
				<strong>Warning!</strong> Email is duplicated!
			</div>
		</c:if>
		<!-- BEGIN REGISTRATION FORM -->
		<form:form method="POST" class="register-form"
			action="registerStudent" modelAttribute="student">
			<div class="form-group">
				<form:label path="studentId"
					class="control-label visible-ie8 visible-ie9">Student ID</form:label>
				<form:input path="studentId" class="form-control placeholder-no-fix"
					type="text" placeholder="Student ID" name="studentId" onchange="checkStudentID();" id="stdId"  required="true"/>
					<span > <font color="red" id="id_status"></font> </span>
					<input type="hidden" id="user_role" value="${sessionScope.role}">
				<form:errors path="studentId" cssClass="text-danger" />
			</div>
			<div class="form-group">
				<form:label path="email"
					class="control-label visible-ie8 visible-ie9">Email</form:label>
				<form:input path="email" class="form-control placeholder-no-fix"
					type="text" placeholder="Email" name="email" onchange="checkEmail();" id="userEmail" />
					<span > <font color="red" id="email_status"></font> </span>
				<form:errors path="email" cssClass="text-danger" />
			</div>
			<div class="form-group">
				<form:label path="firstName"
					class="control-label visible-ie8 visible-ie9">First Name</form:label>
				<form:input path="firstName" class="form-control placeholder-no-fix"
					type="text" placeholder="First Name" name="firstName" />
				<form:errors path="firstName" cssClass="text-danger" />
			</div>
			<div class="form-group">
				<form:label path="lastName"
					class="control-label visible-ie8 visible-ie9">Last Name</form:label>
				<form:input path="lastName" class="form-control placeholder-no-fix"
					type="text" placeholder="Last Name" name="lastName" />
				<form:errors path="lastName" cssClass="text-danger" />
			</div>
			<div class="form-group">			
				<form:label path="entry"
					class="control-label visible-ie8 visible-ie9">Entry Year</form:label>
				<form:input path="entry" class="form-control placeholder-no-fix"
					type="text" placeholder="Entry year" name="entry" id='datetimepicker' required="true" />
				<form:errors path="entry" cssClass="text-danger" />
			</div>
			<div class="form-group">
				<form:label class="control-label" path="jobSearchStatus">Job search status</form:label> 
				<form:select
					class="select2_category form-control category"
					path="jobSearchStatus" name="jobSearchStatus"
					data-placeholder="Choose a status" tabindex="1">
						<form:option value="True">Active</form:option>
						<form:option value="False">Inactive</form:option>
				</form:select>
				<form:errors path="jobSearchStatus" cssClass="text-danger" />
			</div>			
			<form:hidden path="enabled" value="TRUE" />
			<div class="form-actions">
				<button type="submit" id="register-submit-btn"
					class="btn btn-success uppercase">Submit</button>
				<a href="students" class="btn btn-primary"> CANCEL</a>
			</div>
			<br/><br/>
		</form:form>
	</div>	
</div>