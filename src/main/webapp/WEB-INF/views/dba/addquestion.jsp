<%@ include file="/WEB-INF/views/include.jsp"%>
<%@ page session="true"%>
<input type="hidden" id="user_role" value="${sessionScope.role}">
<div class="portlet box blue">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-edit"></i>Add Questions
		</div>
	</div>
	<div class="portlet-body">
		<h1>${description}</h1>
		<c:if test="${not empty success}">
			<c:out value="${success}" />
			Do you want to add more? <h1>${question.description}</h1>
			<div class="btn-group" role="group" aria-label="...">
				<a href="addquestion">
					<button type="button" class="btn btn-default">YES</button>
				</a> <a href="/onlinetest/${sessionScope.role}/viewquestions">
					<button type="button" class="btn btn-default">NO</button>
				</a>

			</div>
		</c:if>
		<c:if test="${not empty duplicateError}">
			<div class="alert alert-danger">
				Error ! <c:out value="${duplicateError}" />
				<br/>
				Question Already Exists
			</div>
		</c:if>
		<c:if test="${empty success}">
			<form:form modelAttribute="question">
				<p class="hint">Enter Question and its choices below:</p>
				<div class="form-group">
					<form:label path="category"
						class="control-label visible-ie8 visible-ie9">Category Name</form:label>
					<form:select id="idCategory" path="category"
						class="form-control placeholder-no-fix"
						placeholder="Choice Category" multiple="true" required="required">

						<form:option value="" label="Select Category" />
						<form:options items="${categories}" itemLabel="name"
							itemValue="id" />

					</form:select>
				</div>
				<div class="form-group">
					<form:label path="subcategory.id"
						class="control-label visible-ie8 visible-ie9">Sub category</form:label>
					<div id="subCat">
						<form:select path="subcategory.id"
							class="form-control placeholder-no-fix" multiple="true"
							itemValue="id" itemLabel="name" required="required">
							<form:option value="" label="Sub Categories" />
						</form:select>
					</div>

				</div>

				<div class="form-group">
					<form:label path="description"
						class="control-label visible-ie8 visible-ie9">Question</form:label>
					<form:input path="description" id="description"
						class="form-control placeholder-no-fix" type="text"
						placeholder="Type the Question" required="required" />
					<form:errors path="description" cssClass="text-danger" />
				</div>

				<ol type="A">
					<p class="text-right">Correct Answer(select Only one)</p>
					<c:forEach items="${question.choices}" var="choice" varStatus="i">

						<div class="form-group">
							<div class="row">
								<div class="col-md-1 ">
									<span class="col-md-2 col-md-offset-5"><li></li></span>
								</div>
								<div class="col-md-10">

									<form:label path="choices[${i.index}].description"
										class="control-label visible-ie8 visible-ie9">Question</form:label>
									<form:input path="choices[${i.index}].description"
										class="form-control placeholder-no-fix"
										placeholder="Type the Choice" required="required" />


									<form:errors path="choices[${i.index}].description"
										cssClass="text-danger" />

								</div>
								<div class="col-md-1 ">
									<span class="col-md-2 col-md-offset-1"> <form:checkbox
											class="icheck" path="choices[${i.index}].answer" onchange="doCheck(this)" />
									</span>
								</div>

							</div>
						</div>

					</c:forEach>
				</ol>
				<div class="form-actions">
					<button type="submit" id="btnSubmit"
						class="btn btn-lg btn-success btn-mini"
						class="btn btn-success uppercase pull-right">Submit</button>
				</div>
	</div>
	<div id="result"></div>
	</form:form>
	</c:if>
</div>

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		$('#idCategory').change(function(event) {
			var id = $('#idCategory').val();

			$.ajax({
				type : 'POST',
				url : '/onlinetest/${sessionScope.role}/subcategories/' + id,
				contentType : 'application/json; charset=utf-8',
				dataType : 'json',
				success : function(data) {
					$('#subCat').empty();
					$('#subCat').append(data.subcat);
				},
				error : function(jqXHR, status, err) {

				}
			});

		});

		$("#btnSubmit").on("click", function() {

			/* if($(document.getElementById('choices0.answer1')).is(":checked")){
				alert("checked");
			}else{
				alert("unchecked");
			} */

			if ($(".icheck").is(":checked")) {
				return true;
			} else {
				alert("Answer CheckBox Not Selected.");
				return false;
			}
		});

		function getQuestionList() {
			var role = $("#user_role").val();
			var url = '/onlinetest/' + role + '/getQuestions';
			$.get(url, {

			}, function(responseJson) {
				var avaliableQuestions = [];
				$.each(responseJson.allQuestion, function(key, value) {
					//debugger;
					avaliableQuestions.push(value);
					$("#description").autocomplete({
						source : avaliableQuestions
					});
				});
			});
		}

		$("#description").on('keypress', function() {
			getQuestionList();
		});
		/* $(function() {
			getQuestionList();
			$("#questionInput").autocomplete({
				source : avaliableQuestions
			});
		}); */

	});

	
	function doCheck(checkboxElem) {
		  if (checkboxElem.checked) {
			  if(checkboxElem.id == "choices0.answer1"){
				  document.getElementById("choices1.answer1").setAttribute("disabled", true);
				  document.getElementById("choices2.answer1").setAttribute("disabled", true);
				  document.getElementById("choices3.answer1").setAttribute("disabled", true);
				  document.getElementById("choices4.answer1").setAttribute("disabled", true);
			  }else if(checkboxElem.id == "choices1.answer1"){
				  document.getElementById("choices0.answer1").setAttribute("disabled", true);
				  document.getElementById("choices2.answer1").setAttribute("disabled", true);
				  document.getElementById("choices3.answer1").setAttribute("disabled", true);
				  document.getElementById("choices4.answer1").setAttribute("disabled", true);
			  }else if(checkboxElem.id == "choices2.answer1"){
				  document.getElementById("choices0.answer1").setAttribute("disabled", true);
				  document.getElementById("choices1.answer1").setAttribute("disabled", true);
				  document.getElementById("choices3.answer1").setAttribute("disabled", true);
				  document.getElementById("choices4.answer1").setAttribute("disabled", true);
			  }else if(checkboxElem.id == "choices3.answer1"){
				  document.getElementById("choices1.answer1").setAttribute("disabled", true);
				  document.getElementById("choices2.answer1").setAttribute("disabled", true);
				  document.getElementById("choices0.answer1").setAttribute("disabled", true);
				  document.getElementById("choices4.answer1").setAttribute("disabled", true);
			  }else{
				  document.getElementById("choices1.answer1").setAttribute("disabled", true);
				  document.getElementById("choices2.answer1").setAttribute("disabled", true);
				  document.getElementById("choices3.answer1").setAttribute("disabled", true);
				  document.getElementById("choices0.answer1").setAttribute("disabled", true);
			  }
			  
		  } else {
			  document.getElementById("choices0.answer1").removeAttribute('disabled');
			  document.getElementById("choices1.answer1").removeAttribute('disabled');
			  document.getElementById("choices2.answer1").removeAttribute('disabled');
			  document.getElementById("choices3.answer1").removeAttribute('disabled');
			  document.getElementById("choices4.answer1").removeAttribute('disabled');
		  }
		}
</script>
<!-- <script type="text/javascript">
	$("#choices1.answer1")
	
</script> -->
