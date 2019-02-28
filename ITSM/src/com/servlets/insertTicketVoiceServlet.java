package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.jdbc.Connection;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import mysqlDB.MySQLConnection;

/**
 * Servlet implementation class insertTicketVoiceServlet
 */
@WebServlet("/insertTicketVoiceServlet")
public class insertTicketVoiceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MySQLConnection db = new MySQLConnection();
	Connection conn = (Connection) db.getConnection();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public insertTicketVoiceServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String projectcode = request.getParameter("projectcode");
		String Activity_Report = request.getParameter("Activity_Report");
		String customer = request.getParameter("customer");
		String location = request.getParameter("location");
		String contactperson = request.getParameter("contactperson");
		String tel = request.getParameter("tel");
		String incident = request.getParameter("incident");
		String solution = request.getParameter("solution");
		String earno = request.getParameter("earno");
		String incidentno = request.getParameter("incidentno");
		String date = request.getParameter("date");
		String status = request.getParameter("status");
		String configchange = request.getParameter("configchange");
		String code = (String) session.getAttribute("code");
		String sql = "insert into ticket_voice (EAR_No, Projectcode, Incidentno, ActivityReport, Date, Customer, Location, Contact_Person, Tel, Incident, Solution, Status, Configuration, code) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, earno);
			ps.setString(2, projectcode);
			ps.setString(3, incidentno);
			ps.setString(4, Activity_Report);
			ps.setString(5, date);
			ps.setString(6, customer);
			ps.setString(7, location);
			ps.setString(8, contactperson);
			ps.setString(9, tel);
			ps.setString(10, incident);
			ps.setString(11, solution);
			ps.setString(12, status);
			ps.setString(13, configchange);
			ps.setString(14, code);
			
			ps.executeUpdate();


		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.sendRedirect("full-width-light/ViewTicketVoice.jsp");

	}

}
