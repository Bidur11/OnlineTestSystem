<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>

<script type="text/javascript">

$(document).on("click", ".btnDel", function() {
	var categoryId = $(this).attr('value');
	$(".modal-footer #del").val(categoryId);
});

</script>

<input type="hidden" id="user_role" value="${scopeSession.role}">

<div class="portlet box blue">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-edit"></i>Category List
		</div>
	</div>
	<div class="portlet-body">
		<div class="table-toolbar">
			<div class="row">
				<div class="col-md-6">
					<div class="btn-group">
						<a href="createCategory" class="btn green"> Add New <i
							class="fa fa-plus"></i>
						</a>
					</div>
				</div>
			</div>
		</div>
		<table class="table table-striped table-hover table-bordered"
			id="sample_editable_1">
			<thead>
				<tr>
					<th>Category Name</th>
					<th>Sub Category count</th>
					<th>Delete</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${categories}" var="category">
						<tr id="category${category.id}">
							<td>${category.name}</td>
							<td>${category.subCategoryCount}</td>
							<td>
								<c:if test="${category.subCategoryCount == 0}">
									<button value="${category.id}" type="button"
									class="btnDel btn btn-xs btn-default pull-right" data-toggle="modal" data-target="#confirmDeleteModal">Delete</button>
								</c:if>
							</td>
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
				<h5 class="modal-title" id="exampleModalLabel">Delete Category?</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">Are you sure you want to delete?</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
				<button type="button" class=" btnDelCat btn btn-primary" id="del"
					data-dismiss="modal">Yes</button>
			</div>
		</div>
	</div>
</div>

