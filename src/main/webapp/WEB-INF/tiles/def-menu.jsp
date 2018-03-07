<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<div class="hor-menu ">

	<ul class="nav navbar-nav">
		<%-- <li><a href="<c:url value="/login" />">Login</a></li> --%>

		<li><a data-toggle="modal" data-target="#login-modal"> Log In
		</a></li>
		<li><a href="<c:url value="/contactus" />">Contact Us</a></li>
	</ul>

</div>


<div class="modal fade" id="login-modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true" data-toggle="modal"
	data-backdrop="static" data-keyboard="false" style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h2>Sign In</h2>
			</div>

			<div class="modal-body">
				<c:if test="${not empty error}">
					<div class="alert alert-danger">
						<spring:message
							code="AbstractUserDetailsAuthenticationProvider.badCredentials" />
						<br />
					</div>
				</c:if>

				<form action="<spring:url value="/postLogin"></spring:url>"
					method="POST">
					<div class="form-group row">
						<div class="col-md-3 col-lg-3">
							<label>Username: </label>
						</div>

						<div class="col-md-9 col-lg-9">
							<input type="text" class="form-control username" name="username"
								placeholder="Username" required autofocus>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-3 col-lg-3">
							<label>Password: </label>
						</div>
						<div class="col-md-9 col-lg-9">
							<input type="password" class="form-control" name="password"
								placeholder="Password" required>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-12">
							<label class="checkbox"> <input type="checkbox"
								name="keepMe"> Remember Me
							</label>
						</div>
					</div>

					<input type="submit" name="login"
						class="btn btn-lg btn-primary btn-block login loginmodal-submit"
						value="Login">
				</form>
			</div>

			<div class="modal-footer">
				<a class="col-md-3" data-toggle="modal"
					data-target="#forgetPassword-modal">Forgot Password </a>
				<!-- <a href="#" class="col-md-3">Forgot Password</a> -->
				<button type="button" class="btn red" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="forgetPassword-modal" role="dialog">
	<div class="modal-dialog ">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h2 class="modal-title">Reset Password</h2>
			</div>
			<form action="<spring:url value="/postResetPassword"></spring:url>"
				method="post">
				<div class="modal-body">
					<c:if test="${not empty errorMessage}">
						<div class="alert alert-danger">
							${errorMessage}
						</div>
					</c:if>
					<div class="form-group row">
						<div class="col-md-3 col-lg-12">
							<label>Please enter your email address</label>
						</div>
					</div>
					<fieldset>
						<div class="form-group row">
							<div class="col-md-3 col-lg-12">
								<input class="form-control username" placeholder="Email"
									name='email' type="email" required>
							</div>
						</div>
					</fieldset>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary">Reset</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>

				</div>
			</form>
		</div>
	</div>
</div>

