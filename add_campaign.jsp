<%@ page import="java.sql.*" %>
<%@ page import="java.io.*, javax.servlet.*, javax.servlet.http.*" %>

<%
    // Get form parameters
    String title = request.getParameter("title");
    String description = request.getParameter("description");
    String dateStr = request.getParameter("date");
    String location = request.getParameter("location");
    String roles = request.getParameter("roles");
    String imageUrl = request.getParameter("image_url");

    // Get organizer's username from session
    String organizerUsername = (String) session.getAttribute("organizerUsername");
    if (organizerUsername == null) {
        response.sendRedirect("login.html");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Convert date string to SQL Date
        java.sql.Date sqlDate = java.sql.Date.valueOf(dateStr);

        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/campaign_connect", "root", "root");

        // Insert campaign data into database
        String sql = "INSERT INTO campaigns (title, description, date, location, roles, image_url, organizer) VALUES (?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, title);
        pstmt.setString(2, description);
        pstmt.setDate(3, sqlDate);
        pstmt.setString(4, location);
        pstmt.setString(5, roles);
        pstmt.setString(6, imageUrl);
        pstmt.setString(7, organizerUsername);  // Store organizer's username

        int result = pstmt.executeUpdate();
        if (result > 0) {
            out.println("<script>alert('Campaign added successfully!'); window.location='organizercampview.jsp';</script>");
        } else {
            out.println("<script>alert('Failed to add campaign.'); window.history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('Error: " + e.getMessage().replace("'", "\\'") + "'); window.history.back();</script>");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
