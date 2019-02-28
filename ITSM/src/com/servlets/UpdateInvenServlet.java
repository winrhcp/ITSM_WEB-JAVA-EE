package com.servlets;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.*;

/**
 * Servlet implementation class UpdateInvenServlet
 */
@WebServlet("/UpdateInvenServlet")
public class UpdateInvenServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateInvenServlet() {
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
		/*
		 * Process p = Runtime.getRuntime().
		 * exec("python C:\\Users\\Thanawin\\Desktop\\teststring.py"); BufferedReader in
		 * = new BufferedReader(new InputStreamReader(p.getInputStream())); String ret =
		 * in.readLine(); System.out.println("value is : "+ret);
		 */
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String button = request.getParameter("buttoncheck");
		String ipswitch = request.getParameter("ipswitch");
		int sleep = 0;
		if ("1".equals(button)) {
			try {
				Process p = Runtime.getRuntime().exec("python C:\\Users\\Thanawin\\Desktop\\python_network_script\\Inventory\\selectinven.py" + ipswitch);
				p.waitFor();
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else {

			/*File file = new File("C:\\Users\\Thanawin\\Desktop\\python_network_script\\Inventory\\testinvencore.txt");

			BufferedReader br = new BufferedReader(new FileReader(file));
			
			String st;
			while ((st = br.readLine()) != null) {
				sleep += 7000;
			}
			br.close();
			System.out.println(sleep);*/
			try {
				/*Thread.sleep(sleep);*/
				Process p = Runtime.getRuntime().exec("python C:\\Users\\Thanawin\\Desktop\\python_network_script\\Inventory\\inventory.py");
				p.waitFor();
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		response.sendRedirect("full-width-light/Inven.jsp");
	}

}
