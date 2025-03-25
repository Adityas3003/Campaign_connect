<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	String n = request.getParameter("name");
	String e = request.getParameter("email");
	String m = request.getParameter("message");
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/campaign_connect", "root", "root");
	PreparedStatement ps = con.prepareStatement("INSERT INTO enquiry_form (full_name, email, message) VALUES (?, ?, ?)");
    ps.setString(1, n);
    ps.setString(2, e);
    ps.setString(3, m);
    
    ps.executeUpdate();
    out.println("<script>");
    out.println("window.alert('Enquiry Submitted Successfully!'); window.location.href='index.html';");
    out.println("</script>");
%>
</body>
</html>