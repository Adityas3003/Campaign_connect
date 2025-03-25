<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    String volunteerUsername = (String) session.getAttribute("volunteerUsername");
    String campaignId = request.getParameter("campaignId");

    if (volunteerUsername == null) {
        response.sendRedirect("login.html");
        return;
    }

    if (campaignId == null) {
        out.print("Invalid request.");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    boolean alreadyJoined = false;
    boolean success = false;
    String message = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/campaign_connect", "root", "root");

        ps = conn.prepareStatement("SELECT id FROM volunteers WHERE username = ?");
        ps.setString(1, volunteerUsername);
        rs = ps.executeQuery();

        int volunteerId = -1;
        if (rs.next()) {
            volunteerId = rs.getInt("id");
        }

        if (volunteerId == -1) {
            message = "Error: Volunteer not found.";
        } else {
            ps = conn.prepareStatement("SELECT * FROM campaign_volunteers WHERE volunteer_id = ? AND campaign_id = ?");
            ps.setInt(1, volunteerId);
            ps.setString(2, campaignId);
            rs = ps.executeQuery();

            if (rs.next()) {
                alreadyJoined = true;
                message = "You have already joined this campaign. Any updates will be sent to your email.";
            } else {
                ps = conn.prepareStatement("INSERT INTO campaign_volunteers (volunteer_id, campaign_id) VALUES (?, ?)");
                ps.setInt(1, volunteerId);
                ps.setString(2, campaignId);
                int rows = ps.executeUpdate();

                if (rows > 0) {
                    success = true;
                    message = "You have successfully joined the campaign! Updates will be sent to your email.";
                } else {
                    message = "Failed to join the campaign. Please try again.";
                }
            }
        }
    } catch (Exception e) {
        message = "Error: " + e.getMessage();
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Campaign Join Status</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background: rgba(0, 0, 0, 0.7);
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .popup {
            background: white;
            padding: 20px;
            width: 350px;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
            position: relative;
        }
        .popup h2 {
            margin: 0;
            font-size: 22px;
            color: <%= success ? "#28a745" : "crimson" %>;
        }
        .popup p {
            font-size: 16px;
            color: #555;
            margin: 10px 0 20px;
        }
        .popup button {
            background: <%= success ? "#28a745" : "crimson" %>;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        .popup button:hover {
            background: <%= success ? "#218838" : "darkred" %>;
            transform: scale(1.05);
        }
    </style>
</head>
<body>

<div class="popup">
    <h2><%= success ? "Success!" : "Notice" %></h2>
    <p><%= message %></p>
    <button onclick="redirect()">OK</button>
</div>

<script>
    function redirect() {
        window.location.href = "volunteercampview.jsp";
    }
</script>

</body>
</html>
