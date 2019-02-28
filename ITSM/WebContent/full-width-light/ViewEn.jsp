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
<link
	href="../vendors/bower_components/jasny-bootstrap/dist/css/jasny-bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<!-- Data table CSS -->
<link
	href="../vendors/bower_components/datatables/media/css/jquery.dataTables.min.css"
	rel="stylesheet" type="text/css" />

<!-- Custom CSS -->
<link href="dist/css/style.css" rel="stylesheet" type="text/css">
<title>Manage Engineer</title>
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
     	SELECT * from ait_engineer;
     </sql:query>

	<div class="wrapper  theme-1-active pimary-color-blue">
		<jsp:include page="navbar.jsp"></jsp:include>

		<!-- Main Content -->
		<div class="page-wrapper">
			<div class="container-fluid">

				<!-- Title -->
				<div class="row heading-bg">
					<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
						<h5 class="txt-dark">Engineer Management</h5>
					</div>
				</div>
				<!-- /Title -->

				<div class="row">

					<!-- Bordered Table -->
					<div class="col-sm-12">
						<div class="panel panel-default card-view">
							<div class="panel-heading">
								<div class="pull-left">
									<h6 class="panel-title txt-dark">Engineer</h6>
								</div>
								<div class="clearfix"></div>
							</div>
							<div class="panel-wrapper collapse in">
								<div class="panel-body">
									<div class="table-wrap">
										<div class="table-responsive">
											<table class="table table-hover table-bordered mb-0">
												<thead>
													<tr>
														<th>Code</th>
														<th>First Name</th>
														<th>Last Name</th>
														<th>NickName</th>
														<th>Tel</th>
														<th>Username</th>
														<th>WorkShift</th>
														<th>Role</th>
														<%
		if ("Supervisor".equals(session.getAttribute("role")) ) {
		%>
		
														<th class="text-nowrap">Action</th>
														<% 
		}
	%>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="row" items="${result.rows}">
														<tr>
															<td><c:out value="${row.code}" /></td>
															<td><c:out value="${row.FirstName}" /></td>
															<td><c:out value="${row.LastName}" /></td>
															<td><c:out value="${row.NickName}" /></td>
															<td><c:out value="${row.Tel}" /></td>
															<td><c:out value="${row.username}" /></td>
															<td><c:out value="${row.WorkShift}" /></td>
															<td>
															<c:set var = "role" value = "${row.role}"/>
      														<c:choose>
      															<c:when test="${role == 'Supervisor'}">
    																<span class="label label-danger">
    															</c:when>
    															<c:when test="${role == 'Senior NOC Team'}">
    																<span class="label label-danger">
    															</c:when>
    															<c:when test="${role == 'Senior Support Team'}">
    																<span class="label label-danger">
    															</c:when>
    															<c:otherwise>
        															<span class="label label-success">
    															</c:otherwise>
															</c:choose>
															<c:out value="${row.role}" />
															</span>
															</td>
															<%
		if ("Supervisor".equals(session.getAttribute("role")))  {
		%>
															<td class="text-nowrap"><a href="#myModalsedit_${row.code}" class="mr-25 edit"
																data-target="#myModalsedit_${row.code}" data-toggle="modal" data-original-title="Edit" id="${row.code}">
																
																 <i class="fa fa-pencil text-inverse m-r-10"></i>
															</a> <a href="#myModalsmall" data-target="#myModalsmall" data-toggle="modal"
																data-original-title="delete" id="${row.code}" class="delengineer"> 
																<i class="fa fa-close text-danger"></i>
															</a></td>
															<%
		}
		%>
														</tr>
														<!-- Modal Large for edit-->
				<div class="modal fade" id="myModalsedit_${row.code}" role="dialog">
					<form action="../EditViewEn" method="post" class="form-horizontal" role="form">
						<div class="modal-dialog modal-lg">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">Edit</h4>
								</div>
								<div class="modal-body">
									<div class="panel-wrapper collapse in">
								<div class="panel-body">
									<div class="row">
										<div class="col-md-12">
											<div class="form-wrap">
													<div class="form-body">
														<h6 class="txt-dark capitalize-font">
															<i class="zmdi zmdi-account mr-10"></i>Engineer's Info
														</h6>
														<hr class="light-grey-hr" />
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3 mt-10">Code:</label>
																	<div class="col-md-9">
																		<input type="text" class="form-control"
																			value="${row.code}"
																			name="code" required>
																	</div>
																</div>
															</div>
															<!--/span-->
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3 mt-10">Username:</label>
																	<div class="col-md-9">
																		<input type="text" class="form-control"
																			value="${row.username}"
																			name="username" required>
																	</div>
																</div>
															</div>
															<!--/span-->
														</div>
														<!-- /Row -->
														<br>
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3">First
																		Name:</label>
																	<div class="col-md-9">
																		<input type="text" class="form-control"
																			value="${row.FirstName}"
																			name="fname" required>
																	</div>
																</div>
															</div>
															<!--/span-->
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3">Last Name:</label>
																	<div class="col-md-9">
																		<input type="text" class="form-control"
																			value="${row.LastName}"
																			name="lname" required>
																	</div>
																</div>
															</div>
															<!--/span-->
														</div>
														<!-- /Row -->
														<br>
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3">Nick Name:</label>
																	<div class="col-md-9">
																		<input type="text" class="form-control"
																			value="${row.NickName}"
																			name="nickname" required>
																	</div>
																</div>
															</div>
															<!--/span-->
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3 mt-10">Tel:</label>
																	<div class="col-md-9">
																		<input type="text" class="form-control"
																			value="${row.Tel}" name="tel"
																			required>
																	</div>
																</div>
															</div>
															<!--/span-->
														</div>
														<!-- /Row -->
														<br>
														<div class="row">
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3 mt-10">WorkShift:</label>
																	<div class="col-md-9">
																		<select class="form-control" name="workshift" required>
																			<option hidden>
																				${row.WorkShift}</option>
																			<option>8x5</option>
																			<option>12x3</option>
																		</select>
																	</div>
																</div>
															</div>
															<!--/span-->
															<div class="col-md-6">
																<div class="form-group">
																	<label class="control-label col-md-3 mt-10">Role:</label>
																	<div class="col-md-9">
																		<select class="form-control" name="role" required>
																			<option hidden>${row.role}</option>
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
											</div>
										</div>
									</div>
								</div>
							</div>
								</div>
								<div class="modal-footer">
									<input id="edit_row" type="hidden" value="${row.code}" name="edit">
									<button type="submit" class="btn btn-warning btn-sm"
										name="buttoncheck" id="confirmearno_delete" value="b2">Save Changes</button>
									<button type="button" class="btn btn-default"
										data-dismiss="modal">No</button>
								</div>
							</div>
						</div>
						</div>
					</form>
				</div>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
									<br>
									<form action="AddEn.jsp" method="post">
										<button type="submit" class="btn btn-success ml-10"><i class="zmdi zmdi-plus"></i> <span>Add
										Engineer</span></button>
									</form>
								</div>
							</div>
						</div>
					</div>
					<!-- /Bordered Table -->
				</div>

				
				<!-- Modal Large for delete-->
				<div class="modal fade" id="myModalsmall" role="dialog">
					<form action="../EditViewEn" method="post">
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
	<script type="text/javascript">
	$(document).ready(function() {
		
		$(".delengineer").click(function (){
			var deleteen = $(this).attr('id');
	 		$("#delete_row").val(deleteen);
		});
		
		$(".mr-25.edit").click(function (){
			var editen = $(this).attr('id');
	 		$("#edit_row").val(editen);
		});
		
	});
	</script>
	<!-- Bootstrap Core JavaScript -->
	<script
		src="../vendors/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

	<!-- Data table JavaScript -->
	<script
		src="../vendors/bower_components/datatables/media/js/jquery.dataTables.min.js"></script>
	<script
		src="../vendors/bower_components/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
	<script
		src="../vendors/bower_components/datatables.net-buttons/js/buttons.flash.min.js"></script>
	<script src="../vendors/bower_components/jszip/dist/jszip.min.js"></script>
	<script src="../vendors/bower_components/pdfmake/build/pdfmake.min.js"></script>
	<script src="../vendors/bower_components/pdfmake/build/vfs_fonts.js"></script>

	<script
		src="../vendors/bower_components/datatables.net-buttons/js/buttons.html5.min.js"></script>
	<script
		src="../vendors/bower_components/datatables.net-buttons/js/buttons.print.min.js"></script>
	<script src="dist/js/export-table-data.js"></script>

	<!-- Slimscroll JavaScript -->
	<script src="dist/js/jquery.slimscroll.js"></script>


	<!-- Fancy Dropdown JS -->
	<script src="dist/js/dropdown-bootstrap-extended.js"></script>

	<!-- Init JavaScript -->
	<script src="dist/js/init.js"></script>

</body>

</html>