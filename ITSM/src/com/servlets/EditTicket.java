package com.servlets;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
/*import java.io.InputStream;*/
import java.io.PrintWriter;
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
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;

import mysqlDB.MySQLConnection;

/**
 * Servlet implementation class EditTicket
 */
@WebServlet("/EditTicket")
@MultipartConfig(maxFileSize = 1699999)
public class EditTicket extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MySQLConnection db = new MySQLConnection();
	Connection conn = (Connection) db.getConnection();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EditTicket() {
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
		HttpSession session = request.getSession();
		String button = request.getParameter("buttoncheck");
		String delete = request.getParameter("del");
		/*
		 * String filepath = request.getParameter("upfile");
		 * System.out.println(filepath);
		 */

		if ("b1".equals(button)) {
			// delete
			String sql = "DELETE FROM ticket WHERE ticket_id = ?;";
			try {
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, delete);
				ps.executeUpdate();

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String sqldel = "DELETE FROM ticket_detail WHERE ticket_id_fk = ?;";
			try {
				PreparedStatement ps = conn.prepareStatement(sqldel);
				ps.setString(1, delete);
				ps.executeUpdate();

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String sqldel2 = "DELETE FROM ticket_file WHERE ticket_id = ?;";
			try {
				PreparedStatement ps = conn.prepareStatement(sqldel2);
				ps.setString(1, delete);
				ps.executeUpdate();

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if ("b2".equals(button)) {
			/*boolean isMultipart = ServletFileUpload.isMultipartContent(request);
			
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
							File uploadedFile = new File(path + "/" + fileName);
							System.out.println(uploadedFile.getAbsolutePath());
							if (fileName != "")
								item.write(uploadedFile);
							else
								System.out.println("file not found");
							System.out.println("File Uploaded Successfully");
						} else {
							String abc = item.getString();
							System.out.println(abc);
						}
					}
				} catch (FileUploadException e) {
					System.out.println(e);
				} catch (Exception e) {
					System.out.println(e);
				}
			} else {
				System.out.println("1part");
				String number = request.getParameter("num");
				Part filePart = request.getPart("upfile"); // Retrieves <input type="file"name="file">

				String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
				InputStream fileInputStream = filePart.getInputStream();
				System.out.println(filePart.getSubmittedFileName());

				String fp = "C:\\Program Files\\Apache Software Foundation\\apache-tomcat-8.0.53\\webapps\\uploadfile\\"
						+ "Log_" + number + "_" + filePart.getSubmittedFileName();
				System.out.println(fp);
				File fileToSave = new File(fp);
				Files.copy(fileInputStream, fileToSave.toPath(), StandardCopyOption.REPLACE_EXISTING);

				String timeStamp = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
				String end_time = timeStamp;
				String code = (String) session.getAttribute("code");
				fp = "/uploadfile/Log_" + number + "_" + fileName;
				try {
					String sql = "UPDATE ticket SET status = ? where ticket_id = ?";
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1, "Waiting");
					ps.setString(2, number);
					ps.executeUpdate();

					String sql2 = "update ticket set filepath = ?, end_time = ?, code_end = ? where ticket_id = ?";
					PreparedStatement ps2 = conn.prepareStatement(sql2);
					ps2.setString(1, fp);
					ps2.setString(2, end_time);
					ps2.setString(3, code);
					ps2.setString(4, number);
					ps2.executeUpdate();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				String projectcode = request.getParameter("projectcode");
				String Activity_Report = request.getParameter("Activity_Report");
				String customer = request.getParameter("customer");
				String location = request.getParameter("location");
				String contactperson = request.getParameter("contactperson");
				String tel = request.getParameter("tel");
				String solution = request.getParameter("solution");
				String earno = request.getParameter("earno");
				String date = request.getParameter("date");
				String status = request.getParameter("status");
				String configchange = request.getParameter("configchange");
				String sql = "insert into ticket_detail (EAR_No, Projectcode, ActivityReport, Date, Customer, Location, Contact_Person, Tel, Solution, Status, Configuration, code, ticket_id_fk) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
				try {
					PreparedStatement ps = conn.prepareStatement(sql);
					ps.setString(1, earno);
					ps.setString(2, projectcode);
					ps.setString(3, Activity_Report);
					ps.setString(4, date);
					ps.setString(5, customer);
					ps.setString(6, location);
					ps.setString(7, contactperson);
					ps.setString(8, tel);
					ps.setString(9, solution);
					ps.setString(10, status);
					ps.setString(11, configchange);
					ps.setString(12, code);
					ps.setString(13, number);

					ps.executeUpdate();

				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}*/

		} else if ("b3".equals(button)) {

			String number = request.getParameter("num");
			String end_d = request.getParameter("end_date");
			String end_t = request.getParameter("end_time");
			String end_time[] = end_t.split("T");
			String end_time2 = end_time[0] + " " + end_time[1];
			String code = (String) session.getAttribute("code");
			System.out.println(number);
			System.out.println(end_time2);
			System.out.println(code);
			try {
				String sql2 = "update ticket set status = ?, end_time = ?, code_approve = ? where ticket_id = ?";
				PreparedStatement ps2 = conn.prepareStatement(sql2);
				ps2.setString(1, "Success");
				ps2.setString(2, end_time2);
				ps2.setString(3, code);
				ps2.setString(4, number);
				ps2.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		} else if ("b4".equals(button)) {

			/*String number = request.getParameter("numchange");
			Part filePart = request.getPart("upfile"); // Retrieves <input type="file"name="file">

			String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
			System.out.print(fileName);

			InputStream fileInputStream = filePart.getInputStream();
//			C:\\Program Files\\Apache Software Foundation\\apache-tomcat-8.0.53\\wtpwebapps\\ITSM\\img-log\\"
			String fp = "C:\\Program Files\\Apache Software Foundation\\apache-tomcat-8.0.53\\webapps\\uploadfile\\"
					+ "Log_" + number + "_" + filePart.getSubmittedFileName();
			System.out.println(fp);
			File fileToSave = new File(fp);
			Files.copy(fileInputStream, fileToSave.toPath(), StandardCopyOption.REPLACE_EXISTING);

			String timeStamp = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
			String end_time = timeStamp;
			String code = (String) session.getAttribute("code");
			fp = "/uploadfile/Log_" + number + "_" + fileName;
			if (fileName.length() != 0) {
				try {
					String sql2 = "update ticket set filepath = ?, end_time = ?, code_end = ? where ticket_id = ?";
					PreparedStatement ps2 = conn.prepareStatement(sql2);
					ps2.setString(1, fp);
					ps2.setString(2, end_time);
					ps2.setString(3, code);
					ps2.setString(4, number);
					ps2.executeUpdate();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

			}

			String sql = "UPDATE ticket_detail SET EAR_No = ?, Projectcode = ?, ActivityReport = ?, Date = ?, Customer = ?, Location = ?, Contact_Person = ?, Tel = ?, Solution = ?, Status = ?, Configuration = ? WHERE ticket_id_fk = ?";
			try {
				String projectcode = request.getParameter("projectcode");
				String Activity_Report = request.getParameter("Activity_Report");
				String customer = request.getParameter("customer");
				String location = request.getParameter("location");
				String contactperson = request.getParameter("contactperson");
				String tel = request.getParameter("tel");
				String solution = request.getParameter("solution");
				String earno = request.getParameter("earno");
				String date = request.getParameter("date");
				String status = request.getParameter("status");
				String configchange = request.getParameter("configchange");

				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, earno);
				ps.setString(2, projectcode);
				ps.setString(3, Activity_Report);
				ps.setString(4, date);
				ps.setString(5, customer);
				ps.setString(6, location);
				ps.setString(7, contactperson);
				ps.setString(8, tel);
				ps.setString(9, solution);
				ps.setString(10, status);
				ps.setString(11, configchange);
				ps.setString(12, number);
				ps.executeUpdate();

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}*/

		} else if ("b5".equals(button)) {
			try {
				String sql = "UPDATE ticket SET status = ? where ticket_id = ?";
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, "pending");
				ps.setString(2, delete);
				ps.executeUpdate();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		response.sendRedirect("full-width-light/ViewTicket.jsp");
	}

}
