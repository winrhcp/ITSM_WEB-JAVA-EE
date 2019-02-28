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
<title>DashBoard Ticket</title>


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
	<div id="Reload">
	<%
            // Set refresh, autoload time as 15 seconds
            response.setIntHeader("Refresh", 15);

         %>
         
	<sql:setDataSource var="ticket" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://localhost:3306/ticket?useUnicode=yes&characterEncoding=UTF-8"
		user="root" password="root" />
	
	<sql:query dataSource="${ticket}" var="critical">
     	SELECT SLA 
     	FROM ticket.ticket where SLA = "Critical";
     </sql:query>
     <sql:query dataSource="${ticket}" var="major">
     	SELECT SLA 
     	FROM ticket.ticket where SLA = "Major";
     </sql:query>
     <sql:query dataSource="${ticket}" var="minor">
     	SELECT SLA 
     	FROM ticket.ticket where SLA = "Minor";
     </sql:query>
     <sql:query dataSource="${ticket}" var="warning">
     	SELECT SLA 
     	FROM ticket.ticket where SLA = "Warning";
     </sql:query>
     
     <sql:query dataSource="${ticket}" var="pending">
     	SELECT status 
     	FROM ticket.ticket where status = "pending";
     </sql:query>
     <sql:query dataSource="${ticket}" var="waiting">
     	SELECT status 
     	FROM ticket.ticket where status = "Waiting";
     </sql:query>
     <sql:query dataSource="${ticket}" var="success">
     	SELECT status 
     	FROM ticket.ticket where status = "Success";
     </sql:query>
	</div>
	<sql:query dataSource="${ticket}" var="waitingcount">
     					SELECT status
     					FROM ticket.ticket 
     					where status = "Waiting";
    					</sql:query>
	<div class="wrapper theme-1-active pimary-color-blue">
	
		<jsp:include page="navbar.jsp"></jsp:include>
		<div id="divToReload">
		<input id = critical type = "hidden" value = "${critical.rowCount}">
		<input id = "major" type = "hidden" value = "${major.rowCount}">
		<input id = "minor" type = "hidden" value = "${minor.rowCount}">
		<input id = "warning" type = "hidden" value = "${warning.rowCount}">
		
		<input id = "pending" type = "hidden" value = "${pending.rowCount}">
		<input id = "waiting" type = "hidden" value = "${waiting.rowCount}">
		<input id = "success" type = "hidden" value = "${success.rowCount}">
		</div>
		<!-- Main Content -->
		<div class="page-wrapper">
			<div class="container-fluid">

				<!-- Title -->
				<div class="row heading-bg">
					<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
						<h5 class="txt-dark">DashBoard Ticket</h5>
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

				<div class="row" id="divToReload">
					<div class="panel panel-default card-view pa-0">
						<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
							<div class="panel panel-default card-view panel-refresh">
								<div class="refresh-container">
									<div class="la-anim-1"></div>
								</div>
								<div class="panel-heading">
									<div class="pull-left">
										<h6 class="panel-title txt-dark">Ticket SLA</h6>
									</div>
									<!-- <div class="pull-right">
										<a href="DashboardTicket.jsp" class="pull-left inline-block refresh"> <i
											class="zmdi zmdi-replay"></i>
										</a>
									</div> -->
									<div class="clearfix"></div>
								</div>
								<div class="panel-wrapper collapse in">
									<div class="panel-body">
										<div id="e_chart_sla" class="" style="height: 330px;"></div>
									</div>
								</div>
							</div>
						</div>


						<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
							<div class="panel panel-default card-view panel-refresh">
								<div class="refresh-container">
									<div class="la-anim-1"></div>
								</div>
								<div class="panel-heading">
									<div class="pull-left">
										<h6 class="panel-title txt-dark">Ticket Status</h6>
									</div>
									<!-- <div class="pull-right">
										<a href="#" class="pull-left inline-block refresh"> <i
											class="zmdi zmdi-replay"></i>
										</a>
									</div> -->
									<div class="clearfix"></div>
								</div>
								<div class="panel-wrapper collapse in">
									<div class="panel-body">
										<div id="e_chart_status" class="" style="height: 330px;"></div>
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

	<script type="text/javascript">
	
	$(document).ready(function(){
		setInterval(function () {
			$("#Reload").load();
			console.log("test");
		}, 5000);
	});
	
		var critical = $("#critical").val();
		var major = $("#major").val();
		var minor = $("#minor").val();
		var warning = $("#warning").val();
		if( $('#e_chart_sla').length > 0 ){
			var e_chart_sla = echarts.init(document.getElementById('e_chart_sla'));
			var option1 = {
				tooltip : {
					trigger: 'item',
					formatter: "{a} <br/>{b} : {c} ({d}%)"
				},
				color: ['#DB1E1E','#FF4200', '#FFA500', '#F3B782'],
				series : [
					{
						name: 'SLA',
						type: 'pie',
						radius : '60%',
						center: ['50%', '50%'],
						tooltip : {
							trigger: 'item',
							formatter: "{a} <br/>{b} : {c} ({d}%)",
							backgroundColor: 'rgba(33,33,33,1)',
							borderRadius:0,
							padding:10,
						},
						data:[
							{value:critical, name:'Critical'},
							{value:major, name:'Major'},
							{value:minor, name:'Minor'},
							{value:warning, name:'Warning'},
					   ],
						itemStyle: {
							emphasis: {
								shadowBlur: 10,
								shadowOffsetX: 0,
								shadowColor: 'rgba(0, 0, 0, 0.5)'
							}
						}
					}
				]
			};
			e_chart_sla.setOption(option1);
			e_chart_sla.on('click', function (param){
                var name=param.name;
                if(name=="Critical"){
                    window.open("ViewSLA.jsp?sla=critical");
                    /* window.location.href="https://github.com"; */
                }else if(name=="Major"){
                	window.open("ViewSLA.jsp?sla=major");
                }else if(name=="Minor"){
                	window.open("ViewSLA.jsp?sla=minor");
                }else if(name == "Warning"){
                	window.open("ViewSLA.jsp?sla=warning");
                }                       
            });
			e_chart_sla.on('click');
			e_chart_sla.resize();
		}
		var pending = $("#pending").val();
		var waiting = $("#waiting").val();
		var success = $("#success").val();
		if( $('#e_chart_status').length > 0 ){
			var e_chart_status = echarts.init(document.getElementById('e_chart_status'));
			var option2 = {
				tooltip : {
					trigger: 'item',
					formatter: "{a} <br/>{b} : {c} ({d}%)"
				},
				color: ['#FF1100','#FFA500', '#228B22'],
				series : [
					{
						name: 'Status',
						type: 'pie',
						radius : '60%',
						center: ['50%', '50%'],
						tooltip : {
							trigger: 'item',
							formatter: "{a} <br/>{b} : {c} ({d}%)",
							backgroundColor: 'rgba(33,33,33,1)',
							borderRadius:0,
							padding:10,
						},
						data:[
							{value:pending, name:'Pending'},
							{value:waiting, name:'Waiting'},
							{value:success, name:'Success'},
					   ],
						itemStyle: {
							emphasis: {
								shadowBlur: 10,
								shadowOffsetX: 0,
								shadowColor: 'rgba(0, 0, 0, 0.5)'
							}
						}
					}
				]
			};
			e_chart_status.setOption(option2);
			e_chart_status.on('click', function (param){
                var name=param.name;
                if(name=="Pending"){
                    window.open("ViewStatus.jsp?status=pending");
                    /* window.location.href="https://github.com"; */
                }else if(name=="Waiting"){
                	window.open("ViewStatus.jsp?status=Waiting");
                }else if(name=="Success"){
                	window.open("ViewStatus.jsp?status=Success");
                }                
            });
			e_chart_status.on('click');
			e_chart_status.resize();
		}
		
		
	</script>
</body>

</html>
