<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp" %>
<div class="portlet box blue col-md-4 col-md-offset-4">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-edit"></i>Enter Access Code:
		</div>
	</div>
	<div class="portlet-body">
		<div class="table-toolbar">
			<div class="row">
		  		<c:if test="${ not empty errormessage }">
		    		<h3 align="center">${errormessage}</h3>
		  		</c:if>
		 	</div>
	    	<form action="<c:url value="access"></c:url>" method="post">
                <fieldset>
		    	  	<div class="form-group">
						<input type="text" class ="form-control" name="access_code"/>
		    		</div>
		    		
		    		<div class="form-group" align="center">
		    			<button class="btn btn-lg btn-success btn-mini" type="submit">Submit</button>
		    		</div>
	    		</fieldset>
	      	</form>
	    </div>
	</div>
</div>