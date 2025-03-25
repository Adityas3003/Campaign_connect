<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Reset Password - Volunteer</title>
</head>
<body>
<%
    String email = request.getParameter("email");
    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmPassword");

    if (email != null && newPassword != null && confirmPassword != null) {
        if (!newPassword.equals(confirmPassword)) {
            out.println("<script>alert('Passwords do not match!'); window.history.back();</script>");
        } else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/campaign_connect", "root", "root");
                
                // Check if email exists
                PreparedStatement checkStmt = con.prepareStatement("SELECT * FROM organizations WHERE email=?");
                checkStmt.setString(1, email);
                ResultSet rs = checkStmt.executeQuery();

                if (rs.next()) {
                    // Update password
                    PreparedStatement updateStmt = con.prepareStatement("UPDATE organizations SET password=? WHERE email=?");
                    updateStmt.setString(1, newPassword);
                    updateStmt.setString(2, email);
                    int updated = updateStmt.executeUpdate();

                    if (updated > 0) {
                        out.println("<script>alert('Password updated successfully!'); window.location='login.html';</script>");
                    } else {
                        out.println("<script>alert('Failed to update password!'); window.history.back();</script>");
                    }
                } else {
                    out.println("<script>alert('Email not found!'); window.history.back();</script>");
                }
                
                con.close();
            } catch (Exception e) {
                out.println("<script>alert('Database Error: " + e.getMessage() + "'); window.history.back();</script>");
            }
        }
    }
%>
</body>
</html>
