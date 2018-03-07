<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<div class="portlet box blue">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-edit"></i>Select Categories
		</div>
	</div>
	<div class="portlet-body">
		<div class="row">
			<div class="col-md-12">
				<h4 class="category_select_heading">Please select 3 to 4 sub categories</h4>
				<form:form modelAttribute="categoryDto" method="POST"
			action="setcategories/">
					<c:forEach items="${categoryDto.categories}" var="cats">
						<div class="row">
							<div class="col-md-2">${cats.name}</div>
							<div class="col-md-10">
								<c:forEach items="${cats.subcategories}" var="subcats">
									<c:if test="${subcats.enabled}">
										<form:checkbox name="selectedSubCategories"
											path="selectedSubCategories" value="${subcats.id}" />
										${subcats.name}<br />
									</c:if>
								</c:forEach>
							</div>
						</div>						
		
						<hr />		
					</c:forEach>
					<button class="btn btn-success btnSubmitCat" style="display: none;"
						type="submit">Submit</button>
				</form:form>
			</div>
		</div>
	</div>
</div>

<div class="content">
	<div class="portlet light">
		
	</div>
</div>
<script>
	jQuery(document).ready(function() {
		$("input[type='checkbox']").change(function() {
			var count = $("[type='checkbox']:checked").length;
			if (count >= 3 && count <= 4) {
				$(".btnSubmitCat").show();
			} else {
				$(".btnSubmitCat").hide();
			}
		});
	});
</script>