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
												<form action="EditUser.jsp" method="post"
													class="form-horizontal" role="form">
													<div class="form-body">
														<h6 class="txt-dark capitalize-font">
															<i class="zmdi zmdi-account mr-10"></i>Engineer's Info
														</h6>
														<hr class="light-grey-hr" />
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3">First
																		Name:</label>
																	<div class="col-md-9">
																		<p class="form-control-static"><%=session.getAttribute("FirstName")%></p>
																	</div>
																</div>
															</div>
															<!--/span-->
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3">Last
																		Name:</label>
																	<div class="col-md-9">
																		<p class="form-control-static"><%=session.getAttribute("LastName")%></p>
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
																		<p class="form-control-static"><%=session.getAttribute("NickName")%></p>
																	</div>
																</div>
															</div>
															<!--/span-->
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3">Tel:</label>
																	<div class="col-md-9">
																		<p class="form-control-static"><%=session.getAttribute("Tel")%></p>
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
																		<p class="form-control-static"><%=session.getAttribute("WorkShift")%></p>
																	</div>
																</div>
															</div>
															<!--/span-->
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3">Role:</label>
																	<div class="col-md-9">
																		<p class="form-control-static"><%=session.getAttribute("role")%></p>
																	</div>
																</div>
															</div>
															<!--/span-->
														</div>
														<!-- /Row -->

														<!-- <div class="seprator-block"></div>

														<h6 class="txt-dark capitalize-font">
															<i class="zmdi zmdi-account-box mr-10"></i>address
														</h6>
														<hr class="light-grey-hr" />
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3">Address:</label>
																	<div class="col-md-9">
																		<p class="form-control-static">827 Deerfield Ave.
																			Greenwood</p>
																	</div>
																</div>
															</div>
														</div>
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3">City:</label>
																	<div class="col-md-9">
																		<p class="form-control-static">Los Angeles</p>
																	</div>
																</div>
															</div>
															/span
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3">State:</label>
																	<div class="col-md-9">
																		<p class="form-control-static">California</p>
																	</div>
																</div>
															</div>
															/span
														</div>
														/Row
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3">Post
																		Code:</label>
																	<div class="col-md-9">
																		<p class="form-control-static">457890</p>
																	</div>
																</div>
															</div>
															/span
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3">Country:</label>
																	<div class="col-md-9">
																		<p class="form-control-static">USA</p>
																	</div>
																</div>
															</div>
															/span
														</div>
													</div> -->
														<div class="form-actions mt-10">
															<div class="row">
																<div class="col-md-6">
																	<div class="row">
																		<div class="col-md-offset-3 col-md-9">
																			<button type="submit"
																				class="btn btn-info btn-icon left-icon  mr-10">
																				<i class="zmdi zmdi-edit"></i> <span>Edit</span>
																			</button>
																		</div>
																	</div>
																</div>
																<div class="col-md-6"></div>
															</div>
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
