<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>
<div class="portlet box blue">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-edit"></i>User Registration
		</div>
	</div>
	<div class="portlet-body">
		<c:if test="${not empty success}">
		<div class="alert alert-success" >
			<strong>Success!</strong> User updated!
		</div>
		</c:if>
		<c:if test="${not empty error}">
		<div class="alert alert-warning" >
			<strong style="color: #d54425">Failed!</strong> Username is duplicated!
		</div>
		</c:if>
		<c:if test="${not empty emailError}">
		<div class="alert alert-warning" >
			<strong>Warning!</strong>You can not use this email. This Email already exist!
		</div>
		</c:if>
		<!-- BEGIN REGISTRATION FORM -->
		<form:form method="POST" class="register-form" action="../editUser"
			modelAttribute="loginUser">
			<p class="hint">Enter your personal details below:</p>
			<form:hidden path="userId" name="userId" value="${user.userId}" />
			<div class="form-group">
				<form:label path="firstName"
					class="control-label visible-ie8 visible-ie9">First Name</form:label>
				<form:input path="firstName" class="form-control placeholder-no-fix"
					type="text" placeholder="First Name" name="firstName" value="${user.firstName}" required="true"/>
				<form:errors path="firstName" cssClass="text-danger" />
			</div>
			<div class="form-group">
				<form:label path="lastName"
					class="control-label visible-ie8 visible-ie9">Last Name</form:label>
				<form:input path="lastName" class="form-control placeholder-no-fix"
					type="text" placeholder="Last Name" name="lastName" value="${user.lastName}" required="true"/>
				<form:errors path="lastName" cssClass="text-danger" />
			</div>

			<div class="form-group">
				<form:label path="email"
					class="control-label visible-ie8 visible-ie9">Email</form:label>
				<form:input path="email" class="form-control placeholder-no-fix"
					type="text" placeholder="Email" name="email" value="${user.email}"/>
				<form:errors path="email" cssClass="text-danger" />
			</div>

			<p class="hint">Enter your account details below:</p>
			<div class="form-group">
				<form:label path="username"
					class="control-label visible-ie8 visible-ie9">Username</form:label>
				<form:input path="username" class="form-control placeholder-no-fix"
					type="text" readonly="true" autocomplete="off" placeholder="User Name" value="${user.username}"
					name="username"/>
				<form:errors path="username" cssClass="text-danger" />
			</div>
			<div class="form-group">
				<form:label path="password"
					class="control-label visible-ie8 visible-ie9">Password</form:label>
				<form:input path="password" class="form-control placeholder-no-fix"
					id="register_password" type="password" autocomplete="off"
					placeholder="Password" name="password" />
				<form:errors path="password" cssClass="text-danger" />
			</div>
			<div class="form-group">
				<label class="control-label col-lg-2" for="authority">Role</label>
				<form:select path="authorities[0].authority"
					name="authorities[0].authority" class="form-control">
					<c:if test="${user.authorities[0].authority == 'ROLE_ADMIN'}">
						<form:option value="ROLE_ADMIN" selected="selected">ROLE_ADMIN</form:option>
					</c:if>
					<c:if test="${user.authorities[0].authority != 'ROLE_ADMIN'}">
						<form:option value="ROLE_ADMIN">ROLE_ADMIN</form:option>
					</c:if>
					
					<c:if test="${user.authorities[0].authority == 'ROLE_COACH'}">
						<form:option value="ROLE_COACH" selected="selected">ROLE_COACH</form:option>
					</c:if>
					<c:if test="${user.authorities[0].authority != 'ROLE_COACH'}">
						<form:option value="ROLE_COACH">ROLE_COACH</form:option>
					</c:if>
					
					<c:if test="${user.authorities[0].authority == 'ROLE_DBA'}">
						<form:option value="ROLE_DBA" selected="selected">ROLE_DBA</form:option>
					</c:if>
					<c:if test="${user.authorities[0].authority != 'ROLE_DBA'}">
						<form:option value="ROLE_DBA">ROLE_DBA</form:option>
					</c:if>
				</form:select>
				<form:errors path="authorities[0].authority" cssClass="text-danger" />
			</div>
			<form:hidden path="enabled" value="TRUE" />
			<div class="form-actions">
				<button type="submit" id="register-submit-btn"
					class="btn btn-success uppercase">Submit</button>
				<a href="/onlinetest/${sessionScope.role}/users" class="btn btn-primary"> CANCEL</a>
			</div>
			<br/><br/>
		</form:form>
	</div>
</div>
