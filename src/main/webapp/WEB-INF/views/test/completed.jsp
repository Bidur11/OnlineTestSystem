<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<div id="snowspawner"></div>
	
<div class="content">
	<div class="portlet light">
		<div align="center" class="completed_header">
			<h1>You have Succesfully Completed the Test</h1>
			<p>Maharishi University of Management</p>
			<%-- <div class="logo" style="text-align: center;"><img src="<c:url value="/metronic/assets/MUM_Logo.png" />"></div> --%>
		</div>
		<div class="logo completed_body" style="text-align: center;">
			<img src="<c:url value="/metronic/assets/MUM_Logo.png" />">
		</div>
	</div>
	<script type="text/javascript" src="http://www.jqueryscript.net/demo/jQuery-Plugin-For-Custom-Snowfall-Effect-letItSnow-js/src/letItSnow.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			window.history.pushState(null, "", window.location.href);
			window.onpopstate = function() {
				window.history.pushState(null, "", window.location.href);
			};
			
			$('#snowspawner').letItSnow();
		});
	</script>

</div>
