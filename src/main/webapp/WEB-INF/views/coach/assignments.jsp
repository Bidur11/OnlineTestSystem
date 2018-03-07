<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<script type="text/javascript">
	//added functionality for active, inactive and all users 
	$(document).ready(function() {
		getdata();
		//var flag = "false";
	});
	function getdata() {
		var userRole = document.getElementById("user_role").value;
		var selectedValue = $("#assignmentStatus").val();
		var currenturl = '/onlinetest/'+userRole+'/assignments';
		//jQuery.ajaxSetup({async: false});
		$
				.ajax({
					type : 'post',
					url : currenturl,
					data : {
						'selectedValue' : selectedValue
					},
					success : function(data) {
						$
								.each(
										data,
										function(key, value) {
											var status;
											var report = '';
											var startYear;
											var endYear;
											if (value.start_date != null) {
												startYear = value.start_date.month
														+ " "
														+ value.start_date.dayOfMonth
														+ ", "
														+ value.start_date.year
														+ "  "
														+ value.start_date.hour
														+ ":"
														+ value.start_date.minute
														+ ":"
														+ value.start_date.second;
											} else {
												startYear = "";
											}
											if (value.end_date != null) {
												endYear = value.end_date.month
														+ " "
														+ value.end_date.dayOfMonth
														+ ", "
														+ value.end_date.year
														+ "  "
														+ value.end_date.hour
														+ ":"
														+ value.end_date.minute
														+ ":"
														+ value.end_date.second;
											} else {
												endYear = "";
											}
											if (value.start == "true"
													&& value.finish == "true") {
												status = status = '<span class="label label-primary">F</span> ';
												report = '<a href="<spring:url value="/'+userRole+'/result/'+value.assignmentId+'" />">Result</a>| '
														+ '<a href="<spring:url value="/'+userRole+'/resultDetail/'+value.assignmentId+'" />">Detail</a>| '
														+ '<a href="<spring:url value="/'+userRole+'/resultDetail/'+value.assignmentId+'" />">Feedback</a>';
											}
											if (value.start == "true"
													&& value.finish == "false") {
												status = status = '<span class="label label-warning">S</span>';
												report = "";
											}
											if (value.start == "false"
													&& value.finish == "false") {
												status = status = '<span class="label label-info">A</span>';
												report = "";
											}
											$('#sample_editable_1')
													.dataTable()
													.fnAddData(
															[
																	key + 1,
																	value.coachFirstName,
																	value.studentId,
																	value.studentFirstName
																			+ " "
																			+ value.studentLastName,
																	value.studentEntry,
																	value.studentEmail,
																	startYear,
																	endYear,
																	value.count,
																	status,
																	report,
															]);
											//}
										});
						//   }
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
	// end of added functionality
</script>

<input type="hidden" id="user_role" value="${role}">

<div id="assignment" class="portlet box blue ">
	<div class="portlet-title">
		<div class="caption">
			<div class="caption">
				<i class="fa fa-edit"></i>Assignment List
			</div>
		</div>
		<div class="actions">
			<jsp:useBean id="now" class="java.util.Date" />
			Date Time :
			<fmt:formatDate value="${now}" type="both" dateStyle="medium"
				timeStyle="medium" />
			<fmt:formatDate value="${now}" pattern="z" />
			<button id="export" class="btn btn-circlebtn-icon-only  btn-default">Export
			</button>
			<a class="btn btn-circle btn-icon-only btn-default fullscreen"
				href="#" data-original-title="" title=""></a>
		</div>
	</div>
	<div class="portlet-body">
		<!-- 		<div class="table-toolbar">
			<div class="row">
				<div class="col-md-6"></div>
			</div>
		</div>
		<br> <br>
		<div class="row">
			<div class="col-md-8"></div>
		</div>
		<br> <br> -->
		<!-- 		// added functionalities -->

		<div class="col-md-3 pull-right status-search">
			<div class="col-md-3">
				<label>Status:</label>
			</div>
			<div class="col-md-9">
				<select id="assignmentStatus" class="form-control col-md-2"
					onchange="refresh()">
					<option value="all">All</option>
					<option value="assigned">Assigned</option>
					<option value="scheduled">Started</option>
					<option value="finished">Finished</option>


				</select>
			</div>
		</div>


		<!-- 		// end of added functionalities -->



		<div id="table_wrapper">
			<table class="table table-striped table-hover table-bordered"
				id="sample_editable_1">
				<thead>
					<tr>
						<th>No</th>
						<th>Coach</th>
						<th>StudentID</th>
						<th>Full Name</th>
						<th>Entry</th>
						<th>Email</th>
						<th>Date Assigned</th>
						<th>Date Finished</th>
						<th>Try</th>
						<th>Status</th>
						<th class="noExl">Report</th>

					</tr>
				</thead>
				<!-- 				<tbody> -->
				<%-- 					<c:forEach items="${assignments}" var="assignment" --%>
				<%-- 						varStatus="status"> --%>
				<!-- 						<tr> -->
				<%-- 							<td>${status.count}</td> --%>
				<%-- 							<td>${assignment.coachId.firstName}</td> --%>
				<%-- 							<td>${assignment.studentId.studentId}</td> --%>
				<%-- 							<td>${assignment.studentId.firstName} --%>
				<%-- 								${assignment.studentId.lastName}</td> --%>
				<%-- 							<td>${assignment.studentId.entry}</td> --%>
				<%-- 							<td>${assignment.studentId.email}</td> --%>
				<%-- 							<td><fmt:parseDate value="${ assignment.start_date }" --%>
				<%-- 									pattern="yyyy-MM-dd'T'HH:mm" var="parsedStartDateTime" --%>
				<%-- 									type="both" /> <fmt:formatDate --%>
				<%-- 									value="${ parsedStartDateTime }" type="both" dateStyle="medium" --%>
				<%-- 									timeStyle="medium" /> <fmt:formatDate --%>
				<%-- 									value="${ parsedStartDateTime }" pattern="z" /></td> --%>
				<%-- 							<td><fmt:parseDate value="${ assignment.end_date }" --%>
				<%-- 									pattern="yyyy-MM-dd'T'HH:mm" var="parsedEndDateTime" --%>
				<%-- 									type="both" /> <fmt:formatDate value="${ parsedEndDateTime }" --%>
				<%-- 									type="both" dateStyle="medium" timeStyle="medium" /> <fmt:formatDate --%>
				<%-- 									value="${ parsedEndDateTime }" pattern="z" /></td> --%>
				<%-- 							<td>${assignment.count}</td> --%>
				<%-- 							<td><c:choose> --%>

				<%-- 									<c:when --%>
				<%-- 										test="${assignment.started == true and assignment.finished==true}"> --%>
				<!-- 										<span class="label label-primary">F</span> -->
				<%-- 									</c:when> --%>
				<%-- 									<c:when --%>
				<%-- 										test="${assignment.started == true and assignment.finished==false}"> --%>
				<!-- 										<span class="label label-warning">S</span> -->
				<%-- 									</c:when> --%>
				<%-- 									<c:when --%>
				<%-- 										test="${assignment.started == false and assignment.finished==false}"> --%>
				<!-- 										<span class="label label-info">A</span> -->
				<%-- 									</c:when> --%>
				<%-- 									<c:otherwise> --%>

				<%-- 									</c:otherwise> --%>
				<%-- 								</c:choose></td> --%>
				<%-- 							<td class="noExl"><c:choose> --%>

				<%-- 									<c:when --%>
				<%-- 										test="${assignment.started == true and assignment.finished==true}"> --%>


				<!-- 										<a -->
				<%-- 											href="<spring:url value="/${sessionScope.role}/result/${assignment.id}" />">result</a> | <a --%>
				<%-- 											href="<spring:url value="/${sessionScope.role}/resultDetail/${assignment.id}" />">detail</a> --%>
				<!--                                       | <a -->
				<%-- 											href="<spring:url value="/${sessionScope.role}/resultDetail/${assignment.id}" />">Feedback</a> --%>

				<%-- 									</c:when> --%>
				<%-- 								</c:choose></td> --%>
				<!-- 						</tr> -->
				<%-- 					</c:forEach> --%>
				<!-- 				</tbody> -->
			</table>

		</div>
	</div>
</div>
<script
	src="<c:url value="/metronic/assets/global/plugins/jquery.min.js" />"
	type="text/javascript"></script>
<script
	src="<c:url value="/metronic/assets/global/plugins/jquery-migrate.min.js" />"
	type="text/javascript"></script>
<%-- <script src="<c:url value="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"/>"></script> --%>
<%-- <script  src="<c:url value="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"/>"></script> --%>
<script type="text/javascript"
	src="<c:url value="https://code.jquery.com/ui/1.12.0-beta.1/jquery-ui.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.1.135/jspdf.min.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="http://cdn.uriit.ru/jsPDF/libs/adler32cs.js/adler32cs.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/2014-11-29/FileSaver.min.js"/>"></script>
<%-- <script type="text/javascript" src="<c:url value="libs/Blob.js/BlobBuilder.js"/>"></script> --%>
<script type="text/javascript"
	src="<c:url value="http://cdn.immex1.com/js/jspdf/plugins/jspdf.plugin.addimage.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="http://cdn.immex1.com/js/jspdf/plugins/jspdf.plugin.standard_fonts_metrics.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="http://cdn.immex1.com/js/jspdf/plugins/jspdf.plugin.split_text_to_size.js"/>"></script>
<script type="text/javascript"
	src="<c:url value="http://cdn.immex1.com/js/jspdf/plugins/jspdf.plugin.from_html.js"/>"></script>
<script type="text/javascript"
src="<c:url value="/metronic/assets/admin/pages/scripts/jquery.table2excel.js"/>"></script>
