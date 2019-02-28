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

				<!-- Row -->
				<div class="row">
					<div class="col-md-12">
						<div class="panel panel-default card-view">
							<div class="panel-heading">
								<div class="pull-left">
									<h6 class="panel-title txt-dark">View Device</h6>
								</div>
								<div class="clearfix"></div>
							</div>
							<div class="panel-wrapper collapse in">
								<div class="panel-body">
									<div class="row">
										<div class="col-md-12">
											<div class="form-wrap">
												<form class="form-horizontal" role="form">
													<div class="form-body">
														<h6 class="txt-dark capitalize-font">
															<i class="zmdi zmdi-search mr-10"></i>View Device
														</h6>
														<hr class="light-grey-hr" />
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-6">Distributed Switch Name :</label>
																	<div class="col-md-6">
																		<p class="form-control-static"><%=(String) session.getAttribute("dsname")%></p>
																	</div>
																</div>
															</div>
															<!--/span-->
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-6">IP Distributed Switch :</label>
																	<div class="col-md-6">
																		<p class="form-control-static"><%=(String) session.getAttribute("ipds")%></p>
																	</div>
																</div>
															</div>
															<!--/span-->
														</div>
														<!-- /Row -->
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-6">Port Distributed Switch
																		To Access Switch :</label>
																	<div class="col-md-6">
																		<p class="form-control-static"><%=(String) session.getAttribute("port_ds_as")%></p>
																	</div>
																</div>
															</div>
															<!--/span-->
															<div class="col-md-6"></div>
															<!--/span-->
														</div>
														<hr>
														<!-- /Row -->
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-6">Access Switch Name :</label>
																	<div class="col-md-6">
																		<p class="form-control-static"><%=(String) session.getAttribute("asname")%></p>
																	</div>
																</div>
															</div>
															<!--/span-->
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-6">IP Access Switch :</label>
																	<div class="col-md-6">
																		<p class="form-control-static"><%=(String) session.getAttribute("ipas")%></p>
																	</div>
																</div>
															</div>
															<!--/span-->
														</div>
														<!-- /Row -->

														<!-- /Row -->
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-6">Port Access Switch
																		To Client :</label>
																	<div class="col-md-6">
																		<p class="form-control-static"><%=(String) session.getAttribute("port_as_client")%></p>
																	</div>
																</div>
															</div>
															<!--/span-->
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-6">Vlan Number:</label>
																	<div class="col-md-6">
																		<p class="form-control-static"><%=(String) session.getAttribute("vlclient")%></p>
																	</div>
																</div>
															</div>
															<!--/span-->
														</div>
														<!-- /Row -->

														<!-- /Row -->
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-6">MAC
																		Address Client :</label>
																	<div class="col-md-6">
																		<p class="form-control-static"><%=(String) session.getAttribute("macclient")%></p>
																	</div>
																</div>
															</div>
															<!--/span-->
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-6">Vlan Name
																		:</label>
																	<div class="col-md-6">
																		<p class="form-control-static"><%=(String) session.getAttribute("vlname")%></p>
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



	<!-- Init JavaScript -->
	<script src="dist/js/init.js"></script>
</body>
</html>