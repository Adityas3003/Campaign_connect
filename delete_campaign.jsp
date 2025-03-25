<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/campaign_connect", "root", "root");

        String sql = "DELETE FROM campaigns WHERE id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(id));

        int result = pstmt.executeUpdate();
        if (result > 0) {
            out.println("<script>alert('Campaign deleted successfully!'); window.location='organizercampview.jsp';</script>");
        } else {
            out.println("<script>alert('Failed to delete campaign.'); window.history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('Error: " + e.getMessage() + "'); window.history.back();</script>");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
