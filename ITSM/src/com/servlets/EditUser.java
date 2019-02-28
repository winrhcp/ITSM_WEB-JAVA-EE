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
 * Servlet implementation class EditUser
 */
@WebServlet("/EditUser")
public class EditUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MySQLConnection db = new MySQLConnection();
	Connection conn = (Connection) db.getConnection();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditUser() {
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
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		String code = (String) session.getAttribute("code");
		String FirstName = request.getParameter("fname");
		String LastName = request.getParameter("lname");
		String NickName = request.getParameter("nickname");
		String Tel = request.getParameter("tel");
		String button = request.getParameter("buttoncheck");
		String page = "";
		if("1".equals(button)) {
			page="full-width-light/UserProfile.jsp";
			try {
				String sql = "UPDATE ait_engineer SET FirstName = ?, LastName = ?, NickName = ?, Tel = ? where code = ?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, FirstName);
				ps.setString(2, LastName);
				ps.setString(3, NickName);
				ps.setString(4, Tel);
				ps.setString(5, code);
				ps.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else if("2".equals(button)) {
			page="full-width-light/UserProfile.jsp";
			String oldpass = request.getParameter("oldpass");
			String pass = request.getParameter("newpass");
			String sqlcheck = "SELECT * FROM ait_engineer where code = ? and password = ?";
			try {
				PreparedStatement ps1 = conn.prepareStatement(sqlcheck);
				ps1.setString(1, code);
				ps1.setLong(2, oldpass.hashCode());
				ResultSet rs = ps1.executeQuery();
				if (rs.next() == true) {
					String sql = "UPDATE ait_engineer SET password = ? where code = ?";
					try {
						PreparedStatement ps = conn.prepareStatement(sql);
						ps.setLong(1, pass.hashCode());
						ps.setString(2, code);
						ps.executeUpdate();
					} catch (SQLException e) {
						e.printStackTrace();
					}
					System.out.println("Change Password Success");
				}
				else {
					System.out.println("Invalid Password");
					page = "full-width-light/Changepass.jsp";
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		
		response.sendRedirect(page);
	}

}
