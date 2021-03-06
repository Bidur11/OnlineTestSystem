<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/include.jsp"%>
<script>
	$(document).on("click", ".btnDel", function() {
		var helpId = $(this).attr('value');
		$(".modal-footer #del").val(helpId);
	});
	
	$(document).ready(function() {
	$(".btnDelHelp").live(
			"click",
			function() {
				var id = $(this).val();
				var role = $("#user_role").val();

				$.ajax(
						{
							url : '/onlinetest/' + role
									+ '/deleteHelpDescription?descriptionId='
									+ id,
							method : 'POST'
						}).done(function(data) {
				});
				$("#help" + id).remove();
			});
	});
	
</script>
<input type="hidden" id="user_role" value="${role}">
<div class="portlet box blue">

	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-edit"></i>ScreenShots and Description List
		</div>

	</div>

	<div class="portlet-body">
		<div class="table-toolbar">
			<div class="row">
				<div class="col-md-4">
					<!-- <div class="btn-group">
						<a href="uploadScreenShots" class="btn green"> Add Heading
							<i class="fa fa-plus"></i>
						</a>
					</div> -->

				</div>
			</div>
		</div>

		<table class="table table-striped table-hover table-bordered"
			id="sample_editable_1">
			<thead>
				<tr>
					<th>SN</th>
					<th>Help Description</th>
					<th>Step ID</th>
					<th>Edit</th>
					<th>Delete</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${allImageFile}" var="imgfile" varStatus="status">
					<tr id="help${imgfile.descriptionId}">
						<td>${status.count}</td>
						<td>${imgfile.description}</td>
						<td>${imgfile.stepId}</td>
						<td><a href="editDescription/${fileId}/${imgfile.descriptionId}">
								Edit </a></td>
						<td><button value="${imgfile.descriptionId}" type="button"
								class="btnDel btn btn-xs btn-default pull-right"
								data-toggle="modal" data-target="#confirmDeleteModal">Delete</button></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<div class="modal fade" id="confirmDeleteModal" tabindex="-1"
	role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Delete ?</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">Are you sure you want to delete?</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
				<button type="button" class=" btnDelHelp btn btn-primary" id="del"
					data-dismiss="modal">Yes</button>
			</div>
		</div>
	</div>
</div>
