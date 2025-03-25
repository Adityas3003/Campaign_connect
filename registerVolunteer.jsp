<%@ page import="java.sql.*, java.util.regex.Pattern" %>
<%
    String fullName = request.getParameter("volunteerFullName");
    String email = request.getParameter("volunteerEmail");

    
    if (fullName == null || fullName.trim().isEmpty()) {
        out.println("<script>alert('Full name is required!'); window.location.href = 'register.html';</script>");
        return;
    }
    if (!fullName.matches("[A-Za-z ]+")) {  
        out.println("<script>alert('Full name should only contain letters and spaces!'); window.location.href = 'register.html';</script>");
        return;
    }

   
    String emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$";
    if (email == null || email.trim().isEmpty()) {
        out.println("<script>alert('Email is required!'); window.location.href = 'register.html';</script>");
        return;
    }
    if (!Pattern.matches(emailRegex, email)) {
        out.println("<script>alert('Invalid email format!'); window.location.href = 'register.html';</script>");
        return;
    }

    
    String username = request.getParameter("volunteerUsername");
    String password = request.getParameter("volunteerPassword");
    String location = request.getParameter("volunteerLocation");
    String contact = request.getParameter("volunteerContact");

    Connection con = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/campaign_connect", "root", "root");

        String query = "INSERT INTO volunteers (full_name, email, username, password, location, contact_no) VALUES (?, ?, ?, ?, ?, ?)";
        ps = con.prepareStatement(query);
        ps.setString(1, fullName);
        ps.setString(2, email);
        ps.setString(3, username);
        ps.setString(4, password);
        ps.setString(5, location);
        ps.setString(6, contact);

        int i = ps.executeUpdate();
        if (i > 0) {
%>
            <script>
                alert("Registration successful! Please log in.");
                window.location.href = "login.html";
            </script>
<%
        } else {
%>
            <script>
                alert("Registration failed! Try again.");
                window.location.href = "register.html";
            </script>
<%
        }
    } catch (Exception e) {
%>
        <script>
            alert("Error: <%= e.getMessage() %>");
            window.location.href = "register.html";
        </script>
<%
    } finally {
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>
