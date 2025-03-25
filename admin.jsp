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
	String a,ap,A,AP;
	a=request.getParameter("Username");
	ap=request.getParameter("password");
	
	A="Admin";
	AP="admin@3003";
	
	if(a.equals(A) && ap.equals(AP))
	{
		out.println("<script>");
		out.println("window.alert('Admin Login Successful!!')");
		out.println("window.location.href='admin.html'");
		out.println("</script>");
	}
	else
	{
		out.println("<script>");
		out.println("window.alert('Admin Login UnSuccessfull')");
		out.println("window.history.back()");
		out.println("</script>");
	}
%>
</body>
</html>