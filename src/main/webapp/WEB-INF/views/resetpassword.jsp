<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<!-- BEGIN PAGE CONTAINER -->
	<div class="page-container">
		<!-- BEGIN PAGE CONTENT -->
		<div class="page-content">
			<div class="container">
				<div class="row margin-top-10">
					<div class="col-md-12">
						<div class="portlet box blue">
							<div class="portlet-title">
								<div class="caption">
									<i class="fa fa-edit"></i>Reset Password
								</div>
							</div>
							
							<div class="portlet-body">
								<div class="row">
									<div class="col-md-12">
										<c:if test="${not empty error}">
											<div class="alert alert-warning">Password do not match</div>
										</c:if>
						
										<c:if test="${not empty error}">
											<div class="alert alert-danger">
												<spring:message
													code="AbstractUserDetailsAuthenticationProvider.badCredentials" />
												<br />
											</div>
										</c:if>
										<form action="<spring:url value="/resetPassword"></spring:url>" method="post">
											<div class="form-group row">
												<div class="col-md-3 col-lg-3">
													<label></label>
												</div>
												
												<div class="col-md-9 col-lg-9">
													<input class="form-control" name='userAccessCode'
														type="hidden" value="${accessCode}">
												</div>
											</div>
											<div class="form-group row">
												<div class="col-md-3 col-lg-3">
													<label for="newpassword">New Password: </label>
												</div>
												
												<div class="col-md-9 col-lg-9">
													<input class="form-control" placeholder="New Password"
														name='newpassword' type="password" value="" id='newpassword'>
												</div>
											</div>
											<div class="form-group row">
												<div class="col-md-3 col-lg-3">
													<label for="confirmpassword">Confirm Password: </label>
												</div>
												
												<div class="col-md-9 col-lg-9">
													<input class="form-control" placeholder="Confirm Password"
														name='confirmpassword' type="password" value="" id='confirmpassword'>
												</div>
											</div>
											<div class="form-group row">
												<div class="col-md-3 col-lg-3">
												</div>
												<div class="form-actions col-md-3 col-lg-3">
													<button type="submit" id="register-submit-btn" class="btn btn-success">Reset Password</button>
												</div>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<script type="text/javascript">
	var password = document.getElementById("newpassword"), confirm_password = document
			.getElementById("confirmpassword");
	
	function validatePassword() {
		
		if (password.value != confirm_password.value) {
			confirm_password.setCustomValidity("Passwords Don't Match");
		} else {
			confirm_password.setCustomValidity('');
		}
	}

	password.onchange = validatePassword;
	confirm_password.onkeyup = validatePassword;
</script>