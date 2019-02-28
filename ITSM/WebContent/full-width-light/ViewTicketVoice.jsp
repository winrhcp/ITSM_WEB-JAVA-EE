<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.mysql.jdbc.Connection"%>
<%@ page import="mysqlDB.MySQLConnection"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<!-- Favicon -->
	<link rel="shortcut icon" href="favicon.ico">
	<link rel="icon" href="favicon.ico" type="image/x-icon">
	<link rel="alternate" type="application/rss+xml" title="RSS 2.0"
		href="http://www.datatables.net/rss.xml">
	<!-- Jasny-bootstrap CSS -->
		<link href="../vendors/bower_components/jasny-bootstrap/dist/css/jasny-bootstrap.min.css" rel="stylesheet" type="text/css"/>
	<!-- Data table CSS -->
	<link
		href="../vendors/bower_components/datatables/media/css/jquery.dataTables.min.css"
		rel="stylesheet" type="text/css" />

	<!-- Custom CSS -->
	<link href="dist/css/style.css" rel="stylesheet" type="text/css">
	<title>View Ticket</title>
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
	<sql:setDataSource var="ticket" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://localhost:3306/ticket?useUnicode=yes&characterEncoding=UTF-8"
		user="root" password="root" />

	<sql:query dataSource="${ticket}" var="result">
     	SELECT * from ticket_voice;
     </sql:query>

	<div class="wrapper  theme-1-active pimary-color-blue">
		<jsp:include page="navbar.jsp"></jsp:include>
		
		<!-- Main Content -->
		<div class="page-wrapper">
			<div class="container-fluid">

				<!-- Title -->
				<div class="row heading-bg">
					<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
						<h5 class="txt-dark">View Ticket Voice</h5>
					</div>
				</div>
				<!-- /Title -->

				<!-- Row -->
				<div class="row">
					<div class="col-sm-12">
						<div class="panel panel-default card-view">
							<div class="panel-wrapper collapse in">
								<div class="panel-body">
									<div class="table-wrap">
										<div class="table-responsive">
											<table id="datable_1" class="table table-hover display  pb-30">
												<thead>
													<tr>
														<th>EAR NO</th>
														<th>Activity Report</th>
														<th>Project code</th>
														<th>Date&emsp;&emsp;&emsp;</th>
														<th>Location</th>
														<th>Contact Person</th>
														<th>Incident</th>
														<th>View</th>
														<th>Edit</th>
														<th>Delete</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="row" items="${result.rows}">
														<tr>
															<td><c:out value="${row.EAR_No}" /></td>
															<td><c:out value="${row.ActivityReport}" /></td>
															<td><c:out value="${row.Projectcode}" /></td>
															<td><c:out value="${row.Date}" /></td>
															<td><c:out value="${row.Location}" /></td>
															<td><c:out value="${row.Contact_Person}" /></td>
															<td><c:out value="${row.Incident}" /></td>
															<td><button type="button"
																	class="btn btn-primary btn-sm view"
																	data-target="#myModalview" data-toggle="modal"
																	id="${row.EAR_No}">
																	View
																	<div class="hidden v1">${row.EAR_No}</div>
																	<div class="hidden v2">${row.ActivityReport}</div>
																	<div class="hidden v3">${row.Date}</div>
																	<div class="hidden v4">${row.Customer}</div>
																	<div class="hidden v5">${row.Location}</div>
																	<div class="hidden v6">${row.Contact_Person}</div>
																	<div class="hidden v7">${row.Tel}</div>
																	<div class="hidden v8">${row.Incident}</div>
																	<div class="hidden v9">${row.Solution}</div>
																	<div class="hidden v10">${row.Status}</div>
																	<div class="hidden v11">${row.Configuration}</div>
																	<div class="hidden v12">${row.Projectcode}</div>
																	<div class="hidden v13">${row.Incidentno}</div>
																</button></td>
															<td><button type="button"
																	class="btn btn-warning btn-sm edit"
																	data-target="#myModaledit" data-toggle="modal"
																	id="${row.Number}">
																	Edit
																	<div class="hidden e1">${row.EAR_No}</div>
																	<div class="hidden e2">${row.ActivityReport}</div>
																	<div class="hidden e3">${row.Date}</div>
																	<div class="hidden e4">${row.Customer}</div>
																	<div class="hidden e5">${row.Location}</div>
																	<div class="hidden e6">${row.Contact_Person}</div>
																	<div class="hidden e7">${row.Tel}</div>
																	<div class="hidden e8">${row.Incident}</div>
																	<div class="hidden e9">${row.Solution}</div>
																	<div class="hidden e10">${row.Status}</div>
																	<div class="hidden e11">${row.Configuration}</div>
																	<div class="hidden e12">${row.Projectcode}</div>
																	<div class="hidden e13">${row.Incidentno}</div>
																	<div class="hidden e14">${row.Number}</div>
																</button></td>
															<td><button type="button"
																	class="btn btn-danger btn-sm del"
																	data-target="#myModalsmall" data-toggle="modal"
																	id="${row.EAR_No}">Delete</button></td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- /Row -->

				<!-- Modal Large for view-->
				<div class="modal fade" id="myModalview" role="dialog">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">

							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">&times;</button>
								<h4 class="modal-title">View Ticket</h4>
							</div>
							<div class="modal-body">
								<!-- /.row -->
								<div class="row">
									<div class="col-lg-12">
										<div class="panel panel-primary">
											<div class="panel-heading">Engineering Activity Report</div>
											<div class="panel-body">
												<div class="row">
													<div class="col-lg-12" style="text-align: center;">
														<div class="form-group">
															<label>Activity Report</label> <br>
															<p class="form-control-static" id="v2"></p>
														</div>
														
													</div>
													<div class="col-lg-6">

														<div class="form-group">
															<label>Project Code</label>
															<p class="form-control-static" id="v1"></p>
														</div>
														<div class="form-group">
															<label>Customer</label>
															<p class="form-control-static" id="v4"></p>
														</div>
														<div class="form-group">
															<label>Location</label>
															<p class="form-control-static" id="v5"></p>
														</div>
														<div class="form-group">
															<label>Contact Person</label>
															<p class="form-control-static" id="v6"></p>
														</div>



													</div>



													<!-----------------------------------------------------------------------------...........................----.-->



													<!-- /.col-lg-6 (nested) -->
													<div class="col-lg-6">
														<div class="form-group">
															<label>EAR No</label>
															<p class="form-control-static" id="v1"></p>
															<!-- <p class="help-block">Example block-level help text here.</p> -->
														</div>
														<div class="form-group">
															<label>Incident No</label>
															<p class="form-control-static" id="v13"></p>
														</div>
														<div class="form-group">
															<label>Date</label>
															<p class="form-control-static" id="v3"></p>
														</div>
														<div class="form-group">
															<label>Tel</label>
															<p class="form-control-static" id="v7"></p>
														</div>

													</div>
													<!-- /.col-lg-6 (nested) -->

													<div class="col-lg-12">
														<div class="form-group">
															<label>Incident</label>
															<p class="form-control-static" id="v8"></p>
														</div>
														<div class="form-group">
															<label>Solution</label>
															<p class="form-control-static" id="v9"></p>
														</div>
													</div>
													<div class="col-lg-6">
														<div class="form-group">
															<label>Status</label>
															<p class="form-control-static" id="v10"></p>
														</div>
													</div>
													<div class="col-lg-6">
														<div class="form-group">
															<label>Configuration Change</label>
															<p class="form-control-static" id="v11"></p>
														</div>
													</div>

												</div>
												<!-- /.row (nested) -->
											</div>
											<!-- /.panel-body -->
										</div>
										<!-- /.panel -->
									</div>
									<!-- /.col-lg-12 -->
								</div>
								<!-- /.row -->
							</div>
							<div class="modal-footer">
								<button type="submit" class="btn btn-primary btn-sm"
									name="buttoncheck" id="confirmearno_view" value="b3">print</button>
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Close</button>
							</div>

						</div>
					</div>
				</div>

				<!-- Modal Large for edit-->
				<div class="modal fade" id="myModaledit" role="dialog">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<form action="../EditTicketVoice" method="post">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">Edit Ticket</h4>
								</div>
								<div class="modal-body">
									<!-- /.row -->
									<div class="row">
										<div class="col-lg-12">
											<div class="panel panel-warning">
												<div class="panel-heading">Engineering Activity Report</div>
												<div class="panel-body">
													<div class="row">
														<div class="col-lg-12" style="text-align: center;">
															<div class="form-group">
																<label>Activity Report</label> <br> <label
																	class="radio-inline"> <input type="radio"
																	name="Activity_Report" id="optionsRadiosInline1"
																	value="CM" checked>CM
																</label> <label class="radio-inline"> <input
																	type="radio" name="Activity_Report"
																	id="optionsRadiosInline2" value="PM">PM
																</label> <label class="radio-inline"> <input
																	type="radio" name="Activity_Report"
																	id="optionsRadiosInline3" value="Installation">Installation
																</label>
															</div>
														</div>
														<div class="col-lg-6">

															<div class="form-group">
																<label>Project Code</label> <input class="form-control"
																	name="projectcode" value="" id="p_code" required>
															</div>
															<div class="form-group">
																<label>Customer</label> <input class="form-control"
																	name="customer" value="" id="cus" required>
															</div>
															<div class="form-group">
																<label>Location</label> <select class="form-control"
																	name="location" id="loc">
																	<option>BKK(สนามบินสุวรรณภูมิ)</option>
																	<option>DMK(ดอนเมือง กรุงเทพ)</option>
																	<option>HKT(สนามบินภูเก็ต)</option>
																	<option>CNX(สนามบินเชียงใหม่)</option>
																	<option>CEI(สนามบินเชียงราย)</option>
																	<option>HDY(สนามบินหาดใหญ่)</option>
																</select>
															</div>
															<div class="form-group">
																<label>Contact Person</label> <input
																	class="form-control" name="contactperson" value=""
																	id="contact" required>
															</div>




														</div>



														<!-----------------------------------------------------------------------------...........................----.-->



														<!-- /.col-lg-6 (nested) -->
														<div class="col-lg-6">
															<div class="form-group">
																<label>EAR No</label> <input class="form-control"
																	name="earno" value="" id="ear" required>
																<!-- <p class="help-block">Example block-level help text here.</p> -->
															</div>
															<div class="form-group">
																<label>Incident No</label> <input class="form-control"
																	name="incidentno" value="" id="incidentno" required>
															</div>
															<div class="form-group">
																<label>Date</label> <input type="date"
																	class="form-control" name="date" value="" id="date"
																	required>
															</div>
															<div class="form-group">
																<label>Tel</label> <input class="form-control"
																	name="tel" value="" id="tel" required>
															</div>

														</div>
														<!-- /.col-lg-6 (nested) -->

														<div class="col-lg-12">
															<div class="form-group">
																<label>Incident</label>
																<textarea class="form-control" rows="3" name="incident"
																	id="incident" required></textarea>
															</div>
															<div class="form-group">
																<label>Solution</label>
																<textarea class="form-control" rows="3" name="solution"
																	id="solu" required></textarea>
															</div>
														</div>
														<div class="col-lg-6">
															<div class="form-group">
																<label>Status</label> <label class="radio-inline">
																	<input type="radio" name="status"
																	id="optionsRadiosInline1" value="Complete" checked>Complete
																</label> <label class="radio-inline"> <input
																	type="radio" name="status" id="optionsRadiosInline2"
																	value="Incomplete">Incomplete
																</label>
															</div>
														</div>
														<div class="col-lg-6">
															<div class="form-group">
																<label>Configuration Change</label> <label
																	class="radio-inline"> <input type="radio"
																	name="configchange" id="optionsRadiosInline1"
																	value="Yes">Yes
																</label> <label class="radio-inline"> <input
																	type="radio" name="configchange"
																	id="optionsRadiosInline2" value="No" checked>No
																</label>
															</div>
														</div>

													</div>
													<!-- /.row (nested) -->
												</div>
												<!-- /.panel-body -->
											</div>
											<!-- /.panel -->
										</div>
										<!-- /.col-lg-12 -->
									</div>
									<!-- /.row -->
								</div>
								<div class="modal-footer">
									<input id="edit_row" type="hidden" value="" name="edit_earno">
									<button type="submit" class="btn btn-warning btn-sm"
										name="buttoncheck" id="confirmearno_edit" value="b2">Save
										Changes</button>
									<button type="button" class="btn btn-default"
										data-dismiss="modal">Close</button>
								</div>
							</form>
						</div>
					</div>
				</div>


				<!-- Modal Large for delete-->
				<div class="modal fade" id="myModalsmall" role="dialog">
					<form action="../EditTicketVoice" method="post">
						<div class="modal-dialog modal-lg">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">Delete</h4>
								</div>
								<div class="modal-body">
									<p>Are you sure you want to delete the selected row.</p>
								</div>
								<div class="modal-footer">
									<input id="delete_row" type="hidden" value="" name="del">
									<button type="submit" class="btn btn-danger btn-sm"
										name="buttoncheck" id="confirmearno_delete" value="b1">Yes</button>
									<button type="button" class="btn btn-default"
										data-dismiss="modal">No</button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>

			<!-- Footer -->
			<!-- 			<footer class="footer container-fluid pl-30 pr-30">
				<div class="row">
					<div class="col-sm-12">
						<p>2018 &copy; Snoopy. Pampered by Hencework</p>
					</div>
				</div>
			</footer> -->

		</div>
		<!-- /Main Content -->

	</div>
	<!-- /#wrapper -->

	<!-- JavaScript -->

	<!-- jQuery -->
	<script src="../vendors/bower_components/jquery/dist/jquery.min.js"></script>
	<script src="dist/js/my-jquery.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script
		src="../vendors/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

	<!-- Data table JavaScript -->
	<script
		src="../vendors/bower_components/datatables/media/js/jquery.dataTables.min.js"></script>
	<script src="dist/js/dataTables-data.js"></script>

	<!-- Slimscroll JavaScript -->
	<script src="dist/js/jquery.slimscroll.js"></script>


	<!-- Fancy Dropdown JS -->
	<script src="dist/js/dropdown-bootstrap-extended.js"></script>

	<!-- Init JavaScript -->
	<script src="dist/js/init.js"></script>

</body>

</html>