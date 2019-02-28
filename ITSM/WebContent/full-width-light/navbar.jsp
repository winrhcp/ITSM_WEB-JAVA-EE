<!-- Top Menu Items -->
<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="mobile-only-brand pull-left">
		<div class="nav-header pull-left">
			<div class="logo-wrap">
				<a href="DashboardTicket.jsp"> <img class="brand-img"
					src="../img/logoait.png" alt="brand" width="58" height="25" /> <span
					class="brand-text">ITSM</span>
				</a>
			</div>
		</div>
		<a id="toggle_nav_btn"
			class="toggle-left-nav-btn inline-block ml-20 pull-left"
			href="javascript:void(0);"><i class="zmdi zmdi-menu"></i></a> <a
			id="toggle_mobile_search" data-toggle="collapse"
			data-target="#search_form" class="mobile-only-view"
			href="javascript:void(0);"><i class="zmdi zmdi-search"></i></a> <a
			id="toggle_mobile_nav" class="mobile-only-view"
			href="javascript:void(0);"><i class="zmdi zmdi-more"></i></a>
		<form id="search_form" role="search"
			class="top-nav-search collapse pull-left">
			<div class="mt-5">
				 <span class="mt-20">
					Role : <%=session.getAttribute("role")%>
				</span>
			</div>
		</form>
	</div>
	<div id="mobile_only_nav" class="mobile-only-nav pull-right">
		<ul class="nav navbar-right top-nav pull-right">

			<li class="dropdown auth-drp"><a href="#"
				class="dropdown-toggle pr-0" data-toggle="dropdown">
					<!-- <img
					src="../img/user1.png" alt="user_auth"
					class="user-auth-img img-circle" /> -->
					<span class="user-auth-img">
					<%=session.getAttribute("username")%>
					</span>
					<span class="fa fa-sort-desc"></span>
					</a>
				<ul class="dropdown-menu user-auth-dropdown"
					data-dropdown-in="flipInX" data-dropdown-out="flipOutX">
					<li><a href="UserProfile.jsp"><i class="zmdi zmdi-account"></i><span>Profile</span></a>
					</li>

					<%
					if ( "Supervisor".equals(session.getAttribute("role")) || "admin".equals(session.getAttribute("role"))) {
					%>
					<li><a href="ViewEn.jsp"><i class="zmdi zmdi-settings"></i><span>Engineer Management</span></a></li>
					<%
					}
					%>

					<li class="divider"></li>
					<li><a href="../LogoutServlet"><i class="zmdi zmdi-power"></i><span>Log
								Out</span></a></li>
				</ul></li>
		</ul>
	</div>
</nav>
<!-- /Top Menu Items -->

<!-- Left Sidebar Menu -->
<div class="fixed-sidebar-left">
	<ul class="nav navbar-nav side-nav nicescroll-bar">
		<!-- 				<li class="navigation-header">
						<span>Main</span> 
						<i class="zmdi zmdi-more"></i>
					</li> -->
		<li><a href="javascript:void(0);" data-toggle="collapse"
			data-target="#dropdown_dr_lv1"><div class="pull-left">
					<i class="fa fa-pencil-square-o mr-20"></i><span class="right-nav-text">Ticket
					</span>
				</div>
				<div class="pull-right">
					<i class="zmdi zmdi-caret-down"></i>
				</div>
				<div class="clearfix"></div></a>
			<ul id="dropdown_dr_lv1" class="collapse collapse-level-1 ml-10">
				<li><a href="DashboardTicket.jsp">DashBoard Ticket</a></li>
				<li><a href="Ticket.jsp">Create Ticket</a></li>
				<li><a href="ViewTicket.jsp">View
						Ticket</a></li>
						 
					<%
					if ("Supervisor".equals(session.getAttribute("role")) || "Senior".equals(session.getAttribute("role"))) {
					%>
				<li><a href="Approve.jsp"><span class="right-nav-text">Approve Ticket</span></a></li>
				<%
					}
					%>
			</ul>
		</li>
		
		<li><a href="ip_manage.jsp"><div class="pull-left">
					<i class="fa fa-search mr-20"></i><span class="right-nav-text">Search
						Device</span>
				</div>
				<div class="clearfix"></div></a></li>
		<li><a href="javascript:void(0);" data-toggle="collapse"
			data-target="#dropdown_inven"><div class="pull-left">
					<i class="fa fa-archive mr-20"></i><span class="right-nav-text">Inventory
					</span>
				</div>
				<div class="pull-right">
					<i class="zmdi zmdi-caret-down"></i>
				</div>
				<div class="clearfix"></div></a>
			<ul id="dropdown_inven" class="collapse collapse-level-1 ml-10">
				<li><a href="DashboardInven.jsp">DashBoard Inventory</a></li>
				<!-- <li><a href="UpdateInven.jsp">Update Inventory</a></li> -->
				<li><a href="Inven.jsp">View Inventory</a></li>
			</ul>
		</li>
	</ul>
</div>
<!-- /Left Sidebar Menu -->