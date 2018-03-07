<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<c:if test="${not empty success}">
	<%@ include file="/WEB-INF/views/popUp.jsp"%>
</c:if>

<div class="content">
	<div class="portlet light">
		<c:if test="${not empty error}">
			<div class="alert alert-danger">
				<spring:message code="AbstractUserDetailsAuthenticationProvider.badCredentials"/><br />
			</div>
		</c:if>
		
		<div align="center" class="welcome_header">
			<h1>Welcome to Self Assessment System</h1>
			<p>Maharishi University of Management</p>
			<%-- <div class="logo" style="text-align: center;"><img src="<c:url value="/metronic/assets/MUM_Logo.png" />"></div> --%>
		</div>			
		
		<!-- Carousel
    ================================================== -->
	    <div id="myCarousel" class="carousel slide" data-ride="carousel">
	      <!-- Indicators -->
	      	<ol class="carousel-indicators">
	        	<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
	        	<li data-target="#myCarousel" data-slide-to="1"></li>
	        	<li data-target="#myCarousel" data-slide-to="2"></li>
	      	</ol>
	      	<div class="carousel-inner" role="listbox">
		        <div class="item active">
			          <img class="first-slide" src="<c:url value="/metronic/assets/pic0.png" />" alt="First slide">
			          <div class="container">
			            	<div class="carousel-caption">
			              	<h1>Welcome to Self Assessment System</h1>
			              		<p></p>
			              		
			            	</div>
			          </div>
		        </div>
		        <div class="item">
		          	<img class="second-slide" src="<c:url value="/metronic/assets/pic1.png" />" alt="Second slide">
		          	<div class="container">
		            	<div class="carousel-caption">
		              	<h1>We Are Creative</h1>
			              		<p></p>
			              		
		            	</div>
		          	</div>
		        </div>
		        <div class="item">
		          	<img class="third-slide" src="<c:url value="/metronic/assets/pic2.png" />" alt="Third slide">
		          	<div class="container">
		            	<div class="carousel-caption">
		              	<h1>We Are a Team</h1>
			              		<p></p>
			              		
		            	</div>
		          	</div>
		       </div>
		       <div class="item">
		          	<img class="third-slide" src="<c:url value="/metronic/assets/pic3.png" />" alt="Third slide">
		          	<div class="container">
		            	<div class="carousel-caption">
		              	<h1>We Love Coding</h1>
			              		<p></p>
			              		
		            	</div>
		          	</div>
		       </div>
		       <div class="item">
		          	<img class="third-slide" src="<c:url value="/metronic/assets/pic4.png" />" alt="Third slide">
		          	<div class="container">
		            	<div class="carousel-caption">
		              	<h1>Work Hard, Have Fun, No Drama</h1>
			              		<p></p>
			              		
		            	</div>
		          	</div>
		       </div>
	      </div>
	      <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
	        	<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
	        	<span class="sr-only">Previous</span>
	      </a>
	      <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
	        	<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
	        	<span class="sr-only">Next</span>
	      </a>
	   </div><!-- /.carousel -->		
	</div>
</div>
