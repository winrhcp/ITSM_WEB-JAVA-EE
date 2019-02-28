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
 * Servlet implementation class EditViewEn
 */
@WebServlet("/EditViewEn")
public class EditViewEn extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MySQLConnection db = new MySQLConnection();
	Connection conn = (Connection) db.getConnection();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditViewEn() {
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
		
		String delete = request.getParameter("del");
		String checkdel = request.getParameter("buttoncheck");
		
		String username = request.getParameter("username");
		String code = request.getParameter("code");
		String FirstName = request.getParameter("fname");
		String LastName = request.getParameter("lname");
		String NickName = request.getParameter("nickname");
		String Tel = request.getParameter("tel");
		String WorkShift = request.getParameter("workshift");
		String role = request.getParameter("role");
		String edit = request.getParameter("edit");
		System.out.println(edit + "....");
		if ("b1".equals(checkdel)) {
			// delete
			String sql = "DELETE FROM ait_engineer WHERE code = ?;";
			try {
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, delete);
				ps.executeUpdate();

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if("b2".equals(checkdel)){
			try {
				String sql = "UPDATE ait_engineer SET code = ?, FirstName = ?, LastName = ?, NickName = ?, Tel = ?, username = ?, WorkShift = ?, role = ? where code = ?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, code);
				ps.setString(2, FirstName);
				ps.setString(3, LastName);
				ps.setString(4, NickName);
				ps.setString(5, Tel);
				ps.setString(6, username);
				ps.setString(7, WorkShift);
				ps.setString(8, role);
				ps.setString(9, edit);
				ps.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		response.sendRedirect("full-width-light/ViewEn.jsp");
	}

}
