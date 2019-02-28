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
<title>Inventory</title>
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
     	SELECT * from switch_inven
     	where pid = '<%=request.getParameter("pid")%>';
     </sql:query>

	<div class="wrapper  theme-1-active pimary-color-blue">
		<jsp:include page="navbar.jsp"></jsp:include>

		<!-- Main Content -->
		<div class="page-wrapper">
			<div class="container-fluid">

				<!-- Title -->
				<div class="row heading-bg">
					<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
						<h5 class="txt-dark">Inventory Management</h5>
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
														<th>Hostname</th>
														<th>IP</th>
														<th>Name</th>
														<th>Description</th>
														<th>PID</th>
														<th>SerialNumber</th>
														<th>Project</th>
														<!-- <th>Delete</th> -->
													</tr>
												</thead>
												<tbody>
													<c:forEach var="row" items="${result.rows}">
														<sql:query dataSource="${ticket}" var="pcode">
     														SELECT p_code
															FROM project_warranty
															where sn = ?
															<sql:param value = "${row.serial}" />
     													</sql:query>
														<tr>
															<td><c:out value="${row.hostname}" /></td>
															<td><c:out value="${row.ip}" /></td>
															<td><c:out value="${row.name}" /></td>
															<td><c:out value="${row.descr}" /></td>
															<td><c:out value="${row.pid}" /></td>
															<td><c:out value="${row.serial}" /></td>
															<c:choose>
																<c:when test="${pcode.rowCount < 1}">
																	<td>N/A</td>
																</c:when>
																<c:otherwise>
																	<c:forEach items="${pcode.rows}" var="row1">
																		<c:set var="checkpcode" value="${row1.p_code}" />
																		<c:if
																			test="${checkpcode == '310171627'}">
																			<td>SDA</td>
																		</c:if>
																		<c:if
																			test="${checkpcode == '501180681'}">
																			<td>VOICE</td>
																		</c:if>
																		<c:if
																			test="${checkpcode == '501180872'}">
																			<td>FIDS</td>
																		</c:if>
																	</c:forEach>
																</c:otherwise>
															</c:choose>

															<%-- <td>
															<form action="../ShowModuleServlet" method="post">
															<button type="submit"
																	class="btn btn-primary btn-sm view"
																	id="${row.hostname}">
																	View
																	<input type="hidden" name="hostname" value="${row.hostname}"/>
																</button>
															</form>
																</td> --%>
															<%-- <td>
																<button type="button"
																	class="btn btn-danger btn-sm del"
																	data-target="#myModalsmall" data-toggle="modal"
																	id="${row.ID}">Delete</button></td> --%>
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



				<!-- Modal Large for delete-->
				<div class="modal fade" id="myModalsmall" role="dialog">
					<form action="../EditInven" method="post">
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

	<!-- Owl JavaScript -->
	<script
		src="../vendors/bower_components/owl.carousel/dist/owl.carousel.min.js"></script>


	<!-- Fancy Dropdown JS -->
	<script src="dist/js/dropdown-bootstrap-extended.js"></script>

	<!-- Init JavaScript -->
	<script src="dist/js/init.js"></script>

</body>

</html>