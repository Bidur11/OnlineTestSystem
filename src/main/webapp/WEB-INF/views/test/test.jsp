<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>
<body onload="examTimer()">
<div class="portlet box blue">
	<div class="portlet-title">
		<div class="caption col-sx-12">
			<i class="fa fa-edit"></i>Online Test - Maharishi University of Management
		</div>
		<div id="showtime" class="col-sx-12"></div>
	</div>
	<div class="portlet-body">
			<div class="row">
				<div class="col-md-12">
					<h3 class="test_header">Student Name: ${assignment.studentId.firstName}
				${assignment.studentId.lastName}</h3>
					<%-- <h3 class="">Student Id:
					${assignment.studentId.userId}</h3> --%>
					<div class="test_body">
						<h3 class="questionNumber">Questions 1/${totalTestCount}</h3>
						<input type="hidden" id="testCount" value="${totalTestCount}">						
						
						<div class="col-md-12 test_description">
							<form class="form-horizontal " role="form">
								<div class="form-body" id="radOption">	
									<label id="description"><h4>${test.question.description}</h4></label>								
									<div class="radio-list" id="qList">
										<c:forEach items="${test.question.choices}" var="choice"
											varStatus="count">
			
											<label><input type="radio" name="optionsRadios"
												id="optionsRadios${choice.id}" value="${choice.id}">
												${choice.description} </label>
			
			
										</c:forEach>
									</div>
									<div class="row">
										<input class="btn btn-lg btn-success btn-mini btnPrev"
										type="button" id="0" style="display: none;" value="Previous">
									<input class="btn btn-lg btn-success btn-mini btnNext"
										type="button" id="0" value="Next"> <a href="#myModal3"
										role="button" style="display: none;"
										class="btn btn-lg btn-success btnTestSubmit" data-toggle="modal">
										Submit for grading </a>
									</div>
								</div>
							</form>
						</div>						
					</div>					
				</div>				
			</div>
	</div>
	<div id="myModal3" class="modal fade" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel3" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true"></button>
					<h4 class="modal-title">Confirm Header</h4>
				</div>
				<div class="modal-body">
					<p>Do you want to submit for grading?</p>
				</div>
				<div class="modal-footer">
					<button class="btn default" data-dismiss="modal"
						aria-hidden="true">Close</button>
					<button data-dismiss="modal" class="btn blue btnTestFinish">Confirm</button>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden" name="minute" />
	<input type="hidden" name="second" />
</div>
<!-- <body onload="examTimer()">
	<div class="content">
		<div class="portlet light">
			
			
			
			<div class="portlet-body form">
				
			</div>
			
		</div>
	</div>
</body> -->
</body>
<script>
	var tim;
	var min = '${sessionScope.min}';
	var sec = '${sessionScope.sec}';

	$(document).ready(function() {
		window.history.pushState(null, "", window.location.href);
		window.onpopstate = function() {
			window.history.pushState(null, "", window.location.href);
		};
	});

	function examTimer() {
		if (parseInt(sec) > 0) {

			document.getElementById("showtime").innerHTML = "Time Remaining :"
					+ min + " Minute " + sec + " Seconds";
			sec = parseInt(sec) - 1;
			tim = setTimeout("examTimer()", 1000);
		} else {

			if (parseInt(min) == 0 && parseInt(sec) == 0) {
				document.getElementById("showtime").innerHTML = "Time Remaining :"
						+ min + " Minute ," + sec + " Seconds";
				alert("Time Up");
				/* document.questionForm.minute.value=0;
				document.questionForm.second.value=0; */
				var qNum = parseInt($(".btnPrev").attr("id"));
				$(".btnPrev").hide();
				$(".btnNext").hide();
				$(".btnTestSubmit").hide();

				var CurrentQuestion = {}; //The Object to Send Data Back to the Controller
				CurrentQuestion.questionNum = qNum;
				CurrentQuestion.answer = $('#radOption input:radio:checked')
						.val();

				$.ajax({
					type : 'POST',
					url : '/onlinetest/test/finishTest',
					contentType : 'application/json; charset=utf-8',
					dataType : 'json',
					data : JSON.stringify(CurrentQuestion),
					success : function(data) {

					},
					error : function(jqXHR, status, err) {

					}
				});

				window.location.replace("../../../onlinetest/test/completed");
			}

			if (parseInt(sec) == 0) {
				document.getElementById("showtime").innerHTML = "Time Remaining :"
						+ min + " Minute ," + sec + " Seconds";
				min = parseInt(min) - 1;
				sec = 59;
				tim = setTimeout("examTimer()", 1000);
			}

		}
	}
</script>
