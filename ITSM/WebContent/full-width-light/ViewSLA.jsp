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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="referrer" content="always">
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

<!-- Favicon -->
<link rel="shortcut icon" href="favicon.ico">
<link rel="icon" href="favicon.ico" type="image/x-icon">

<!-- Bootstrap Dropify CSS -->
<link
	href="../vendors/bower_components/dropify/dist/css/dropify.min.css"
	rel="stylesheet" type="text/css" />
<!-- Custom CSS -->
<link href="dist/css/style.css" rel="stylesheet" type="text/css">
<link href="../vendors/bower_components/jquery-toast-plugin/dist/jquery.toast.min.css" rel="stylesheet" type="text/css">
<title>View Ticket</title>
</head>
<body>
	<%
		if (session.getAttribute("role") == null) {
			response.sendRedirect("Login.jsp");
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
     	SELECT * from ticket where sla = "<%=request.getParameter("sla") %>";
    </sql:query>
    <div hidden class="tst2 btn btn-warning" style="display: none;"></div>
	<div class="wrapper  theme-1-active pimary-color-blue">
		<jsp:include page="navbar.jsp"></jsp:include>

		<!-- Main Content -->
		<div class="page-wrapper">
			<div class="container-fluid">

				<!-- Title -->
				<div class="row heading-bg">
					<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
						<h5 class="txt-dark">View Ticket</h5>
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
											<table id="datable_1"
												class="table table-hover display  pb-30">
												<thead>
													<tr>
														<th>SLA</th>
														<th>EAR_NO#</th>
														<th>Hostname</th>
														<th>IP</th>
														<th>Status</th>
														<th>Start Time</th>
														<th>End Time</th>
														<th>Time left</th>
														<th>OVERSLA</th>
														<th class="text-nowrap">Action</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="row" items="${result.rows}">
														<tr>
															<td><c:set var="role" value="${row.sla}" /> <c:choose>
																	<c:when test="${role == 'Critical'}">
																		<span class="label label-danger" style="background-color: #800000;">
																	</c:when>
																	<c:when test="${role == 'Major'}">
																		<span class="label label-danger">
																	</c:when>
																	<c:when test="${role == 'Minor'}">
																		<span class="label" style="background-color: #FF4500;">
																	</c:when>
																	<c:otherwise>
																		<span class="label label-warning">
																	</c:otherwise>
																</c:choose> <c:out value="${row.SLA}" /> </span></td>
															<td><c:out value="${row.EAR_No}" /></td>
															<td><c:out value="${row.hostname}" /></td>
															<td><c:out value="${row.ip}" /></td>
															<td><c:set var="status" value="${row.status}" /> <c:choose>
																	<c:when test="${status == 'pending'}">
																		<span class="label label-danger">
																	</c:when>
																	<c:when test="${status == 'Waiting'}">
																		<span class="label label-warning">
																	</c:when>
																	<c:when test="${status == 'Success'}">
																		<span class="label label-success">
																	</c:when>
																	<c:otherwise>
																		<span class="label label-warning">
																	</c:otherwise>
																</c:choose> <c:out value="${row.status}" /> </span></td>
															<td><c:out value="${row.time}" /></td>
															<td><c:out value="${row.end_time}" /></td>
															<td></td>
															<td id="sla">
															</td>
															<td id="detail_1">

																<input id="wait${row.ticket_id}" type="hidden"
																value="${row.filepath}" name="wait">
																<sql:query dataSource="${ticket}" var="detail">
     															SELECT * from ticket_detail where ticket_id_fk = "${row.ticket_id}";
     															</sql:query>
																<c:choose>
																	<c:when test="${status == 'pending'}">
																		<a href="#myModalupload" class="pr-10 number"
																			data-target="#myModalupload" data-toggle="modal"
																			title="completed" id="${row.ticket_id}"> <i
																			class="zmdi zmdi-check"></i></a>
																	</c:when>

																	<c:when test="${status == 'Waiting'}">
																		<a href="#myModaluploaddefault${row.ticket_id}" class="pr-10 waiting"
																			data-target="#myModaluploaddefault${row.ticket_id}"
																			data-toggle="modal" title="completed"
																			id="${row.ticket_id}"> <i class="fa fa-edit (alias)"></i>
																			<%-- <c:forEach var="row1" items="${detail.rows}">
																<input id="e1detail${row.ticket_id}" type="hidden"
																value="${row1.EAR_No}">
																<input id="e2detail${row.ticket_id}" type="hidden"
																value="${row1.Projectcode}">
																<input id="e3detail${row.ticket_id}" type="hidden"
																value="${row1.ActivityReport}">
																<input id="e4detail${row.ticket_id}" type="hidden"
																value="${row1.Date}">
																<input id="e5detail${row.ticket_id}" type="hidden"
																value="${row1.Customer}">
																<input id="e6detail${row.ticket_id}" type="hidden"
																value="${row1.Location}">
																<input id="e7detail${row.ticket_id}" type="hidden"
																value="${row1.Contact_Person}">
																<input id="e8detail${row.ticket_id}" type="hidden"
																value="${row1.Tel}">
																<input id="e9detail${row.ticket_id}" type="hidden"
																value="${row1.Solution}">
																<input id="e10detail${row.ticket_id}" type="hidden"
																value="${row1.Status}">
																<input id="e11detail${row.ticket_id}" type="hidden"
																value="${row1.Configuration}"></c:forEach> --%>
																		</a>
																	</c:when>
																	<c:when test="${status == 'Success'}">
																		<a href="#myModaluploadview${row.ticket_id}" class="pr-10 numbers"
																			data-target="#myModaluploadview${row.ticket_id}" data-toggle="modal"
																			title="completed" id="${row.ticket_id}"> <i
																			class="fa fa-eye"></i>
																			<%-- <c:forEach var="row1" items="${detail.rows}">
																<input id="v1detail${row.ticket_id}" type="hidden"
																value="${row1.EAR_No}">
																<input id="v2detail${row.ticket_id}" type="hidden"
																value="${row1.Projectcode}">
																<input id="v3detail${row.ticket_id}" type="hidden"
																value="${row1.ActivityReport}">
																<input id="v4detail${row.ticket_id}" type="hidden"
																value="${row1.Date}">
																<input id="v5detail${row.ticket_id}" type="hidden"
																value="${row1.Customer}">
																<input id="v6detail${row.ticket_id}" type="hidden"
																value="${row1.Location}">
																<input id="v7detail${row.ticket_id}" type="hidden"
																value="${row1.Contact_Person}">
																<input id="v8detail${row.ticket_id}" type="hidden"
																value="${row1.Tel}">
																<input id="v9detail${row.ticket_id}" type="hidden"
																value="${row1.Solution}">
																<input id="v10detail${row.ticket_id}" type="hidden"
																value="${row1.Status}">
																<input id="v11detail${row.ticket_id}" type="hidden"
																value="${row1.Configuration}"></c:forEach> --%>
																			</a>
																	</c:when>
																	<c:otherwise>
																	</c:otherwise>
																</c:choose>
																<%
																	if ("Supervisor".equals(session.getAttribute("role"))) {
																%>										
																<a href="#myModalsmall" class="text-inverse delticket"
																title="Delete" data-target="#myModalsmall"
																data-toggle="modal" data-original-title="delete"
																id="${row.ticket_id}"> <i
																	class="zmdi zmdi-delete lable-danger"></i>
															</a>
															<%} %>
															</td>
														</tr>
														
														<!-- Modal Large for upload edit-->
				<div class="modal fade" id="myModaluploaddefault${row.ticket_id}" role="dialog">
					<form action="../EditTicketServlet" method="post"
						enctype="multipart/form-data">
						<div class="modal-dialog modal-lg">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">Edit Logfile</h4>
								</div>
								<div class="modal-body">
									<!-- Row -->
									<div class="row">
										<div class="col-sm-12 ol-md-12 col-xs-12">
											<div class="panel panel-default card-view">
												<input id="numberedit" type="hidden" value="${row.ticket_id}" name="numedit">
												<div class="panel-wrapper collapse in">
													<div class="panel-body">
														
														<h4 class="text-muted">Your Logfile</h4>
														<div class="mt-20">
															<sql:query dataSource="${ticket}" var="filep">
     															SELECT * from ticket_file where ticket_id = "${row.ticket_id}";
     														</sql:query>
     														<c:forEach var="rowf" items="${filep.rows}">
																----> <a href="${rowf.filepath}" download>${rowf.filename}</a><br>
															</c:forEach>
															<br><br>
															<label>Select File to Upload </label><br><br><input type="file" id="input-file-now-custom-1"
																name="upfile" multiple = "multiple" />
														</div>
														<br>
														<sql:query dataSource="${ticket}" var="detail">
     													SELECT * from ticket_detail where ticket_id_fk = "${row.ticket_id}";
     													</sql:query>
     													<c:forEach var="rowedit" items="${detail.rows}">
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
																	<label>Project Code</label> 
																		<select class="form-control"
																		name="projectcode" id="p_code" required>
																		<option hidden>
																				${rowedit.Projectcode}</option>
																		<option>SDA</option>
																		<option>VOICE</option>
																		<option>FIDS</option>
																		</select>
																</div>
																<div class="form-group">
																	<label>Customer</label> <input class="form-control"
																		name="customer" value="${rowedit.Customer}" id="cus" required>
																</div>
																<div class="form-group">
																	<label>Location</label> <select class="form-control"
																		name="location" id="loc">
																		<option hidden>
																				${rowedit.Location}</option>
																		<option>BKK(สนามบินสุวรรณภูมิ)</option>
																		<option>DMK(ดอนเมือง กรุงเทพ)</option>
																		<option>HKT(สนามบินภูเก็ต)</option>
																		<option>CNX(สนามบินเชียงใหม่)</option>
																		<option>CEI(สนามบินเชียงราย)</option>
																		<option>HDY(สนามบินหาดใหญ่)</option>
																	</select>
																</div>
																

															</div>

															<!-----------------------------------------------------------------------------...........................----.-->

															<!-- /.col-lg-6 (nested) -->
															<div class="col-lg-6">
																
																<div class="form-group">
																	<label>Date</label> <input type="date"
																		class="form-control" name="date" value="${rowedit.Date}" id="date"
																		required>
																</div>
																<div class="form-group">
																	<label>Tel</label> <input class="form-control"
																		name="tel" value="${rowedit.Tel}" id="tel" required>
																</div>
																<div class="form-group">
																	<label>Contact Person</label> <input
																		class="form-control" name="contactperson" value="${rowedit.Contact_Person}"
																		id="contact" required>
																</div>

															</div>
															<!-- /.col-lg-6 (nested) -->

															<div class="col-lg-12">
																<div class="form-group">
																	<label>Solution</label>
																	<textarea class="form-control" rows="3" name="solution"
																		id="solu" required>${rowedit.Solution}</textarea>
																</div>
															</div>
															<div class="col-lg-6">
																<div class="form-group">
																	<label>Status : </label> <label class="radio-inline">
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
																	<label>Configuration Change : </label> <label
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
														</c:forEach>
														<!-- /.row (nested) -->
													</div>
												</div>
											</div>
										</div>
										<!-- /Row -->

									</div>

									<div class="modal-footer">
										
										<input type="submit" class="btn btn-success btn-sm sub"
											name="buttoncheck" value="Submit">
										<button type="button" class="btn btn-default"
											data-dismiss="modal">Close</button>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
														
														
														
														<!-- Modal Large for upload view-->
				<div class="modal fade" id="myModaluploadview${row.ticket_id}" role="dialog">
					<form action="../EditTicket" method="post"
						enctype="multipart/form-data">
						<div class="modal-dialog modal-lg">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">View Ticket Detail</h4>
								</div>
								<div class="modal-body">
									<!-- Row -->
									
									<div class="row">
										<div class="col-sm-12 ol-md-12 col-xs-12">
											<div class="panel panel-default card-view">
												<!-- <div class="panel-heading">
													<div class="clearfix"></div>
												</div> -->
												<div class="panel-wrapper collapse in">
													<div class="panel-body">
														<h4 class="text-muted">Your Logfile</h4>
														<div class="mt-20">
															<sql:query dataSource="${ticket}" var="filepv">
     															SELECT * from ticket_file where ticket_id = "${row.ticket_id}";
     														</sql:query>
     														<c:forEach var="rowfv" items="${filepv.rows}">
																----> <a href="${rowfv.filepath}" download>${rowfv.filename}</a><br>
															</c:forEach>
															<br>
														<sql:query dataSource="${ticket}" var="detail">
     													SELECT * from ticket_detail where ticket_id_fk = "${row.ticket_id}";
     													</sql:query>
     													<c:forEach var="rowview" items="${detail.rows}">
								<div class="row">
									<div class="col-lg-12">
										<div class="panel">
											<div class="panel-heading" style="text-align:center;">Engineering Activity Report</div>
											<div class="panel-body">
												<div class="row">
													<div class="col-lg-12">
														<div class="form-group">
															<label>Activity Report</label> <br>
															<p class="form-control-static" id="v3">${rowview.ActivityReport}</p>
														</div>
														
													</div>
													<div class="col-lg-6">

														<div class="form-group">
															<label>Project Code</label>
															<p class="form-control-static" id="v2">${rowview.Projectcode}</p>
														</div>
														<div class="form-group">
															<label>Customer</label>
															<p class="form-control-static" id="v5">${rowview.Customer}</p>
														</div>
														<div class="form-group">
															<label>Location</label>
															<p class="form-control-static" id="v6">${rowview.Location}</p>
														</div>
														<div class="form-group">
															<label>Contact Person</label>
															<p class="form-control-static" id="v7">${rowview.Contact_Person}</p>
														</div>
														
													</div>
													<!-----------------------------------------------------------------------------...........................----.-->
													<!-- /.col-lg-6 (nested) -->
													<div class="col-lg-6">
													<div class="form-group">
															<label>EAR_NO</label>
															<p class="form-control-static" id="v4">${row.EAR_No}</p>
														</div>
														<div class="form-group">
															<label>Date</label>
															<p class="form-control-static" id="v4">${rowview.Date}</p>
														</div>
														<div class="form-group">
															<label>Tel</label>
															<p class="form-control-static" id="v8">${rowview.Tel}</p>
														</div>
														

													</div>
													<!-- /.col-lg-6 (nested) -->

													<div class="col-lg-12">
														<div class="form-group">
															<label>Solution</label>
															<p class="form-control-static" id="v9">${rowview.Solution}</p>
														</div>
													</div>
													<div class="col-lg-6">
														<div class="form-group">
															<label>Status</label>
															<p class="form-control-static" id="v10">${rowview.Status}</p>
														</div>
													</div>
													<div class="col-lg-6">
														<div class="form-group">
															<label>Configuration Change</label>
															<p class="form-control-static" id="v11">${rowview.Configuration}</p>
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
								</c:forEach>
								<!-- /.row -->
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- /Row -->

								</div>
								<div class="modal-footer">
									<input id="numberchange" type="hidden" value=""
										name="numchange">
									<!-- <button type="submit" class="btn btn-success btn-sm sub"
										name="buttoncheck" value="">Submit</button> -->
									<button type="button" class="btn btn-default"
										data-dismiss="modal">Close</button>
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
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- /Row -->


				<!-- Modal Large for upload-->
				<div class="modal fade" id="myModalupload" role="dialog">
					<form action="../SubmitTicketServlet" method="post"
						enctype="multipart/form-data">
						<div class="modal-dialog modal-lg">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">Upload Logfile</h4>
								</div>
								<div class="modal-body">
									<!-- Row -->
									<div class="row">
										<div class="col-sm-12 ol-md-12 col-xs-12">
											<div class="panel panel-default card-view">
												<input id="number" type="hidden" value="" name="num">
												<div class="panel-wrapper collapse in">
													<div class="panel-body">
														<div>
															<label>Select File to Upload </label><br><br><input type="file" id="input-file-now-custom-1"
																name="upfile" multiple = "multiple" required />
														</div>
														<br>
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
																	<label>Project Code</label>
																	<select class="form-control"
																		name="pcode" required>
																		<option>SDA</option>
																		<option>VOICE</option>
																		<option>FIDS</option>
																	</select>
																</div>
																<div class="form-group">
																	<label>Customer</label> <input class="form-control"
																		name="customer" value="AOT" required>
																</div>
																<div class="form-group">
																	<label>Location</label> <select class="form-control"
																		name="location">
																		<option>BKK(สนามบินสุวรรณภูมิ)</option>
																		<option>DMK(ดอนเมือง กรุงเทพ)</option>
																		<option>HKT(สนามบินภูเก็ต)</option>
																		<option>CNX(สนามบินเชียงใหม่)</option>
																		<option>CEI(สนามบินเชียงราย)</option>
																		<option>HDY(สนามบินหาดใหญ่)</option>
																	</select>
																</div>
																

															</div>

															<!-----------------------------------------------------------------------------...........................----.-->

															<!-- /.col-lg-6 (nested) -->
															<div class="col-lg-6">
																<!-- 																<div class="form-group">
																	<label>Incident No</label> <input class="form-control"
																		name="incidentno" value="" id="incidentno" required>
																</div> -->
																<div class="form-group">
																	<label>Date</label> <input type="date"
																		class="form-control" name="date" value=""
																		required>
																</div>
																<div class="form-group">
																	<label>Tel</label> <input class="form-control"
																		name="tel" value="" required>
																</div>
																<div class="form-group">
																	<label>Contact Person</label> <input
																		class="form-control" name="contactperson" value=""
																		required>
																</div>

															</div>
															<!-- /.col-lg-6 (nested) -->

															<div class="col-lg-12">
																<div class="form-group">
																	<label>Solution</label>
																	<textarea class="form-control" rows="3" name="solution"
																		required></textarea>
																</div>
															</div>
															<div class="col-lg-6">
																<div class="form-group">
																	<label>Status : </label> <label class="radio-inline">
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
																	<label>Configuration Change : </label> <label
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
														<br>
													</div>
												</div>
											</div>
										</div>
										
									</div>
									
									<!-- /Row -->

								</div>

								<div class="modal-footer">
									
									<!-- <button type="submit" class="btn btn-success btn-sm sub"
										name="buttoncheck" value="b2">Submit</button> -->
										<input type="submit" class="btn btn-success btn-sm sub"
										name="buttoncheck" value="Submit">
									<button type="button" class="btn btn-default"
										data-dismiss="modal">Close</button>
								</div>
							</div>
						</div>
					</form>
				</div>



				<input id="numberchange" type="hidden" value="" name="numchange">
				

				


				<!-- Modal Large for delete-->
				<div class="modal fade" id="myModalsmall" role="dialog">
					<form action="../EditTicket" method="post">
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
	<script src="../vendors/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
	<script src="../vendors/bower_components/jquery-toast-plugin/dist/jquery.toast.min.js"></script>

	<!-- Data table JavaScript -->
	<script
		src="../vendors/bower_components/datatables/media/js/jquery.dataTables.min.js"></script>
	<script src="dist/js/dataTables-data.js"></script>

	<!-- Bootstrap Daterangepicker JavaScript -->
	<script src="../vendors/bower_components/dropify/dist/js/dropify.min.js"></script>

	<!-- Form Flie Upload Data JavaScript -->
	<script src="dist/js/form-file-upload-data.js"></script>

	<!-- Slimscroll JavaScript -->
	<script src="dist/js/jquery.slimscroll.js"></script>


	<!-- Fancy Dropdown JS -->
	<script src="dist/js/dropdown-bootstrap-extended.js"></script>

	<!-- Switchery JavaScript -->
	<script
		src="../vendors/bower_components/switchery/dist/switchery.min.js"></script>

	<!-- Init JavaScript -->
	<script src="dist/js/toast-data.js"></script>
	<script src="dist/js/init.js"></script>

	<script type="text/javascript">
		$(document).ready(function() {
			$(".text-inverse.delticket").click(function() {
				var delticket = $(this).attr('id');
				$("#delete_row").val(delticket);
			});

			$(".pr-10.numbers").click(function() {
				var num = $(this).attr('id');
				$("#number").val(num);
				/* var path = $("#wait" + num).val();
				$("#show").attr("src", path); */
				
				
				/* var view_earno = $(this).attr('id');
				$("#view_row").val(view_earno);
			    // now get the values from the table
			    var v1 = $("#v1detail" + num).val();
			    var v2 = $("#v2detail" + num).val();
			    var v3 = $("#v3detail" + num).val();
			    var v4 = $("#v4detail" + num).val();
			    var v5 = $("#v5detail" + num).val();
			    var v6 = $("#v6detail" + num).val();
			    var v7 = $("#v7detail" + num).val();
			    var v8 = $("#v8detail" + num).val();
			    var v9 = $("#v9detail" + num).val();
			    var v10 = $("#v10detail" + num).val();
			    var v11 = $("#v11detail" + num).val();
			    // and set them in the modal:
			    $('p#v1').text(v1);
				$('p#v2').text(v2);
				$('p#v3').text(v3);
				$('p#v4').text(v4);
				$('p#v5').text(v5);
				$('p#v6').text(v6);
				$('p#v7').text(v7);
				$('#v8').text(v8);
				$('#v9').text(v9);
				$('#v10').text(v10);
				$('#v11').text(v11);
				$('p#v12').text(v12);
				$('p#v13').text(v13); */
			});

			$(".pr-10.number").click(function() {
				var num = $(this).attr('id');
				$("#number").val(num);
				
			});

			$(".pr-10.waiting").click(function() {
				var num = $(this).attr('id');
				$("#numberchange").val(num);
				/* var edit_earno = $(this).attr('id');
				$("#edit_row").val(edit_earno);
			    // now get the values from the table
			    var e1 = $("#e1detail" + num).val();
			    var e2 = $("#e2detail" + num).val();
			    var e3 = $("#e3detail" + num).val();
			    var e4 = $("#e4detail" + num).val();
			    var e5 = $("#e5detail" + num).val();
			    var e6 = $("#e6detail" + num).val();
			    var e7 = $("#e7detail" + num).val();
			    var e8 = $("#e8detail" + num).val();
			    var e9 = $("#e9detail" + num).val();
			    var e10 = $("#e10detail" + num).val();
			    var e11 = $("#e11detail" + num).val();
			    // and set them in the modal:
			    $('#ear').val(e1);
			    $('#p_code').val(e2);
			    
			    $('#ac').val(e3);
			    
			    $('#date').val(e4);
			    $('#cus').val(e5);
			    $('#loc').val(e6);
			    $('#contact').val(e7);
			    $('#tel').val(e8);
			    $('#solu').val(e9);
			    
			    $('#status').val(e10);
			    $('#config').val(e11); */
			});
			

		});
		
	</script>
	<script type="text/javascript">
		var table = document.getElementById("datable_1");
		var element = document.getElementById("cd");
		var x = setInterval(function() {
			for (var i = 1, row; row = table.rows[i]; i++) {
				//iterate through rows
				//rows would be accessed using the "row" variable assigned in the for loop
				var status = row.cells[4];
				var sla = row.cells[0];

				if (sla.innerHTML.includes('Critical')) {
					var plus = 30;
				} else if (sla.innerHTML.includes('Major')) {
					var plus = 4 * 60;
				} else if (sla.innerHTML.includes('Minor')) {
					var plus = 12 * 60;
				} else if (sla.innerHTML.includes('Warning')) {
					var plus = 7 * 24 * 60;
				}
				
				if (status.innerHTML.includes('pending')) {
					var ear = row.cells[1].innerHTML;
					var endDate = row.cells[5];
					countDownDate = new Date(endDate.innerHTML.replace(/-/g,
							"/"));
					var countDown = row.cells[7];
					var EndTime = row.cells[6];
					countDownDate = new Date(countDownDate
							.setMinutes(countDownDate.getMinutes() + plus))
							.getTime();
					// Update the count down every 1 second

					// Get todays date and time
					var now = new Date().getTime();

					/*             endDate.setMinutes(endDate.getMinutes()+30); */

					// Find the distance between now an the count down date
					var distance = Math.abs(countDownDate - now);

					// Time calculations for days, hours, minutes and seconds
					var days = Math.floor(distance / (1000 * 60 * 60 * 24));
					var hours = Math.floor((distance % (1000 * 60 * 60 * 24))
							/ (1000 * 60 * 60));
					var minutes = Math.floor((distance % (1000 * 60 * 60))
							/ (1000 * 60));
					var seconds = Math.floor((distance % (1000 * 60)) / 1000);
					
					
					// Display the result in the element
					if(days <= 0 && hours <= 0 && minutes == 7 && seconds >= 50 && countDownDate > now){
						var snd = new Audio('dist/sound/beep-06.mp3');
						snd.play();
						$(".tst2").change(function () {
							$.toast().reset('all');
							$("body").removeAttr('class');
							$.toast({
					            heading: 'Warning! EARNO '+ ear + " Over SLA in 10 minutes",
					            text: 'Please hurry to fix the case.',
					            position: 'top-right',
					            loaderBg:'#fec107',
					            icon: 'warning',
					            hideAfter: 2500, 
					            stack: 1
					        });
							return false;
						  }).change();
					}
					
					if(countDownDate < now){
						row.cells[8].innerHTML = '<span class="label label-danger"> Over SLA </span>';
						countDown.innerHTML = '<span class="label label-danger">' + days + "d " + hours + "h " + minutes
						+ "m " + seconds + "s " + '</span>';
					}else{
						row.cells[8].innerHTML = '<span class="label label-warning">In SLA</span>';
						countDown.innerHTML = '<span class="label label-warning">' + days + "d " + hours + "h " + minutes
						+ "m " + seconds + "s " + '</span>';
					}

					EndTime.innerHTML = ("xxxx-xx-xx xx:xx:xx");

					//If the count down is finished, write some text 
					/* if (distance < 0) {
					    clearInterval(x);
					    countDown.innerHTML = (days + "d " + hours + "h "
					            + minutes + "m " + seconds + "s ");
					} */
				} else {
					var endDate = row.cells[6];
					var sDate = row.cells[5];
					countDownDate = new Date(endDate.innerHTML.replace(/-/g,
							"/")).getTime();
					startDate = new Date(sDate.innerHTML.replace(/-/g, "/"));
					startDate = new Date(startDate.setMinutes(startDate
							.getMinutes()
							+ plus)).getTime();
					var countDown = row.cells[7];
					// Update the count down every 1 second
					
					// Find the distance between now an the count down date
					var distance = Math.abs(startDate - countDownDate);
					
					// Time calculations for days, hours, minutes and seconds
					var days = Math.floor(distance / (1000 * 60 * 60 * 24));
					var hours = Math.floor((distance % (1000 * 60 * 60 * 24))
							/ (1000 * 60 * 60));
					var minutes = Math.floor((distance % (1000 * 60 * 60))
							/ (1000 * 60));
					var seconds = Math.floor((distance % (1000 * 60)) / 1000);
					
					// Display the result in the element
					if(startDate < countDownDate){
						row.cells[8].innerHTML = '<span class="label label-danger"> Over SLA </span>';
						countDown.innerHTML = '<span class="label label-danger">' + days + "d " + hours + "h " + minutes
						+ "m " + seconds + "s " + '</span>';
					}else{
						row.cells[8].innerHTML = '<span class="label label-success">In SLA</span>';
						countDown.innerHTML = '<span class="label label-success">' + days + "d " + hours + "h " + minutes
						+ "m " + seconds + "s " + '</span>';
					}
					
				}

			}
		}, 1000);
		
		
	</script>
</body>

</html>