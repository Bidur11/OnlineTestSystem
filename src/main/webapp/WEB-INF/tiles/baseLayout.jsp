<%@page import="com.pm.onlinetest.domain.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ include file="/WEB-INF/views/include.jsp"%>
<!DOCTYPE html>
<html>
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
<meta charset="utf-8" />
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>Self Assessment System</title>
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<!-- BEGIN GLOBAL MANDATORY STYLES -->



	

<link rel="stylesheet" type="text/css" href="<c:url value="/metronic/assets/global/plugins/font-awesome/css/font-awesome.min.css" />" />
<link href="<c:url value="/metronic/assets/global/plugins/font-awesome/css/font-awesome.min.css" />" rel="stylesheet" type="text/css"/>
<link href="<c:url value="/metronic/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" />" rel="stylesheet" type="text/css"/>
<link href="<c:url value="/metronic/assets/global/plugins/bootstrap/css/bootstrap.min.css" />" rel="stylesheet" type="text/css"/>
<link href="<c:url value="/metronic/assets/global/plugins/uniform/css/uniform.default.css" />" rel="stylesheet" type="text/css"/>
<!-- END GLOBAL MANDATORY STYLES -->
<!-- BEGIN PAGE LEVEL STYLES -->
<link href="<c:url value="/metronic/assets/admin/pages/css/profile.css" />" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/metronic/assets/global/plugins/select2/select2.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/metronic/assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css" />" />
<!-- END PAGE LEVEL SCRIPTS -->
<!-- BEGIN THEME STYLES -->
<link href="<c:url value="/metronic/assets/global/css/components.css" />" id="style_components" rel="stylesheet" type="text/css"/>
<link href="<c:url value="/metronic/assets/global/css/plugins.css" />" rel="stylesheet" type="text/css"/>
<link href="<c:url value="/metronic/assets/admin/layout3/css/layout.css" />" rel="stylesheet" type="text/css"/>
<link href="<c:url value="/metronic/assets/admin/layout3/css/themes/default.css" />" rel="stylesheet" type="text/css" id="style_color"/>
<link href="<c:url value="/metronic/assets/global/plugins/lightbox.css" />" rel="stylesheet" type="text/css"/>
<link type="text/css" href="https://cdn.datatables.net/1.10.11/css/jquery.dataTables.min.css" rel="stylesheet">
<link type="text/css" href="https://cdn.datatables.net/buttons/1.1.2/css/buttons.dataTables.min.css" rel="stylesheet">
<link href="<c:url value="/metronic/assets/admin/layout3/css/custom.css" />" rel="stylesheet" type="text/css"/>
<!-- END THEME STYLES -->
<link rel="shortcut icon"/>


<!-- Mehdi : I moved this in the top because i will need it to be loaded before I execute  some of my scripts  -->
<script src="<c:url value="/metronic/assets/global/plugins/jquery.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/global/plugins/jquery-migrate.min.js" />" type="text/javascript"></script>


<!-- Replaced by this One-->
<!--  <script src="<c:url value="/metronic/ion-range-slider/js/vendor/jquery-1.12.3.min.js" />" type="text/javascript" ></script>-->

</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
	<!-- BEGIN HEADER -->
	<div class="page-header">
		<!-- BEGIN HEADER TOP -->
		<div class="page-header-top">
			<c:if test="${not empty baseLayoutSuccess}">
			<%@ include file="/WEB-INF/views/popUp.jsp"%>
			</c:if>
			<div class="container">
				<div class="page-logo">
					<a href="#"><img
						src="<c:url value="/metronic/assets/logo.png" />" height="70px;"
						alt="logo" class="logo-default"></a>
				</div>
				<!-- BEGIN RESPONSIVE MENU TOGGLER -->
				<a href="javascript:;" class="menu-toggler"></a>
				<!-- END RESPONSIVE MENU TOGGLER -->
				<!-- BEGIN TOP NAVIGATION MENU -->
				<div class="top-menu">
					<a href="javascript:;" class="btn btn-primary welcome">
						<span class="username">
							Welcome ${sessionScope.user.username}!
						</span>
					</a>
					
					<ul class="dropdown-menu-default nav navbar-nav pull-right">
						<li class="dropdown dropdown-user dropdown-dark" data-close-others="true">				          	
				          	<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown">
					          	<i class="fa fa-cog" aria-hidden="true"></i>
					          	<b class="caret"></b>
				          	</a>
				          	<ul class="dropdown-menu dropdown-menu-default">
					            <li><a data-toggle="modal" data-target="#profile-modal"> <i
										class="icon-user" data-toggle="modal" data-target="#profile-modal"></i> My Profile
								</a></li>
								<li class="divider"></li>
								<li><a data-toggle="modal" data-target="#password-modal"> <i
										class="icon-user" data-toggle="modal" data-target="#password-modal"></i> Change Password
								</a></li>
								<%-- <li><a href="<c:url value="/register" />"> <i
										class="icon-key"></i> Register
								</a></li> --%>
								<li class="divider"></li>
								<li>
									<a href="<c:url value="/logout" />"> <i class="icon-key"></i> Log Out</a>
								</li>
				          	</ul>
				        </li>
			        </ul>
					
				</div>
				<!-- END TOP NAVIGATION MENU -->
			</div>
		</div>
		
