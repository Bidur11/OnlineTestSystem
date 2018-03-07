<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/include.jsp"%>
<div class="portlet box blue">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-edit"></i>Help
		</div>
	</div>
	<div class="portlet-body">
		<div class="table-toolbar">
			<!-- <div class="row">
				<div class="col-md-4">
					<div class="btn-group">
						<a href="allHelpLink" class="btn green"> CRUD Help</a>
					</div>
				</div>
			</div> -->
		</div>

		<table class="table table-striped table-hover table-bordered"
			id="sample_editable_1">
			<thead>
				<tr>
					<th>Help Links</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${imageFile}" var="file" varStatus="status">
					<tr>
						<td><a data-toggle="collapse" href="#${file.fileId}">${file.helpLink}</a>
							<div id="${file.fileId}" class="collapse">
							<c:forEach items="${file.helpDescriptions}" var="help">
								<div class="row help_links">
									<div class="col-md-8">
										<a class="image_link" href="<c:url value="/resources/images/${help.imgName}.png" />" data-lightbox="roadtrip">
											<img class="img-responsive img-thumbnail" src="<c:url value="/resources/images/${help.imgName}.png" />">
										</a> 
									</div>
									<div class="col-md-4 help_description">
										${help.description}
									</div>
								</div>
								</c:forEach>
							</div>
						</td>
					</tr>
				</c:forEach>
				
				
				
				
				
			</tbody>
		</table>

	</div>
</div>


<div></div>
