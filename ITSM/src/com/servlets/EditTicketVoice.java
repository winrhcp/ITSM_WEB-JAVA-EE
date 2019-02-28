package com.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.mysql.jdbc.Connection;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import mysqlDB.MySQLConnection;


/**
 * Servlet implementation class Edit_Ticket_Voice
 */
@WebServlet("/EditTicketVoice")
public class EditTicketVoice extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MySQLConnection db = new MySQLConnection();
	Connection conn = (Connection) db.getConnection();
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EditTicketVoice() {
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
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String button = request.getParameter("buttoncheck");
		String delete_earno = request.getParameter("del");
		String edit_earno = request.getParameter("edit_earno");
		if ("b1".equals(button)) {
			// delete
			String sql = "DELETE FROM ticket_voice WHERE EAR_No = ?;";
			try {
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, delete_earno);
				ps.executeUpdate();

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if ("b2".equals(button)) {
			String sql = "UPDATE ticket_voice SET EAR_No = ?, Projectcode = ?, Incidentno = ?, ActivityReport = ?, Date = ?, Customer = ?, Location = ?, Contact_Person = ?, Tel = ?, Incident = ?, Solution = ?, Status = ?, Configuration = ? WHERE Number = ?";
			try {
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
				ps.setString(14, edit_earno);
				ps.executeUpdate();


			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		response.sendRedirect("full-width-light/ViewTicketVoice.jsp");  
	}

}
