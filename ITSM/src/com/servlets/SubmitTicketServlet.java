package com.servlets;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
/*import java.io.InputStream;*/
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
/*import java.nio.file.Paths;*/
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
/*import javax.servlet.http.Part;*/
import javax.servlet.http.Part;

/*import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;*/
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.mysql.jdbc.Connection;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

import mysqlDB.MySQLConnection;
/**
 * Servlet implementation class SubmitTicketServlet
 */
@WebServlet("/SubmitTicketServlet")
@MultipartConfig(maxFileSize = 1699999)
public class SubmitTicketServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MySQLConnection db = new MySQLConnection();
	Connection conn = (Connection) db.getConnection();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SubmitTicketServlet() {
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
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		List<String> myList = new ArrayList<>();
		List<String> fpath = new ArrayList<>();
		List<String> fname = new ArrayList<>();
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		int countlist = 0 ;
		if (isMultipart) {
			// Create a factory for disk-based file items
			FileItemFactory factory = new DiskFileItemFactory();
			// Create a new file upload handler
			ServletFileUpload upload = new ServletFileUpload(factory);
			try {
				// Parse the request
				List<FileItem> items = upload.parseRequest(request);
				System.out.println(items);
				Iterator iterator = items.iterator();
				System.out.println(iterator);
				while (iterator.hasNext()) {
					FileItem item = (FileItem) iterator.next();
					if (!item.isFormField()) {
						String fileName = item.getName();
						String root = "C:\\Program Files\\Apache Software Foundation\\apache-tomcat-8.0.53\\webapps\\uploadfile\\";
						File path = new File(root + "/uploads");
						if (!path.exists()) {
							boolean status = path.mkdirs();
						}
						File uploadedFile = new File(path + "/"+"Log_"+(String)myList.get(0)+"_" + fileName);
						System.out.println(uploadedFile.getAbsolutePath());
						if (fileName != "") {
							item.write(uploadedFile);
							fpath.add("/uploadfile/uploads/Log_" + (String)myList.get(0) + "_" + fileName);
							fname.add(fileName);
						}
							
						else {
							System.out.println("file not found");
						}
						System.out.println("File Uploaded Successfully");
						
					} else {
						String abc = item.getString();
						System.out.println(abc);
						if(countlist == 12) {
							System.out.println("end list");
						}else {
							myList.add(abc);
						}
						countlist += 1;
					}
				}
			} catch (FileUploadException e) {
				System.out.println(e);
			} catch (Exception e) {
				System.out.println(e);
			}
		} else {
			System.out.println("Not Found");
			
		}
		System.out.println(fpath);
		String number = (String) myList.get(0);

		String timeStamp = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
		String end_time = timeStamp;
		String code = (String) session.getAttribute("code");
		try {
			String sql = "UPDATE ticket SET status = ? where ticket_id = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "Waiting");
			ps.setString(2, number);
			ps.executeUpdate();

			String sql2 = "update ticket set end_time = ?, code_end = ? where ticket_id = ?";
			PreparedStatement ps2 = conn.prepareStatement(sql2);
			ps2.setString(1, end_time);
			ps2.setString(2, code);
			ps2.setString(3, number);
			ps2.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String sqlfile = "insert into ticket_file (filepath, filename, ticket_id) values(?, ?, ?)";
		int cna = 0;
		for(String element : fpath) {
		    System.out.println(element);
		    try {
				PreparedStatement ps = conn.prepareStatement(sqlfile);
				ps.setString(1, element);
				ps.setString(2, fname.get(cna));
				ps.setString(3, number);
				cna += 1;
				ps.executeUpdate();

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		String projectcode = (String) myList.get(2);
		String Activity_Report = (String) myList.get(1);
		String customer = (String) myList.get(3);
		String location = (String) myList.get(4);
		String contactperson = (String) myList.get(7);
		String tel = (String) myList.get(6);
		String solution = (String) myList.get(8);
		String date = (String) myList.get(5);
		String status = (String) myList.get(9);
		String configchange = (String) myList.get(10);
		
		byte[] bytes = customer.getBytes(StandardCharsets.ISO_8859_1);
		customer = new String(bytes, StandardCharsets.UTF_8);
		bytes = solution.getBytes(StandardCharsets.ISO_8859_1);
		solution = new String(bytes, StandardCharsets.UTF_8);
		bytes = contactperson.getBytes(StandardCharsets.ISO_8859_1);
		contactperson = new String(bytes, StandardCharsets.UTF_8);
		bytes = location.getBytes(StandardCharsets.ISO_8859_1);
		location = new String(bytes, StandardCharsets.UTF_8);

		String sql = "insert into ticket_detail (Projectcode, ActivityReport, Date, Customer, Location, Contact_Person, Tel, Solution, Status, Configuration, code, ticket_id_fk) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, projectcode);
			ps.setString(2, Activity_Report);
			ps.setString(3, date);
			ps.setString(4, customer);
			ps.setString(5, location);
			ps.setString(6, contactperson);
			ps.setString(7, tel);
			ps.setString(8, solution);
			ps.setString(9, status);
			ps.setString(10, configchange);
			ps.setString(11, code);
			ps.setString(12, number);

			ps.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		response.sendRedirect("full-width-light/ViewTicket.jsp");
	}

}
