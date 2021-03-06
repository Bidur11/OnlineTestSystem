<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
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
			<div class="container">
				<div class="page-logo">
					<a href=" <c:url value="/home" /> "><img
						src="<c:url value="/metronic/assets/logo.png" />" height="70px;"
						alt="logo" class="logo-default"></a>
				</div>
				<!-- BEGIN RESPONSIVE MENU TOGGLER -->
				<a href="javascript:;" class="menu-toggler"></a>
			</div>
		</div>
		<!-- END HEADER TOP -->
		<!-- BEGIN HEADER MENU -->
		<div class="page-header-menu">
			<div class="container">
				
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
				<div class="row">
					<div class="col-md-12 margin-top-10 margin-bottom-10">
						<tiles:insertAttribute name="content"></tiles:insertAttribute>
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

<!-- END PAGE LEVEL SCRIPTS -->
	<script>
		jQuery(document).ready(function() {
			// initiate layout and plugins
			Metronic.init(); // init metronic core components
			Layout.init(); // init current layout
			
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
			        
			    });
			}
			
			$('.modal').on('shown.bs.modal', function () {
			    $('.username').focus();
			});
			
			//test page script
			
			$(".btnNext").live("click",function(){
				var qNum = parseInt($(this).attr("id"));
				var testCount = parseInt($('#testCount').val());
				$(".btnPrev").show();
				if(parseInt(qNum) == testCount-2){
					$(".btnNext").hide();
					$(".btnTestSubmit").show();
				}else{
					$(".btnNext").show();
					$(".btnTestSubmit").hide();
				}
				setAnswer(qNum, 1);
			});
			
			$(".btnPrev").live("click",function(){
				var qNum = parseInt($(this).attr("id"));
				var testCount = parseInt($('#testCount').val());
				if(parseInt(qNum) == 1){
					$(".btnPrev").hide();
				}
				if(parseInt(qNum) == testCount-1){
					$(".btnNext").show();
					$(".btnTestSubmit").hide();
				}
				setAnswer(qNum, 2);
			});
			
			function setAnswer(arg1, arg2) {
								
				var qNum = parseInt(arg1);
				var qNewNum = 0;
				var testCount = $('#testCount').val();
				$(".questionNumber").empty();
								
				if(parseInt(arg2) == 1){
					qNewNum = parseInt(qNum)+1;
					var num = qNewNum+1;
					$(".questionNumber").append("Questions "+num+"/"+testCount);
					$(".btnNext").attr("id", qNum+1);
					$(".btnPrev").attr("id", qNum+1);
				}else{
					qNewNum = parseInt(qNum)-1;
					var num = qNewNum+1;
					$(".questionNumber").append("Questions "+num+"/"+testCount);
					$(".btnNext").attr("id", qNum-1);
					$(".btnPrev").attr("id", qNum-1);
				}
				
				var CurrentQuestion = {}; //The Object to Send Data Back to the Controller
				CurrentQuestion.questionNum = qNum;
			    CurrentQuestion.newQuestionNum = qNewNum;
				CurrentQuestion.answer = $('#radOption input:radio:checked').val();

				$.ajax({
					type: 'POST',
					url: '/onlinetest/test/setAnswer',
					contentType : 'application/json; charset=utf-8',
				    dataType : 'json',
	                data: JSON.stringify(CurrentQuestion),
	                success: function (data) {
	                	$("#description").empty();
	                	$("#description").append("<h4>"+data.description+"</h4>");
	                	var str = "<label><input type='radio' name='question'  value='"+data.ch1_id+"'"; 
	                	if(data.answer == data.ch1_id){
	                		str+="checked";
	                	}
	                	str += "/> " + data.ch1+"</label>";
	                	
	                	str += "<label><input type='radio' name='question'  value='"+data.ch2_id+"'"; 
	                	if(data.answer == data.ch2_id){
	                		str+="checked";
	                	}
	                	str += "/> " + data.ch2+"</label>";
	                	
	                	str += "<label><input type='radio' name='question'  value='"+data.ch3_id+"'"; 
	                	if(data.answer == data.ch3_id){
	                		str+="checked";
	                	}
	                	str += "/> " + data.ch3+"</label>";
	                	
	                	str += "<label><input type='radio' name='question'  value='"+data.ch4_id+"'"; 
	                	if(data.answer == data.ch4_id){
	                		str+="checked";
	                	}
	                	str += "/> " + data.ch4+"</label>";
	                	// for choice more than 4 
	                	/* str += "<label><input type='radio' name='question'  value='"+data.ch5_id+"'"; 
	                	if(data.answer == data.ch5_id){
	                		str+="checked";
	                	}
	                	str += "/> " + data.ch5+"</label>";
	                	
	                	str += "<label><input type='radio' name='question'  value='"+data.ch6_id+"'"; 
	                	if(data.answer == data.ch6_id){
	                		str+="checked";
	                	}
	                	str += "/> " + data.ch6+"</label>";
	                	 */
	                	
						$("#qList").empty();
	                	$("#qList").append(str).fadeIn(10000);
	                	Metronic.init(); // init metronic core components
	        			Layout.init(); 
	                },error: function(jqXHR, status, err){
	                   /*  alert(jqXHR.responseText); */
	                }
				});
			}
			
			
	       
				
	       
	        
	        $(".btnTestFinish").live("click",function(){
	       		finish(); 	
			});
	        
	        function finish() {
	        	var qNum = parseInt($(".btnPrev").attr("id"));
				$(".btnPrev").hide();
				$(".btnNext").hide();
				$(".btnTestSubmit").hide();
				
				var CurrentQuestion = {}; //The Object to Send Data Back to the Controller
				CurrentQuestion.questionNum = qNum;
				CurrentQuestion.answer = $('#radOption input:radio:checked').val();
				
				$.ajax({
					type: 'POST',
					url: '/onlinetest/test/finishTest',
					contentType : 'application/json; charset=utf-8',
				    dataType : 'json',
	                data: JSON.stringify(CurrentQuestion),
	                success: function (data) {

	                },error: function(jqXHR, status, err){

	                }
				});
				
				window.location.replace("../../../../onlinetest/test/completed");

	        }
			
			
		});
	</script>
	<!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->
</html>
