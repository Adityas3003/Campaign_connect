<%@ page import="java.sql.*" %>
<%
String username = request.getParameter("username");
String email = request.getParameter("email");
String password = request.getParameter("password");
boolean userExists = false;
boolean emailCorrect = false;
boolean passwordCorrect = false;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/campaign_connect", "root", "root");

    // Check if username exists
    String query = "SELECT email, password FROM volunteers WHERE username = ?";
    PreparedStatement ps = con.prepareStatement(query);
    ps.setString(1, username);
    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        userExists = true;
        String dbEmail = rs.getString("email");
        String dbPassword = rs.getString("password");

        if (dbEmail.equals(email)) {
            emailCorrect = true;
        }
        if (dbPassword.equals(password)) {
            passwordCorrect = true;
        }
    }

    rs.close();
    ps.close();
    con.close();
} catch (Exception e) {
    e.printStackTrace();
}

if (!userExists) {
    out.println("<script>alert('Username is incorrect!'); window.location.href='login.html';</script>");
} else if (!emailCorrect) {
    out.println("<script>alert('Email does not match our records!'); window.location.href='login.html';</script>");
} else if (!passwordCorrect) {
    out.println("<script>alert('Password is incorrect!'); window.location.href='login.html';</script>");
} else {
    session.setAttribute("volunteerUsername", username);
    response.sendRedirect("volunteercampview.jsp"); // Redirect to volunteer dashboard
}
%>
