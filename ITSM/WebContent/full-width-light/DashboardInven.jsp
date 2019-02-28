<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.mysql.jdbc.Connection"%>
<%@ page import="mysqlDB.MySQLConnection"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.lang.Object"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.HashMap,java.util.Map"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>DashBoard</title>


<!-- Favicon -->
<link rel="shortcut icon" href="favicon.ico">
<link rel="icon" href="favicon.ico" type="image/x-icon">

<!-- Data table CSS -->
<link
	href="../vendors/bower_components/datatables/media/css/jquery.dataTables.min.css"
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

	<sql:setDataSource var="ticket" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://localhost:3306/ticket?useUnicode=yes&characterEncoding=UTF-8"
		user="root" password="root" />

	<sql:query dataSource="${ticket}" var="result">
     	SELECT DISTINCT pid 
     	FROM ticket.switch_inven 
     	where descr = "Cisco Systems" or name = "1" or name = "2" or name = "3" or name = "4" or name = "5" or name = "6" or name = "7" or name = "8" or name = "9" or name like "1%" or name like "Linecard%"
     	ORDER BY pid DESC;
     </sql:query>
	<%-- <sql:query dataSource="${ticket}" var="pcode_SDA">
     	SELECT p_code
     	FROM ticket.switch_project 
     	where p_code = "SDA";
     </sql:query>
	<sql:query dataSource="${ticket}" var="pcode_VOICE">
     	SELECT p_code
     	FROM ticket.switch_project 
     	where p_code = "Voice";
     </sql:query>
	<sql:query dataSource="${ticket}" var="pcode_FIDS">
     	SELECT p_code
     	FROM ticket.switch_project 
     	where p_code = "FIDS";
     </sql:query> --%>
     
    <sql:query dataSource="${ticket}" var="pcode_SDA">
     	SELECT project_warranty.p_code, project_warranty.sn, switch_inven.serial
     	FROM ticket.project_warranty 
     	inner join switch_inven on project_warranty.sn = switch_inven.serial and project_warranty.p_code = "310171627";
    </sql:query>
    <!-- where p_code = "310171627" -->
	<sql:query dataSource="${ticket}" var="pcode_VOICE">
     	SELECT project_warranty.p_code, project_warranty.sn, switch_inven.serial
     	FROM ticket.project_warranty 
     	inner join switch_inven on project_warranty.sn = switch_inven.serial and project_warranty.p_code = "501180681";
     </sql:query>
	<sql:query dataSource="${ticket}" var="pcode_FIDS">
     	SELECT project_warranty.p_code, project_warranty.sn, switch_inven.serial
     	FROM ticket.project_warranty 
     	inner join switch_inven on project_warranty.sn = switch_inven.serial and project_warranty.p_code = "501180872";
     </sql:query>
	<div class="wrapper theme-1-active pimary-color-blue">

		<jsp:include page="navbar.jsp"></jsp:include>

		<!-- Main Content -->
		<div class="page-wrapper">
			<div class="container-fluid">

				<!-- Title -->
				<div class="row heading-bg">
					<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
						<h5 class="txt-dark">DashBoard Inventory</h5>
					</div>
					<!-- Breadcrumb -->
					<!-- <div class="col-lg-9 col-sm-8 col-md-8 col-xs-12">
						<ol class="breadcrumb">
							<li><a href="index.html">Dashboard</a></li>
							<li><a href="#"><span>speciality pages</span></a></li>
							<li class="active"><span>blank page</span></li>
						</ol>
					</div> -->
					<!-- /Breadcrumb -->
				</div>
				<!-- /Title -->
				<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
					<div class="panel panel-default card-view">
						<div class="panel-heading">
							<div class="pull-left">
								<h6 class="panel-title txt-dark">Existing Devices</h6>
							</div>
							<div class="clearfix"></div>
						</div>
						<div class="panel-wrapper collapse in">
							<div class="panel-body row">
								<div class="">
									<c:set var="counter" value="0" />
									<c:forEach var="row" items="${result.rows}">

										<sql:query dataSource="${ticket}" var="count2">
     									SELECT pid
     									FROM ticket.switch_inven 
     									where pid = ?
     									<sql:param value = "${row.pid}" />
     									</sql:query>
										<div class="pl-15 pr-15 mb-15">
											<div class="pull-left">
												<i class="fa fa-circle inline-block mr-10 font-16"
													style="color: green"></i> <a
													class="inline-block txt-dark" href="SelectInven.jsp?pid=${row.pid}"><c:out
														value="${row.pid}" /></a>
											</div>
											<span class="inline-block txt-success pull-right weight-500"><c:out
													value="${count2.rowCount}" /></span>
											<div class="clearfix"></div>
										</div>
										<hr class="light-grey-hr mt-0 mb-15" />
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="panel panel-default card-view pa-0">
						<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
							<div class="panel panel-default card-view pa-0">
								<div class="panel-wrapper collapse in">
									<div class="panel-body pa-0">
										<div class="sm-data-box">
											<div class="container-fluid">
												<div class="row">
													<div class="col-xs-12 text-center pl-0 pr-0 data-wrap-left">
														<span class="txt-dark block counter"><span
															class="counter-anim"><c:out
																	value="${pcode_SDA.rowCount}" /></span></span> <span
															class="weight-500 uppercase-font block font-13">SDA</span>
													</div>

												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
							<div class="panel panel-default card-view pa-0">
								<div class="panel-wrapper collapse in">
									<div class="panel-body pa-0">
										<div class="sm-data-box">
											<div class="container-fluid">
												<div class="row">
													<div class="col-xs-12 text-center pl-0 pr-0 data-wrap-left">
														<span class="txt-dark block counter"><span
															class="counter-anim"><c:out
																	value="${pcode_VOICE.rowCount}" /></span></span> <span
															class="weight-500 uppercase-font block font-13">Voice</span>
													</div>

												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
							<div class="panel panel-default card-view pa-0">
								<div class="panel-wrapper collapse in">
									<div class="panel-body pa-0">
										<div class="sm-data-box">
											<div class="container-fluid">
												<div class="row">
													<div class="col-xs-12 text-center pl-0 pr-0 data-wrap-left">
														<span class="txt-dark block counter"><span
															class="counter-anim"><c:out
																	value="${pcode_FIDS.rowCount}" /></span></span> <span
															class="weight-500 uppercase-font block font-13">FIDS</span>
													</div>

												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- 				<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
					<div class="panel panel-default card-view panel-refresh">
						<div class="refresh-container">
							<div class="la-anim-1"></div>
						</div>
						<div class="panel-heading">
							<div class="pull-left">
								<h6 class="panel-title txt-dark">Existing Devices Chart</h6>
							</div>
							<div class="pull-right">
								<a href="#" class="pull-left inline-block refresh"> <i
									class="zmdi zmdi-replay"></i>
								</a>
							</div>
							<div class="clearfix"></div>
						</div>
						<div class="panel-wrapper collapse in">
							<div class="panel-body">
								<div id="e_chart_2" class="" style="height: 330px;"></div>
							</div>
						</div>
					</div>
				</div> -->

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

	<!-- Counter Animation JavaScript -->
	<script
		src="../vendors/bower_components/waypoints/lib/jquery.waypoints.min.js"></script>
	<script
		src="../vendors/bower_components/jquery.counterup/jquery.counterup.min.js"></script>

	<!-- Data table JavaScript -->
	<script
		src="../vendors/bower_components/datatables/media/js/jquery.dataTables.min.js"></script>
	<script src="dist/js/productorders-data.js"></script>

	<!-- Owl JavaScript -->
	<script
		src="../vendors/bower_components/owl.carousel/dist/owl.carousel.min.js"></script>

	<!-- Switchery JavaScript -->
	<script
		src="../vendors/bower_components/switchery/dist/switchery.min.js"></script>

	<!-- Slimscroll JavaScript -->
	<script src="dist/js/jquery.slimscroll.js"></script>

	<!-- Fancy Dropdown JS -->
	<script src="dist/js/dropdown-bootstrap-extended.js"></script>

	<!-- Sparkline JavaScript -->
	<script src="../vendors/jquery.sparkline/dist/jquery.sparkline.min.js"></script>

	<!-- EChartJS JavaScript -->
	<script
		src="../vendors/bower_components/echarts/dist/echarts-en.min.js"></script>
	<script src="../vendors/echarts-liquidfill.min.js"></script>

	<!-- Toast JavaScript -->
	<script
		src="../vendors/bower_components/jquery-toast-plugin/dist/jquery.toast.min.js"></script>

	<!-- Init JavaScript -->
	<script src="dist/js/init.js"></script>
	<script src="dist/js/dashboard3-data.js"></script>


</body>

</html>
