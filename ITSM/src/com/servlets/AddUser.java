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

import mysqlDB.MySQLConnection;
/**
 * Servlet implementation class AddUser
 */
@WebServlet("/AddUser")
public class AddUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MySQLConnection db = new MySQLConnection();
	Connection conn = (Connection) db.getConnection();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		String srt = "m";
		System.out.println(srt.hashCode());
		System.out.println(srt.hashCode());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		String code = request.getParameter("code");
		String username = request.getParameter("username");
		String pass = request.getParameter("pass");
		pass.hashCode();
		String passretry = request.getParameter("passretry");
		String fname = request.getParameter("fname");
		String lname = request.getParameter("lname");
		String nickname = request.getParameter("nickname");
		String tel = request.getParameter("tel");
		String workshift = request.getParameter("workshift");
		String role = request.getParameter("role");
		
		String sql = "insert into ait_engineer (code, FirstName, LastName, NickName, Tel, username, password, WorkShift, role) values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, code);
			ps.setString(2, fname);
			ps.setString(3, lname);
			ps.setString(4, nickname);
			ps.setString(5, tel);
			ps.setString(6, username);
			ps.setLong(7, pass.hashCode());
			ps.setString(8, workshift);
			ps.setString(9, role);
			
			ps.executeUpdate();


		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.sendRedirect("full-width-light/UserProfile.jsp");  
	}

}
