<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page session="false"%>
<script type="text/javascript">
	//added functionality for active, inactive and all users 

	$(document).ready(function() {
		getdata();
		var flag = "false";
		$(".btnDelUser").live("click", function() {
			var id = $(this).val();
			var role = $("#user_role").val();

			$.ajax({
				url : '/onlinetest/' + role + '/deleteUser?userid=' + id,
				method : 'POST'
			}).done(function(data) {
				timer = setTimeout(refresh, 1000);
			});
		});

		$(".btnUnDelUser").live("click", function() {
			var id = $(this).val();
			var role = $("#user_role").val();

			$.ajax({
				url : '/onlinetest/' + role + '/unDeleteUser?userid=' + id,
				method : 'POST'
			}).done(function(data) {
				timer = setTimeout(refresh, 1000);
			});
		});

	});

	function getdata() {
		var selectedValue = $("#userenabledCheckTest").val();
		var currenturl = '/onlinetest/admin/users';

		$
				.ajax({
					type : 'post',
					url : currenturl,
					data : {
						'selectedValue' : selectedValue
					},
					success : function(data) {

						//alert(JSON.stringify(data));
						if (data != null && data.authorities != []) {

							$
									.each(
											data,
											function(key, value) {
												var enabled;
												var authority;
												var deleteBtn;
												if (value.enabled == true) {
													enabled = "Active";
													deleteBtn = '<button value="'
														+ value.userId
														+ '" type="button" class="btnDel btn btn-xs btn-default pull-right" data-toggle="modal" data-target="#confirmDeleteModal"">Delete</button>'
												}
												if (value.enabled == false) {
													enabled = "Inactive"
													deleteBtn = '<button value="'
														+ value.userId
														+ '" type="button" class="btnUnDel btn btn-xs btn-default pull-right" data-toggle="modal" data-target="#confirmUnDeleteModal""> UnDelete</button>';
												}

												var rowIndex = $(
														"#sample_editable_1")
														.dataTable()
														.fnAddData(
																[
																		value.username,
																		value.firstName
																				+ " "
																				+ value.lastName,
																		value.email,
																		value.authorities[0].authority,
																		enabled,
																		"<a href=\"editUser/"
																				+ parseInt(value.userId)
																				+ "\"  title=\"Edit\" onclick=\"return editUser('"
																				+ value.userId
																				+ "')\">Edit</a> ",
																		deleteBtn,

																// 																		'<button value="'
// 																				+ value.userId
// 																				+ '" type="button" class="btnDel btn btn-xs btn-default pull-right" data-toggle="modal" data-target="#confirmDeleteModal"">Delete</button>',

																]);
												/* $('table tr:last').attr('id',
														'user' + value.userId); */
												var row = $(
														'#sample_editable_1')
														.dataTable()
														.fnGetNodes(rowIndex);
												$(row).attr('id',
														"user" + value.userId);
											});
						}

					},
					error : function(jqXHR, status, err) {
						alert("Failure");
					}
				});
	}

	function refresh() {
		table = $('#sample_editable_1').DataTable();
		table.clear().draw();
		getdata();
	}

	$(document).on("click", ".btnDel", function() {
		var userId = $(this).attr('value');
		$(".modal-footer #del").val(userId);
	});

	$(document).on("click", ".btnUnDel", function() {
		var userId = $(this).attr('value');
		$(".modal-footer #undel").val(userId);
	});

	$(document).ready(function() {
		setTimeout(function() {
			$('#successMessage').fadeOut('fast');
		}, 5000);
	});

	// end of added functionality
</script>
<!--

//-->
<input type="hidden" id="user_role" value="${role}">
<div class="portlet box blue">
	<c:if test="${not empty success}">
		<div class="alert alert-success" id="successMessage">
			<strong>Success!</strong> Successfully added new user!
		</div>
	</c:if>
	<c:if test="${not empty successEdit}">
		<div class="alert alert-success" id="successMessage">
			<strong>Success!</strong> Successfully Edited user!
		</div>
	</c:if>
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-edit"></i>User List
		</div>
	</div>
	<div class="portlet-body">
		<div class="table-toolbar">
			<div class="row">
				<div class="col-md-2">
					<div class="btn-group">
						<a href="register" class="btn green"> Add New <i
							class="fa fa-plus"></i>
						</a>
					</div>
				</div>
				<!-- 		added functionality -->
				<div class="col-md-3 pull-right status-search">
					<div class="col-md-3">
						<label>Status:</label>
					</div>
					<div class="col-md-9">
						<select id="userenabledCheckTest" class="form-control col-md-2"
							onchange="refresh()">
							<option value="active">Active</option>
							<option value="inactive">Inactive</option>
							<option value="all">All</option>
						</select>
					</div>
				</div>
				<!-- 		// end of added functionality -->
			</div>
			<div class="row"></div>
		</div>

		<table id="sample_editable_1"
			class="table table-striped table-hover table-bordered">
			<thead>
				<tr>
					<th>Username</th>
					<th>Full Name</th>
					<th>Email</th>
					<th>Role</th>
					<!-- 					Enabled option added -->
					<th>Enabled</th>
					<th>Edit</th>
					<th>Delete</th>
				</tr>
			</thead>
		</table>

	</div>
</div>

<div class="modal fade" id="confirmDeleteModal" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Delete User?</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">Are you sure you want to delete?</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
				<button type="button" class="btnDelUser btn btn-primary" id="del"
					data-dismiss="modal">Yes</button>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" id="confirmUnDeleteModal" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Un Delete User?</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">Are you sure you want to Undelete?</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
				<button type="button" class="btnUnDelUser btn btn-primary"
					id="undel" data-dismiss="modal">Yes</button>
			</div>
		</div>
	</div>
</div>