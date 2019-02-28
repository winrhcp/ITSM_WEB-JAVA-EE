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
     	SELECT * from ticket where status = "Waiting";
     </sql:query>
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
														<th>Hostname</th>
														<th>IP</th>
														<th>Status</th>
														<th>Start Time</th>
														<th>End Time</th>
														<th>Time left</th>
														<th class="text-nowrap">Action</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="row" items="${result.rows}">
														<tr>
															<td><c:set var="role" value="${row.sla}" /> <c:choose>
																	<c:when test="${role == 'Critical'}">
																		<span class="label label-danger">
																	</c:when>
																	<c:when test="${role == 'Major'}">
																		<span class="label label-danger">
																	</c:when>
																	<c:when test="${role == 'Minor'}">
																		<span class="label label-warning">
																	</c:when>
																	<c:otherwise>
																		<span class="label label-warning">
																	</c:otherwise>
																</c:choose> <c:out value="${row.SLA}" /> </span></td>
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
															<td><%-- <input id="wait${row.ticket_id}" type="hidden"
																value="${row.filepath}" name="wait"> --%> 
																<a
																href="#myModalupload${row.ticket_id}" class="pr-10 waiting"
																data-target="#myModalupload${row.ticket_id}" data-toggle="modal"
																title="completed" id="${row.ticket_id}"> <i
																	class="zmdi zmdi-check"></i></a> <a href="#myModalsmall"
																class="text-inverse delticket" title="Delete"
																data-target="#myModalsmall" data-toggle="modal"
																data-original-title="delete" id="${row.ticket_id}">
																	<i class="fa fa-close lable-danger"></i>
															</a></td>
														</tr>
														<!-- Modal Large for upload-->
														<div class="modal fade" id="myModalupload${row.ticket_id}" role="dialog">
															<form action="../EditTicket" method="post"
																enctype="multipart/form-data">
																<div class="modal-dialog modal-lg">
																	<div class="modal-content">
																		<div class="modal-header">
																			<button type="button" class="close"
																				data-dismiss="modal">&times;</button>
																			<h4 class="modal-title">Logfile</h4>
																		</div>
																		<div class="modal-body">
																			<!-- Row -->
																			<div class="row">
																				<div class="col-sm-12 ol-md-12 col-xs-12">
																					<div class="panel panel-default card-view">
																						<div class="panel-heading">
																							<div class="pull-left">
																								<h6 class="panel-title txt-dark">Approve
																									Logfile.</h6>
																							</div>
																							<div class="clearfix"></div>
																						</div>
																						<div class="panel-wrapper collapse in">
																							<div class="panel-body">
																								<h4 class="text-muted">Your Logfile</h4>
																								<div class="mt-20">
																									<sql:query dataSource="${ticket}" var="filepv">
     																									SELECT * from ticket_file where ticket_id = "${row.ticket_id}";
     																								</sql:query>
																									<c:forEach var="rowfv" items="${filepv.rows}">
																									----> <a href="${rowfv.filepath}" download>${rowfv.filename}</a>
																									<br>
																									</c:forEach>
																									<br>
																									<div class="mt-10">
																										<h4 class="text-muted">Approve Date And Time</h4>
																										<p>Start Time --> ${row.time }</p>
																										<p>End Time   ---> ${row.end_time }</p>
																										<input type="hidden" value="${row.end_time }" id="etime${row.ticket_id}">
																										<!-- <input type="date" name="end_date" value=""> -->
																										<input type="datetime-local" step="2" name="end_time" value="" id="result_e${row.ticket_id}">
																									</div>
																								</div>
																							</div>
																						</div>
																					</div>
																				</div>
																				<!-- /Row -->

																			</div>

																			<div class="modal-footer">
																				<input id="number" type="hidden" value="${row.ticket_id}" name="num">
																				<button type="submit"
																					class="btn btn-success btn-sm sub"
																					name="buttoncheck" value="b3">Submit</button>
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
				<input type="hidden" value="" id="ticketid">
				
				
				<!-- Modal Large for delete-->
				<div class="modal fade" id="myModalsmall" role="dialog">
					<form action="../EditTicket" method="post">
						<div class="modal-dialog modal-lg">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">Reject</h4>
								</div>
								<div class="modal-body">
									<p>Are you sure you want to reject the selected row.</p>
								</div>
								<div class="modal-footer">
									<input id="delete_row" type="hidden" value="" name="del">
									<button type="submit" class="btn btn-danger btn-sm"
										name="buttoncheck" id="confirmearno_delete" value="b5">Yes</button>
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

	<!-- Bootstrap Daterangepicker JavaScript -->
	<script
		src="../vendors/bower_components/dropify/dist/js/dropify.min.js"></script>

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
	<script src="dist/js/init.js"></script>

	<script type="text/javascript">
		
		
		$(document).ready(function() {
			$(".text-inverse.delticket").click(function() {
				var delticket = $(this).attr('id');
				$("#delete_row").val(delticket);
			});
			
			
			$(".pr-10.waiting").click(function() {
				var ticketid = $(this).attr('id');
				$("#ticketid").val(ticketid);
				var etime = "#etime" + ticketid;
				var endtime = $(etime).val();
				var endtime = endtime.split(" ");
				console.log(endtime[0] + "T" + endtime[1].split(".")[0]);
				$("#result_e" + ticketid).val(endtime[0] + "T" + endtime[1].split(".")[0]);
			});
		});
	</script>
	<script type="text/javascript">
		function test(element) {
			var newTab = window.open();
			setTimeout(function() {
				newTab.document.body.innerHTML = element.innerHTML;
			}, 500);
			return false;
		}

		var table = document.getElementById("datable_1");
		var x = setInterval(function() {
			for (var i = 1, row; row = table.rows[i]; i++) {
				//iterate through rows
				//rows would be accessed using the "row" variable assigned in the for loop
				var status = row.cells[3];
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
					var endDate = row.cells[4];
					countDownDate = new Date(endDate.innerHTML.replace(/-/g,
							"/"));
					var countDown = row.cells[6];
					var EndTime = row.cells[5];
					countDownDate = new Date(countDownDate
							.setMinutes(countDownDate.getMinutes() + plus))
							.getTime();
					// Update the count down every 1 second

					// Get todays date and time
					var now = new Date().getTime();

					/*             endDate.setMinutes(endDate.getMinutes()+30); */

					// Find the distance between now an the count down date
					var distance = countDownDate - now;

					// Time calculations for days, hours, minutes and seconds
					var days = Math.floor(distance / (1000 * 60 * 60 * 24));
					var hours = Math.floor((distance % (1000 * 60 * 60 * 24))
							/ (1000 * 60 * 60));
					var minutes = Math.floor((distance % (1000 * 60 * 60))
							/ (1000 * 60));
					var seconds = Math.floor((distance % (1000 * 60)) / 1000);

					// Display the result in the element
					countDown.innerHTML = (days + "d " + hours + "h " + minutes
							+ "m " + seconds + "s ");

					EndTime.innerHTML = ("xxxx-xx-xx xx:xx:xx");

					//If the count down is finished, write some text 
					/* if (distance < 0) {
					    clearInterval(x);
					    countDown.innerHTML = (days + "d " + hours + "h "
					            + minutes + "m " + seconds + "s ");
					} */
				} else {
					var endDate = row.cells[5];
					var sDate = row.cells[4];
					countDownDate = new Date(endDate.innerHTML.replace(/-/g,
							"/")).getTime();
					startDate = new Date(sDate.innerHTML.replace(/-/g, "/"));
					startDate = new Date(startDate.setMinutes(startDate
							.getMinutes()
							+ plus)).getTime();
					var countDown = row.cells[6];
					// Update the count down every 1 second

					// Find the distance between now an the count down date
					var distance = startDate - countDownDate;

					// Time calculations for days, hours, minutes and seconds
					var days = Math.floor(distance / (1000 * 60 * 60 * 24));
					var hours = Math.floor((distance % (1000 * 60 * 60 * 24))
							/ (1000 * 60 * 60));
					var minutes = Math.floor((distance % (1000 * 60 * 60))
							/ (1000 * 60));
					var seconds = Math.floor((distance % (1000 * 60)) / 1000);

					// Display the result in the element
					countDown.innerHTML = (days + "d " + hours + "h " + minutes
							+ "m " + seconds + "s ");
				}

			}
		}, 1000);
	</script>
</body>

</html>