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

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;



import mysqlDB.MySQLConnection;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MySQLConnection db = new MySQLConnection();
	Connection conn = (Connection) db.getConnection();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String sql = "SELECT * FROM ait_engineer where username = ? and password = ?";
		String user = request.getParameter("username");
		String pass = request.getParameter("password");
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, user);
			ps.setLong(2, pass.hashCode());
			ResultSet rs = ps.executeQuery();
			if (rs.next() == true) {
				System.out.println("Login Success");
				String username = rs.getString("username");
				String password = rs.getString("password");
				String code = rs.getString("code");
				String FirstName = rs.getString("FirstName");
				String LastName = rs.getString("LastName");
				String NickName = rs.getString("NickName");
				String Tel = rs.getString("Tel");
				String WorkShift = rs.getString("WorkShift");
				String role = rs.getString("role");
					
				session.setAttribute("username", username);
				session.setAttribute("code", code);
				session.setAttribute("FirstName", FirstName);
				session.setAttribute("LastName", LastName);
				session.setAttribute("NickName", NickName);
				session.setAttribute("Tel", Tel);
				session.setAttribute("WorkShift", WorkShift);
				session.setAttribute("role", role);
					
				response.sendRedirect("full-width-light/DashboardTicket.jsp");
			}
			else {
				System.out.println("Invalid Username or Password");
				response.sendRedirect("full-width-light/Login.jsp");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