<!--  Profile Modal popup-->
<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true" data-toggle="modal" data-backdrop="static" data-keyboard="false"
	style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content">
    		<div class="modal-header">
				<%User user=(User)session.getAttribute("user"); %>
				<h2>User Name: ${sessionScope.user.username}</h2>
			</div>
	  			
			<div class="modal-body">
				<c:if test="${not empty error}">
					<div class="alert alert-danger">
						<spring:message code="AbstractUserDetailsAuthenticationProvider.badCredentials"/><br />
					</div>
				</c:if>
				
				<form action="<spring:url value="/editUserProfile"></spring:url>" method="POST">
					<div class="form-group row">
						<div class="col-md-3 col-lg-3">
							<label>First Name: </label>
						</div>
						
						<div class="col-md-9 col-lg-9">
							<label class="unEditable">${sessionScope.user.firstName}</label>
							<input type="text" name="firstName" class="editable" value="${sessionScope.user.firstName}" required="true"/>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-3 col-lg-3">
							<label>Last Name: </label>
							
						</div>
						
						<div class="col-md-9 col-lg-9">
							<label class="unEditable">${sessionScope.user.lastName}</label>
							<input type="text" name="lastName" class="editable" value="${sessionScope.user.lastName}" required="true"/>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-3 col-lg-3">
							<label>Email: </label>
						</div>
						<div class="col-md-9 col-lg-9">
							<label class="unEditable">${sessionScope.user.email}</label>
							<input type="email" name="email" class="editable" value="${sessionScope.user.email}" required="true"/>
						</div>
					</div>
					<div class="form-group row"> 
					 	<div class="col-md-12">
							<input type="button" id="btnEditProfile"
							class="unEditable btn btn-lg btn-primary btn-block"
							value="Edit">
							</div>
					</div>
					<div class="form-group row"> 
					 	<div class="col-md-6">
							<input type="submit" id="btnUpdateProfile"
							class="editable btn btn-lg btn-primary btn-block"
							value="Update">
							</div>
							
							<div class="col-md-6">
							<input type="button" id="btnCancel"
							class="editable btn btn-lg btn-primary btn-block"
							value="Cancel">
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
<!--  End of Profile Modal Popup -->
		
