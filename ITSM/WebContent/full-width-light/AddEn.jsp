<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.mysql.jdbc.Connection"%>
<%@ page import="mysqlDB.MySQLConnection"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>Engineer Profile</title>
<meta name="description"
	content="Snoopy is a Dashboard & Admin Site Responsive Template by hencework." />
<meta name="keywords"
	content="admin, admin dashboard, admin template, cms, crm, Snoopy Admin, Snoopyadmin, premium admin templates, responsive admin, sass, panel, software, ui, visualization, web app, application" />
<meta name="author" content="hencework" />

<!-- Favicon -->
<link rel="shortcut icon" href="favicon.ico">
<link rel="icon" href="favicon.ico" type="image/x-icon">

<!-- vector map CSS -->
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

				<!-- Row -->
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-default card-view">
							<div class="panel-heading">
								<div class="pull-left">
									<h6 class="panel-title txt-dark">Engineer Profile</h6>
								</div>
								<div class="clearfix"></div>
							</div>
							<div class="panel-wrapper collapse in">
								<div class="panel-body">
									<div class="row">
										<div class="col-md-12">
											<div class="form-wrap">
												<form action="../AddUser" method="post"
													class="form-horizontal" role="form">
													<div class="form-body">
														<h6 class="txt-dark capitalize-font">
															<i class="zmdi zmdi-account mr-10"></i>Engineer's Info
														</h6>
														<hr class="light-grey-hr" />
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3">Code:</label>
																	<div class="col-md-9">
																		<input type="text" class="form-control"
																			name="code" required>
																	</div>
																</div>
															</div>
															<!--/span-->
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3">Username:</label>
																	<div class="col-md-9">
																		<input type="text" class="form-control"
																			name="username" required>
																	</div>
																</div>
															</div>
															<!--/span-->
														</div>
														<!-- /Row -->
														
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3">Password:</label>
																	<div class="col-md-9">
																		<input type="password" class="form-control"
																			name="pass" id="password" required>
																	</div>
																</div>
															</div>
															<!--/span-->
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3">Retry Password:</label>
																	<div class="col-md-9">
																		<input type="password" class="form-control"
																			name="passretry" id="confirmpassword" required>
																	</div>
																</div>
															</div>
															<!--/span-->
														</div>
														<!-- /Row -->
														
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3">First
																		Name:</label>
																	<div class="col-md-9">
																		<input type="text" class="form-control"
																			name="fname" required>
																	</div>
																</div>
															</div>
															<!--/span-->
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3">Last
																		Name:</label>
																	<div class="col-md-9">
																		<input type="text" class="form-control"
																			name="lname" required>
																	</div>
																</div>
															</div>
															<!--/span-->
														</div>
														<!-- /Row -->
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3">Nick
																		Name:</label>
																	<div class="col-md-9">
																		<input type="text" class="form-control"
																			name="nickname" required>
																	</div>
																</div>
															</div>
															<!--/span-->
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3">Tel:</label>
																	<div class="col-md-9">
																		<input type="text" class="form-control"
																		name="tel" required>
																	</div>
																</div>
															</div>
															<!--/span-->
														</div>
														<!-- /Row -->
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3">WorkShift:</label>
																	<div class="col-md-9">
																		<select
																			class="form-control" name="workshift" required>
																			<option value="" selected disabled hidden>Choose WorkShift Here...</option>
																			<option>8x5</option>
																			<option>12x3</option>
																		</select>
																	</div>
																</div>
															</div>
															<!--/span-->
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3">Role:</label>
																	<div class="col-md-9">
																		<select
																			class="form-control" name="role" required>
																			<option value="" selected disabled hidden>Choose Role Here...</option>
																			<option>Supervisor</option>
																			<option>Senior NOC Team</option>
																			<option>Senior Support Team</option>
																			<option>NOC Team</option>
																			<option>Support Team</option>
																		</select>
																	</div>
																</div>
															</div>
															<!--/span-->
														</div>
														<!-- /Row -->

														
														<div class="form-actions mt-10">
															<div class="row">
																<div class="col-md-6">
																	<div class="row">
																		<div class="col-md-offset-3 col-md-9">
																			<button type="submit"
																				class="btn btn-success btn-icon left-icon  mr-10">
																				<i class="zmdi zmdi-plus"></i> <span>Add
																					Engineer</span>
																			</button>
																		</div>
																	</div>
																</div>
																<div class="col-md-6"></div>
															</div>
														</div>
												</form>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- /Row -->

			</div>

		</div>
		<!-- /Main Content -->

	</div>
	<!-- /#wrapper -->
	
	<!-- JavaScript -->
	<script type="text/javascript">
	var password = document.getElementById("password")
	  , confirm_password = document.getElementById("confirmpassword");

	function validatePassword(){
	  if(password.value != confirm_password.value) {
	    confirm_password.setCustomValidity("Passwords Don't Match");
	  } else {
	    confirm_password.setCustomValidity('');
	  }
	}

	password.onchange = validatePassword;
	confirm_password.onkeyup = validatePassword;
	</script>
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

	<!-- Owl JavaScript -->
	<script
		src="../vendors/bower_components/owl.carousel/dist/owl.carousel.min.js"></script>

	<!-- Switchery JavaScript -->
	<script
		src="../vendors/bower_components/switchery/dist/switchery.min.js"></script>

	<!-- Init JavaScript -->
	<script src="dist/js/init.js"></script>
</body>
</html>
