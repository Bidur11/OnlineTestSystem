<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String home = System.getProperty("user.home");
%>
<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">${titleMessage}</h4>
			</div>
			<div class="modal-body">
				<p></p>

				<div class="portlet">
					<div class="portlet-title">
						<div class="caption">
							<i class="fa fa-edit"></i>LOG INFO: ${filename}
						</div>
					</div>
					<br />
					<table id="log_table"
						class="table table-striped table-hover table-bordered">
						<thead>
							<tr>
								<th>SN</th>
								<th>Location</th>
								<th>Cause</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${errorLogPop}" var="log" varStatus="status">
								<tr>
									<td>${status.count}</td>
									<td>${ log.location}</td>
									<td>${ log.cause }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
			</div>

		</div>
	</div>
</div>

<!-- END OF MODAL -->

<script type="text/javascript">
	$(window).on('load', function() {
		$('#myModal').modal('show');
	});

	$(document).ready(function() {
		$('#log_table').DataTable({
			dom : 'Bfrtip',
			"paging" : false,
			"ordering" : false,
			"info" : false,
			"searching" : false,
			buttons : [ 'excel', 'pdf', 'print' ]
		});
	});
</script>


</script>