<!-- Password Change Modal -->	
<div class="modal fade" id="password-modal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true" data-toggle="modal" data-backdrop="static" data-keyboard="false"
	style="display: none;">
	<div class="modal-dialog">
		<div class="modal-content">
    				<div class="modal-header">
    				
				<h2>Change Password</h2>
			</div>
	  			
			<div class="modal-body">
				<c:if test="${not empty error}">
					<div class="alert alert-danger">
						<spring:message code="AbstractUserDetailsAuthenticationProvider.badCredentials"/><br />
					</div>
				</c:if>
				
				<form action="<spring:url value="/userChangePassword"></spring:url>" method="POST">
					<input type="hidden" name="currentURL" value="${requestScope['javax.servlet.forward.request_uri'] }"/>
					<div class="form-group row">
						<div class="col-md-3 col-lg-3">
							<label>New Password: </label>
						</div>
						
						<div class="col-md-9 col-lg-9">
							<input type="password" class="form-control name" id="nPassword" name="nPassword"
						placeholder="New password" required autofocus>
						</div>
					</div>
					<div class="form-group row">
						<div class="col-md-3 col-lg-3">
							<label>Confirm Password: </label>
						</div>
						
						<div class="col-md-3 col-lg-9">
							<input type="password" class="form-control name" id="cPassword" name="cPassword"
						placeholder="Confirm Password" required autofocus>
						</div>
					</div>
					
					 <div class="form-group row"> 
					 	<div class="col-md-12">
							<input type="submit" id="changePasswordBtn"
							class="btn btn-lg btn-primary btn-block"
							value="Change">
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
<!-- End of Password Change Modal -->
	
		<!-- END HEADER TOP -->
		<!-- BEGIN HEADER MENU -->
		<div class="page-header-menu">
			<div class="container">
				<!-- BEGIN MEGA MENU -->
				<!-- DOC: Apply "hor-menu-light" class after the "hor-menu" class below to have a horizontal menu with white background -->
				<!-- DOC: Remove data-hover="dropdown" and data-close-others="true" attributes below to disable the dropdown opening on mouse hover -->
				<tiles:insertAttribute name="menu" ignore="true"></tiles:insertAttribute>
				<!-- END MEGA MENU -->
			</div>
		</div>
		<!-- END HEADER MENU -->
	</div>
	<!-- END HEADER -->

	<!-- BEGIN PAGE CONTAINER -->
	<div class="page-container">
		<!-- BEGIN PAGE CONTENT -->
		<div class="page-content">
			<div class="container">
				<div class="row margin-top-10 margin-bottom-10">
					<div class="col-md-12">
						<!-- BEGIN PROFILE SIDEBAR -->
<!-- 						<div class="profile-sidebar" style="width: 250px;"> -->
<!-- 							PORTLET MAIN -->
<!-- 							<div class="portlet light profile-sidebar-portlet"> -->
<!-- 								<div class="panel-heading"> -->
<!-- 									<h4>Left Sidebar</h4> -->
<!-- 								</div> -->
<!-- 								<div class="panel-body"></div> -->
<!-- 							</div> -->
<!-- 							END PORTLET MAIN -->
<!-- 						</div> -->
<!-- 						<div class="profile-sidebar" style="width: 250px;">
							PORTLET MAIN
							<div class="portlet light profile-sidebar-portlet">
								<div class="panel-heading">
									<h4>Left Sidebar</h4>
								</div>
								<div class="panel-body"></div>
							</div>
							END PORTLET MAIN
						</div> -->
						<!-- END BEGIN PROFILE SIDEBAR -->
						<!-- BEGIN PROFILE CONTENT -->
						<div class="profile-content">
							<div class="row">
								<div class="col-md-12">
									<tiles:insertAttribute name="content"></tiles:insertAttribute>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- END PAGE CONTENT -->
	</div>
	<!-- END PAGE CONTAINER -->

	<!-- BEGIN PRE-FOOTER -->
	<!-- <div class="page-prefooter">
		<div class="container"></div>
	</div> -->
	<!-- END PRE-FOOTER -->
	<!-- BEGIN FOOTER -->
	<div class="page-footer">
		<div class="container">2017 &copy; All Rights Reserved.</div>
	</div>
	<div class="scroll-to-top">
		<i class="icon-arrow-up"></i>
	</div>
	<!-- END FOOTER -->

	<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
	<!-- BEGIN CORE PLUGINS -->
	<!--[if lt IE 9]>
<script src="../../assets/global/plugins/respond.min.js"></script>
<script src="../../assets/global/plugins/excanvas.min.js"></script> 
<![endif]-->




<%-- <!-- Profile view and edit -->
<script src="<c:url value="/resources/js/baseLayoutProfile.js" />" type="text/javascript"></script>
 --%>
<!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="<c:url value="/metronic/assets/global/plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/global/plugins/bootstrap/js/bootstrap.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/global/plugins/jquery.blockui.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/global/plugins/jquery.cokie.min.js" />" type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/global/plugins/uniform/jquery.uniform.min.js" />" type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script src="<c:url value="/metronic/assets/global/plugins/select2/select2.min.js" />" type="text/javascript" ></script>
<script src="<c:url value="/metronic/assets/global/plugins/datatables/media/js/jquery.dataTables.min.js" />"  type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js" />"  type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/global/plugins/jquery-validation/js/jquery.validate.min.js" />" type="text/javascript"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="<c:url value="/metronic/assets/global/scripts/metronic.js" />" type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/admin/layout3/scripts/layout.js" />" type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/admin/layout3/scripts/demo.js" />" type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/admin/pages/scripts/table-editable.js" />"></script>
<script src="<c:url value="/metronic/assets/admin/pages/scripts/login.js" />" type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/admin/pages/scripts/form-samples.js" />" type="text/javascript"></script>
<script src="<c:url value="/metronic/assets/global/plugins/lightbox.js" />" type="text/javascript"></script>

