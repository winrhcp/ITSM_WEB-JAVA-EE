package com.servlets;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class FindASServlet
 */
@WebServlet("/FindASServlet")
public class FindASServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FindASServlet() {
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
		String ipclient = request.getParameter("ipclient");
		String s = null;
		String ipds = "";
		String dsname = "";
		String macclient = "";
		String port_ds_as = "";
		String ipas = "";
		String asname = "";
		String port_as_client = "";
		String vlclient = "";
		String vlname = "";
		
		try {
			Process p = Runtime.getRuntime().exec("python C:\\Users\\Thanawin\\Desktop\\python_network_script\\Inventory\\findswitch.py"+ " " + ipclient);
			p.waitFor();
			/*Thread.sleep(8000);*/
			BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
			while ((s = reader.readLine()) != null) {
				System.out.println(s);
	            if(s.contains("IP DS :")) {
	                String[] arrOfStr = s.split(":");
	                ipds = arrOfStr[1];
	            }
	            else if(s.contains("DS Name :")) {
	                String[] arrOfStr = s.split(":"); 
	                dsname = arrOfStr[1];
	            }
	            else if(s.contains("MAC Client :")) {
	                String[] arrOfStr = s.split(":"); 
	                macclient = arrOfStr[1];
	            }
	            else if(s.contains("Port DS To AS :")) {
	                String[] arrOfStr = s.split(":"); 
	                port_ds_as = arrOfStr[1];
	            }
	            else if(s.contains("IP AS :")) {
	                String[] arrOfStr = s.split(":"); 
	                ipas = arrOfStr[1];
	            }
	            else if(s.contains("Acess Switch Name :")) {
	                String[] arrOfStr = s.split(":"); 
	                asname = arrOfStr[1];
	            }
	            else if(s.contains("Port Acess Switch to Client :")) {
	                String[] arrOfStr = s.split(":"); 
	                port_as_client = arrOfStr[1];
	            }
	            else if(s.contains("Vlan Client :")) {
	                String[] arrOfStr = s.split(":"); 
	                vlclient = arrOfStr[1];
	            }
	            else if(s.contains("Vlan Name :")) {
	                String[] arrOfStr = s.split(":"); 
	                vlname = arrOfStr[1];
	            }
	        }
			reader.close();
			
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println(dsname);
		System.out.println(ipds);
		System.out.println(port_ds_as);
		System.out.println(asname);
		System.out.println(ipas);
		System.out.println(port_as_client);
		System.out.println(vlclient);
		System.out.println(macclient);
		System.out.println(vlname);
		
		
		
		HttpSession session = request.getSession();
		session.setAttribute("dsname", dsname);
		session.setAttribute("ipds", ipds);
		session.setAttribute("port_ds_as", port_ds_as);
		session.setAttribute("asname", asname);
		session.setAttribute("ipas", ipas);
		session.setAttribute("port_as_client", port_as_client);
		session.setAttribute("vlclient", vlclient);
		session.setAttribute("macclient", macclient);
		session.setAttribute("vlname", vlname);
		
		response.sendRedirect("full-width-light/ViewAS.jsp");
	}

}
