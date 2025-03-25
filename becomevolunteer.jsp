<%@ page import="java.sql.*" %>
<%
    String fullName = request.getParameter("volunteerFullName");
    String email = request.getParameter("volunteerEmail");
    String username = request.getParameter("volunteerUsername");
    String password = request.getParameter("volunteerPassword");
    String location = request.getParameter("volunteerLocation");

    Connection con = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/campaign_connect", "root", "root");

        String query = "INSERT INTO volunteers (full_name, email, username, password, location) VALUES (?, ?, ?, ?, ?)";
        ps = con.prepareStatement(query);
        ps.setString(1, fullName);
        ps.setString(2, email);
        ps.setString(3, username);
        ps.setString(4, password);
        ps.setString(5, location);

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
                window.location.href = "becomeVolunteer.html";
            </script>
<%
        }
    } catch (Exception e) {
%>
        <script>
            alert("Error: <%= e.getMessage() %>");
            window.location.href = "becomeVolunteer.html";
        </script>
<%
    } finally {
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>
