<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>ITSM Portal</title>
<!-- Favicon -->
<link rel="shortcut icon" href="favicon.ico">
<link rel="icon" href="favicon.ico" type="image/x-icon">


<!-- Jasny-bootstrap CSS -->
<link
	href="../vendors/bower_components/jasny-bootstrap/dist/css/jasny-bootstrap.min.css"
	rel="stylesheet" type="text/css" />

<!-- Custom CSS -->
<link href="dist/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%
		if (session.getAttribute("role") == null) {
			response.sendRedirect("Login.jsp");
			System.out.println(session.getAttribute("role"));
		}
	%>
	<!--Preloader-->
	<div class="preloader-it">
		<div class="la-anim-1"></div>
	</div>
	<!--/Preloader-->

	<div class="wrapper  theme-1-active pimary-color-blue">
		<jsp:include page="navbar.jsp"></jsp:include>

		<!-- Main Content -->
		<div class="page-wrapper">
			<div class="container-fluid">

				<!-- Title -->
				<div class="row heading-bg">
					<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
						<h5 class="txt-dark">Ticket Voice</h5>
					</div>
					<!-- 						Breadcrumb
						<div class="col-lg-9 col-sm-8 col-md-8 col-xs-12">
						  <ol class="breadcrumb">
							<li><a href="index.html">Dashboard</a></li>
							<li><a href="#"><span>form</span></a></li>
							<li class="active"><span>form-element</span></li>
						  </ol>
						</div>
						/Breadcrumb -->
				</div>
				<!-- /Title -->

				<!-- Row -->
				<div class="row">
					<div class="col-sm-12">
						<div class="panel panel-default card-view">
							<div class="panel-heading">
								<div class="pull-left">
									<h6 class="panel-title txt-dark">Engineering Activity
										Report</h6>
								</div>
								<div class="clearfix"></div>
							</div>
							<div class="panel-wrapper collapse in">
								<div class="panel-body">
									<div class="form-wrap">
										<form action="../insertTicketVoiceServlet" method="post">
											<div class="form-group mb-30" style="text-align: center;">
												<label class="control-label mb-10 text-left">Activity
													Report</label><br> <input type="radio" name="Activity_Report"
													id="radio1" value="CM" checked> <label for="radio1">
													CM </label> <input type="radio" name="Activity_Report" id="radio2"
													value="PM"> <label for="radio2"> PM </label> <input
													type="radio" name="Activity_Report" id="radio3"
													value="Installation"> <label for="radio3">
													Installation </label>
											</div>

											<div class="col-md-6 col-sm-12 col-xs-12 form-group">
												<label class="control-label mb-10">Project Code</label> <input
													type="text" class="form-control" name="projectcode"
													required>
											</div>
											<div class="col-md-6 col-sm-12 col-xs-12 form-group">
												<label class="control-label mb-10">EAR No</label> <input
													type="text" class="form-control" name="earno" required>
											</div>
											<div class="col-md-6 col-sm-12 col-xs-12 form-group">
												<label class="control-label mb-10">Customer</label> <input
													type="text" class="form-control" name="customer" required>
											</div>
											<div class="col-md-6 col-sm-12 col-xs-12 form-group">
												<label class="control-label mb-10">Incident No</label> <input
													type="text" class="form-control" name="incidentno" required>
											</div>
											<div class="col-md-6 col-sm-12 col-xs-12 form-group">
												<label class="control-label mb-10">Location</label> <select
													class="form-control" name="location">
													<option>BKK(สนามบินสุวรรณภูมิ)</option>
													<option>DMK(ดอนเมือง กรุงเทพ)</option>
													<option>HKT(สนามบินภูเก็ต)</option>
													<option>CNX(สนามบินเชียงใหม่)</option>
													<option>CEI(สนามบินเชียงราย)</option>
													<option>HDY(สนามบินหาดใหญ่)</option>
												</select>
											</div>
											<div class="col-md-6 col-sm-12 col-xs-12 form-group">
												<label class="control-label mb-10">Date</label> <input
													type="date" class="form-control" name="date" required>
											</div>
											<div class="col-md-6 col-sm-12 col-xs-12 form-group">
												<label class="control-label mb-10">Contact Person</label> <input
													type="text" class="form-control" name="contactperson"
													required>
											</div>
											<div class="col-md-6 col-sm-12 col-xs-12 form-group">
												<label class="control-label mb-10">Tel</label> <input
													type="text" class="form-control" name="tel" required>
											</div>


											<div class="col-md-12 col-sm-12 col-xs-12 form-group">
												<label class="control-label mb-10 text-left">Incident</label>
												<textarea class="form-control" rows="6" name="incident"></textarea>
											</div>
											<div class="col-md-12 col-sm-12 col-xs-12 form-group">
												<label class="control-label mb-10 text-left">Solution</label>
												<textarea class="form-control" rows="6" name="solution"></textarea>
											</div>

											<div class="col-md-6 col-sm-12 col-xs-12 form-group">
												<label class="control-label mb-10 text-left">Status</label><br>
												<input type="radio" name="status" id="radio4"
													value="Complete" checked> <label for="radio4">
													Complete </label> <input type="radio" name="status" id="radio5"
													value="Incomplete"> <label for="radio5">
													Incomplete </label>
											</div>
											<div class="col-md-6 col-sm-12 col-xs-12 form-group">
												<label class="control-label mb-10 text-left">Configuration
													Change</label><br> <input type="radio" name="configchange"
													id="radio6" value="Yes"> <label for="radio6">
													Yes </label> <input type="radio" name="configchange" id="radio7"
													value="No" checked> <label for="radio7"> No
												</label>
											</div>
											<br>
											<div class="form-group ml-15">
												<button type="submit" class="btn btn-success">
													<span class="btn-text">Submit</span>
												</button>
												<button type="reset" class="btn btn-default">Reset</button>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- /Row -->

			</div>

			<!-- 				Footer
				<footer class="footer container-fluid pl-30 pr-30">
					<div class="row">
						<div class="col-sm-12">
							<p>2018 &copy; Snoopy. Pampered by Hencework</p>
						</div>
					</div>
				</footer>
				/Footer -->

		</div>
		<!-- /Main Content -->
	</div>
	<!-- /#wrapper -->

	<!-- JavaScript -->

	<!-- jQuery -->
	<script src="../vendors/bower_components/jquery/dist/jquery.min.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script
		src="../vendors/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

	<script
		src="../vendors/bower_components/jasny-bootstrap/dist/js/jasny-bootstrap.min.js"></script>

	<!-- Slimscroll JavaScript -->
	<script src="dist/js/jquery.slimscroll.js"></script>

	<!-- Fancy Dropdown JS -->
	<script src="dist/js/dropdown-bootstrap-extended.js"></script>



	<!-- Init JavaScript -->
	<script src="dist/js/init.js"></script>
</body>
</html>