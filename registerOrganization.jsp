<%@ page import="java.sql.*, java.util.regex.Pattern" %>
<%
    String orgName = request.getParameter("orgName");
    String email = request.getParameter("orgEmail");
    String username = request.getParameter("orgUsername");
    String password = request.getParameter("orgPassword");
    String location = request.getParameter("orgLocation");

   
    if (orgName == null || orgName.trim().isEmpty()) {
        out.println("<script>alert('Organization name is required!'); window.location.href = 'register.html';</script>");
        return;
    }
    if (!orgName.matches("[A-Za-z ]+")) {  
        out.println("<script>alert('Organization name should only contain letters and spaces!'); window.location.href = 'register.html';</script>");
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

   
    Connection con = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/campaign_connect", "root", "root");

        String query = "INSERT INTO organizations (org_name, email, username, password, location) VALUES (?, ?, ?, ?, ?)";
        ps = con.prepareStatement(query);
        ps.setString(1, orgName);
        ps.setString(2, email);
        ps.setString(3, username);
        ps.setString(4, password);
        ps.setString(5, location);

        int i = ps.executeUpdate();
        if (i > 0) {
%>
            <script>
                alert("Organization registered successfully! Please log in.");
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