<script type="text/javascript" src="jquery-1.12.0.min.js"></script>
 
<script type="text/javascript" src="https://cdn.datatables.net/tabletools/2.2.4/js/dataTables.tableTools.min.js"></script>
<!-- <script type="text/javascript" src="https://cdn.datatables.net/tabletools/2.2.2/swf/copy_csv_xls_pdf.swf"></script> -->
<script type="text/javascript" src="https://cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.1.2/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.1.2/js/buttons.flash.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/pdfmake.min.js"></script>
<script type="text/javascript" src="https://cdn.rawgit.com/bpampuch/pdfmake/0.1.18/build/vfs_fonts.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.1.2/js/buttons.html5.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.1.2/js/buttons.print.min.js"></script>

<!-- END PAGE LEVEL SCRIPTS -->
	<script>
		jQuery(document).ready(function() {
			$('#selectedCategory').on('change',function(){
				var category_id = $('#selectedCategory').val();
				$.ajax({
					url:"/onlinetest/admin/createSubCategory/getSubCategory",
					type: "GET",
					data: {						
						id: category_id
					},
					success: function(response){
						var avaliableSubCategories = [];
						$.each(response.subcat, function(key, value) {							
							avaliableSubCategories.push(value);
						});
						$("#subcategoryDropdown").autocomplete({
							source : avaliableSubCategories
						});
					},
					failure: function(response){
						console.log(response);
					}
				});
			});
			// initiate layout and plugins
			Metronic.init(); // init metronic core components
			Layout.init(); // init current layout
			Login.init();
			Demo.init();  
			TableEditable.init();
			FormSamples.init();
			
			setNavigation();
			
			function setNavigation() {
			    var path = window.location.pathname;
			    path = path.replace(/\/$/, "");
			    path = decodeURIComponent(path);
			    $(".nav a").each(function () {
			        var href = $(this).attr('href');
			        if(href){
			        	if (path.substring(0, href.length) === href) {
				            $(this).closest('li').addClass('active');
				        }
			        }
			        $('title').text('Self Assessment System - '+$('.hor-menu .nav .active a').text());
			    });
			}
			
			
			$(".btnAssignCoach").on("click",function(){
				var coachId = $(".coachId").find('option:selected').val() ;
				var studentId = $(".studentId").find('option:selected').val() ;
				$.ajax({
					url: '/onlinetest/admin/assign?coachId=' + coachId +'&studentId='+studentId,
					method: 'POST'
					}).done(function(data) {
						if(data == "ok"){
							$(".alert-warning").hide();
							$(".alert-success").show();
						}else{
							$(".alert-warning").show();
							$(".alert-success").hide();
						}
				});
			});
/* 
			$(".btnDelStudentRecord").live("click",function(){
				var id = $(this).val();
				$.ajax({
					url: '/onlinetest/${sessionScope.role}/deleteAssign?userid=' + id,
					method: 'POST'
					}).done(function(data) {					
				});
				$("#user"+id).remove();
			}); */
			
			$(".btnDelCat").on("click",function(){
				var id = $(this).val();
				$.ajax({
					url: '/onlinetest/admin/deleteCategory?id=' + id,
					method: 'POST'
					}).done(function(data) {					
				});
				$("#category"+id).remove();
			});
			
			$(".btnDelSubCat").on("click",function(){
				var id = $(this).val();
				$.ajax({
					url: '/onlinetest/admin/deleteSubCategory?id=' + id,
					method: 'POST'
					}).done(function(data) {
				});
				$("#subCategory"+id).remove();
			});
			
			
			// from kedir export and other helper scripts
			
			$("#btnExport").click(function(e) {
			    e.preventDefault();
			    //getting data from our table
			    var data_type = 'data:application/vnd.ms-excel';
			    var table_div = document.getElementById('table_wrapper');
			    var table_html = table_div.outerHTML.replace(/ /g, '%20');
			    var a = document.createElement('a');
			    a.href = data_type + ', ' + table_html;
			    a.download = 'exported_table_' + Math.floor((Math.random() * 9999999) + 1000000) + '.xls';
			    a.click();
			  });
			
			$("#export").click(function() {
				$("#sample_editable_1").table2excel({
					exclude: ".noExl",
					name: "Excel Document Name",
					filename: "AssignmentList_Exported",
					fileext: ".xls",
					exclude_img: true,
					exclude_links: true,
					exclude_inputs: true
					
				});
			});
			$("#exportResult").click(function() {
				$("#sample_editable_1").table2excel({
					exclude: ".noExl",
					name: "Excel Document Name",
					filename: "ResultList_Exported",
					fileext: ".xls",
					exclude_img: true,
					exclude_links: true,
					exclude_inputs: true
				});
			});
			
			
			var specialElementHandlers = {
			        '#editor': function (element,renderer) {
			            return true;
			        }
			    };
			 $('#cmd').click(function () {
			        var doc = new jsPDF();
			        doc.fromHTML($('#posts-landing').html(), 100, 100, {
			            'width': 522,'elementHandlers': specialElementHandlers
			        });
			        doc.save('sample-file.pdf');
			    });
			 //user profile edit option hidden on page load
			 		$(".editable").css("display","none");
					
		});
		
		function demoFromHTML() {
		    var pdf = new jsPDF('p', 'pt', 'letter');
		    // source can be HTML-formatted string, or a reference
		    // to an actual DOM element from which the text will be scraped.
		    source = $('#posts-landing')[0];
		    // we support special element handlers. Register them with jQuery-style 
		    // ID selector for either ID or node name. ("#iAmID", "div", "span" etc.)
		    // There is no support for any other type of selectors 
		    // (class, of compound) at this time.
		    specialElementHandlers = {
		        // element with id of "bypass" - jQuery style selector
		        '#bypassme': function (element, renderer) {
		            // true = "handled elsewhere, bypass text extraction"
		            return true
		        }
		    };
		    margins = {
		        top: 80,
		        bottom: 60,
		        left: 40,
		        width: 800
		    };
		    // all coords and widths are in jsPDF instance's declared units
		    // 'inches' in this case
		    pdf.fromHTML(
		    source, // HTML string or DOM elem ref.
		    margins.left, // x coord
		    margins.top, { // y coord
		        'width': margins.width, // max width of content on PDF
		        'elementHandlers': specialElementHandlers
		    },
		    function (dispose) {
		        // dispose: object with X, Y of the last line add to the PDF 
		        //          this allow the insertion of new lines after html
		        pdf.save('StudentTestReport.pdf');
		    }, margins);
		}
	</script>
	<script type="text/javascript">
	var password = document.getElementById("nPassword"), confirm_password = document
			.getElementById("cPassword");
	
	function validatePassword() {
		
		if (password.value != confirm_password.value) {
			confirm_password.setCustomValidity("Passwords Don't Match");
		} else {
			confirm_password.setCustomValidity('');
		}
	}
	password.onchange = validatePassword;
	confirm_password.onkeyup = validatePassword;
	
	$("#btnEditProfile").click(function() {
		$(".unEditable").css("display","none");
		$(".editable").css("display","block");
	});
	$("#btnCancel").click(function() {
		$(".editable").css("display","none");
		$(".unEditable").css("display","block");
	});
	
	
	function checkEmail() {
		var email = document.getElementById("userEmail").value;
		userRole = document.getElementById("user_role").value;
		currenturl = "/onlinetest/" + userRole + "/checkEmail?email=" + email;
		if (email) {
			$.ajax({
				type : 'post',
				url : currenturl,
				data: {
					   'email':email,
					  },
				success : function(data) {
					$('#email_status').html(data);
				},
				error : function(jqXHR, status, err){
					console.log("error");
				}
			});
		} else {
			$('#email_status').html("");
			return false;
		}
	}
	
</script>
<!-- ADDED FUNCTIONALITIES TO AUTO FILL CATEGORIES -->
<script type="text/javascript">
var avaliableCategories = [];
function getCategoryList() {
	$.get('/onlinetest/admin/createCategory/getCategory', {
		name : "getlist"
	}, function(responseJson) {
		$.each(responseJson, function(key, value) {
			//  alert(value);
			avaliableCategories.push(value.name);
		});
	});
}
$(function() {
	getCategoryList();
	$("#categoryInput").autocomplete({
		source : avaliableCategories
	});
});
</script>
<!-- END OF ADDED FUNCTIONALITIES TO AUTO FILL CATEGORIES -->

	<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>