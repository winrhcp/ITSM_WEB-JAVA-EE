package com.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.mysql.jdbc.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;



import mysqlDB.MySQLConnection;
/**
 * Servlet implementation class ServerSide
 */
@WebServlet("/ServerSide")
public class ServerSide extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MySQLConnection db = new MySQLConnection();
	Connection conn = (Connection) db.getConnection();
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServerSide() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String sql = "SELECT hostname, ip, name, descr, pid, serial from switch_inven";
		System.out.print("test");
		String table = "datatables_3";
		String primaryKey = "ID";
		
		System.out.println(Integer.parseInt(request.getParameter("draw")));
		//System.out.print(Integer.parseInt(request.getParameter("id")));
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			JSONObject returnObj = new JSONObject();
			JSONArray array = new JSONArray();
			int row = 0;
			int idisplaylength = Integer.parseInt(request.getParameter("length"));
			System.out.println(idisplaylength);
			while (rs.next()) {
				if(row <= idisplaylength) {
					JSONObject obj = new JSONObject();
					//int firmid=rs.getInt("firm_id");
					obj.put("Hostname",rs.getString("hostname"));
					obj.put("IP", rs.getString("ip"));
					//obj.put("type", rs.getString("type"));
					obj.put("Name", rs.getString("name"));
					obj.put("Description", rs.getString("descr"));
					obj.put("PID", rs.getString("pid"));
					obj.put("SerialNumber", rs.getString("serial"));
					array.add(obj);
				}
				row++;
			JSONArray sql_details = new JSONArray();
			/*sql_details = array(
					'user' => '',
					'pass' => '',
					'db'   => '',
					'host' => ''
					);*/
			returnObj.put("draw", 1);
			returnObj.put("recordsTotal", row);
			returnObj.put("recordsFiltered", idisplaylength);
			//returnObj.put("sEcho", Integer.parseInt(request.getParameter("sEcho")));
			returnObj.put("data", array);
			System.out.print(returnObj.toJSONString());
			System.out.flush();
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

}
