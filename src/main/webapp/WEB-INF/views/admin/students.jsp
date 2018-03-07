<%@ include file="/WEB-INF/views/include.jsp"%>
<script type="text/javascript">
	//added functionality for active, inactive and all users 
	$(document).ready(function() {
		getdata();
		//svar flag = "false";
		
		$(".btnDelUser").live("click",function(){
			var id = $(this).val();
			var role = $("#user_role").val();
			
			$.ajax({
				url: '/onlinetest/'+role+'/deleteUser?userid=' + id,
				method: 'POST'
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
				
		var userRole = document.getElementById("user_role").value;		
		currenturl = "/onlinetest/" + userRole + "/students";
		
		$
				.ajax({
					type : 'post',
					url : currenturl,
					data : {
						'selectedValue' : selectedValue
					},
					success : function(data) {

						//alert(JSON.stringify(data));
						if (data != null) {

							$
									.each(
											data,
											function(key, value) {
												var enabled;
												var status;
												var deleteBtn;
												if (value.enabled == true) {
													enabled = "Enabled";
													 deleteBtn= '<button value="'+value.userId+'" class="btnDel btn btn-xs btn-default pull-right" data-toggle="modal" data-target="#confirmDeleteModal" >Delete</button>';
													
												}
												if (value.enabled == false) {
													enabled = "Disabled";
													deleteBtn = '<button value="'
														+ value.userId
														+ '" type="button" class="btnUnDel btn btn-xs btn-default pull-right" data-toggle="modal" data-target="#confirmUnDeleteModal""> UnDelete</button>';
												}
												if (value.jobSearchStatus == false) {
													status = "Inactive";
												}
												if (value.jobSearchStatus == true) {
													status = "Active";
												}
												
												

												var rowIndex = $("#sample_editable_1")
														.dataTable()
														.fnAddData(
																[
																		value.studentId,
																		value.firstName
																				+ " "
																				+ value.lastName,
																		value.email,
																		value.entry,
																		status,
																		enabled,
																		'<a href="editStudent/'+value.userId+'"> Edit </a>',
																		deleteBtn,

																	//	'<button value="'+value.userId+'" class="btnDel btn btn-xs btn-default pull-right" data-toggle="modal" data-target="#confirmDeleteModal" >Delete</button>'

																]);
												/* $('table tr:last').attr('id',
														'user' + value.userId); */
												var row = $('#sample_editable_1').dataTable().fnGetNodes(rowIndex);
												$(row).attr('id', "user"+value.userId);		
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

<c:if test="${not empty error}">
			<%@ include file="/WEB-INF/views/logPopUp.jsp"%>
</c:if>
<c:if test="${not empty error}">
	<div class="alert alert-warning">
		<strong>Warning!</strong> ${error}
	</div>
</c:if>
<c:if test="${not empty success}">
	<div class="alert alert-success">
		<strong>Success!</strong> Successfully imported Data!
	</div>
</c:if>

<c:if test="${not empty successAddStudent}">
		<div class="alert alert-success" id="successMessage">
			<strong>Success!</strong> Successfully added new Student!
		</div>
	</c:if>
	
	<c:if test="${not empty successEditStudent}">
		<div class="alert alert-success" id="successMessage">
			<strong>Success!</strong> Successfully Edited Student!
		</div>
	</c:if>

<input type="hidden" id="user_role" value="${role}">

<div class="portlet box blue">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-edit"></i>Student List
		</div>
	</div>
	<div class="portlet-body">
		<div class="table-toolbar">
			<div class="row">
				<div class="col-md-4">
					<div class="btn-group">
						<a href="registerStudent" class="btn green"> Add New <i
							class="fa fa-plus"></i>
						</a>
					</div>
					<div class="btn-group">
						<a href="#" class="btn green" data-toggle="modal"
							data-target="#batch-upload-modal"> Batch Upload <i
							class="fa fa-plus"></i>
						</a>
					</div>

				</div>
				
				<!-- 		added functionality -->
				<div class="col-md-3 pull-right">
					<div class="col-md-3">
						<label>Status:</label>
					</div>
					<div class="col-md-9">
						<select id="userenabledCheckTest" class="form-control col-md-2"
							onchange="refresh()">
							<option value="active">Enabled</option>
							<option value="inactive">Disabled</option>
							<option value="all">All</option>
						</select>
					</div>
				</div>
				<!-- 		// end of added functionality -->
				<%-- <div class="col-md-6">
					<fieldset>
						<legend>Import Student Record</legend>
						<form:form method="POST" class="register-form" action="uploadStudents" enctype="multipart/form-data">
							<div class="col-md-6">
								<input type="file" name="ExcelFile" class="form-control" placeholder="Import Student Record">
							</div>
							<div class="col-md-6">
								<button type="submit" class="btn green">Import  Student Record</button>
							</div>									
						</form:form>
					</fieldset>
				</div>
				<div class="col-md-4"></div> --%>
			</div>

			<div>${successes}</div>

		</div>
		<table class="table table-striped table-hover table-bordered"
			id="sample_editable_1">
			<thead>
				<tr>
					<th>Student ID</th>
					<th>Full Name</th>
					<th>Email</th>
					<th>Year</th>
					<th>Job Search Status</th>
					<th>Student Status</th>
					<th>Edit</th>
					<th>Delete</th>
				</tr>
			</thead>
			<!-- 			<tbody> -->
			<%-- 				<c:forEach items="${students}" var="student"> --%>
			<%-- 					<tr id="user${student.userId}"> --%>
			<%-- 						<td>${student.studentId}</td> --%>
			<%-- 						<td>${student.firstName}${student.lastName}</td> --%>
			<%-- 						<td>${student.email}</td> --%>
			<%-- 						<td class="center">${student.entry}</td> --%>
			<%-- 						<td class="center"><c:if test="${student.jobSearchStatus}"> --%>
			<!-- 								Active -->
			<%-- 							</c:if> <c:if test="${student.jobSearchStatus ne true}"> --%>
			<!-- 								Inactive -->
			<%-- 							</c:if></td> --%>
			<%-- 						<td><a href="editStudent/${student.userId}"> Edit </a></td> --%>
			<%-- 						<td><button value="${student.userId}" type="button" --%>
			<!-- 								class="btnDel btn btn-xs btn-default pull-right" data-toggle="modal" data-target="#confirmDeleteModal" >Delete</button></td> -->
			<!-- 					</tr> -->
			<%-- 				</c:forEach> --%>
			<!-- 			</tbody> -->
		</table>
	</div>
</div>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<div class="content">
</div>


<!--  Import Student Modal popup-->
<div class="modal fade" id="batch-upload-modal" tabindex="-1"
	role="dialog" aria-labelledby="" aria-hidden="true" data-toggle="modal"
	data-backdrop="static" data-keyboard="false" style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h2>Import Student Record</h2>
			</div>

			<div class="modal-body">

				<form method="POST" class="register-form" action="uploadStudents"
					enctype="multipart/form-data">
					<div class="row">
						<div class="col-md-6">
							<input type="file" name="ExcelFile" class="form-control"
								placeholder="Import Student Record" required="true">
						</div>
						<div class="col-md-6">
							<button type="submit" class="btn green">Import Student
								Record</button>
						</div>
					</div>
				</form>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn red" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!--  End of Import Student Modal Popup -->

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
				<button type="button" class=" btnDelUser btn btn-primary" id="del"
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
				<button type="button" class="btnUnDelUser btn btn-primary" id="undel"
					data-dismiss="modal">Yes</button>
			</div>
		</div>
	</div>

</div>
