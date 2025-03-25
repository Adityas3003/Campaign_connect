<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");
    String title = request.getParameter("title");
    String description = request.getParameter("description");
    String date = request.getParameter("date");
    String location = request.getParameter("location");
    String roles = request.getParameter("roles");
    String imageUrl = request.getParameter("image_url");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/campaign_connect", "root", "root");

        String sql = "UPDATE campaigns SET title=?, description=?, date=?, location=?, roles=?, image_url=? WHERE id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, title);
        pstmt.setString(2, description);
        pstmt.setString(3, date);
        pstmt.setString(4, location);
        pstmt.setString(5, roles);
        pstmt.setString(6, imageUrl);
        pstmt.setInt(7, Integer.parseInt(id));

        int result = pstmt.executeUpdate();
        if (result > 0) {
            out.println("<script>alert('Campaign updated successfully!'); window.location='organizercampview.jsp';</script>");
        } else {
            out.println("<script>alert('Failed to update campaign.'); window.history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('Error: " + e.getMessage() + "'); window.history.back();</script>");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
