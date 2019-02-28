<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
						<h5 class="txt-dark">Search Device</h5>
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
									<h6 class="panel-title txt-dark">Find Switch</h6>
								</div>
								<div class="clearfix"></div>
							</div>
							<div class="panel-wrapper collapse in">
								<div class="panel-body">
									<div class="form-wrap">
										<form action="../FindASServlet" method="post">
											<div class="col-md-12 col-sm-12 col-xs-12 form-group">
												<label class="control-label mb-10">IP Client</label> <input
													type="text" class="form-control" name="ipclient"
													placeholder="IP Client" required>
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