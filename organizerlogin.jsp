<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // Load MySQL Driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/campaign_connect", "root", "root");

        // Query to check username, email, and password together
        String query = "SELECT * FROM organizations WHERE username = ? AND email = ? AND password = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, username);
        pstmt.setString(2, email);
        pstmt.setString(3, password);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            // Login success - Set session attribute
            session.setAttribute("organizerUsername", username);

            // Redirect to organizer panel
            response.sendRedirect("organizer.jsp");
        } else {
            // Invalid credentials
            out.println("<script>alert('Invalid Username, Email, or Password!'); window.location='login.html';</script>");
        }
    } catch (Exception e) {
        out.println("<script>alert('Database Connection Error!'); window.location='login.html';</script>");
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>
