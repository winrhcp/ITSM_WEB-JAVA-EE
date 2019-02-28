package com.servlets;

import java.io.IOException;
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
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import mysqlDB.MySQLConnection;
/**
 * Servlet implementation class InsertTicketServlet
 */
@WebServlet("/InsertTicketServlet")
public class InsertTicketServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MySQLConnection db = new MySQLConnection();
	Connection conn = (Connection) db.getConnection();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertTicketServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		
		String sla = request.getParameter("sla");
		String earno = request.getParameter("earno");
		String hostname = request.getParameter("hostname");
		String ip = request.getParameter("ip");
		String incident = request.getParameter("incident");
		String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
		System.out.println(timeStamp);
		String status = "pending";
		String code = (String) session.getAttribute("code");
		String sql = "insert into ticket (sla, EAR_No, hostname, ip, incident, time, status, code) values(?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, sla);
			ps.setString(2, earno);
			ps.setString(3, hostname);
			ps.setString(4, ip);
			ps.setString(5, incident);
			ps.setString(6, timeStamp);
			ps.setString(7, status);
			ps.setString(8, code);
			
			ps.executeUpdate();


		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.sendRedirect("full-width-light/ViewTicket.jsp");
	}

}
