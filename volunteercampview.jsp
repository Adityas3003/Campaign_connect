<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    // Check if the volunteer is logged in
    String volunteerUsername = (String) session.getAttribute("volunteerUsername");
    if (volunteerUsername == null) {
        response.sendRedirect("login.jsp"); // Redirect to login if not logged in
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Campaigns</title>
    <link rel="icon" href="https://yt3.ggpht.com/a/AGF-l78km1YyNXmF0r3-0CycCA0HLA_i6zYn_8NZEg=s900-c-k-c0xffffffff-no-rj-mo" type="image/gif" sizes="16x16">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Poppins', sans-serif;
            color: #333;
            background: url(https://images.unsplash.com/photo-1508615039623-a25605d2b022?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D);
        }
        .container {
            width: 90%;
            max-width: 1200px;
            margin: 100px auto 50px;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .user-info {
            font-size: 18px;
            font-weight: bold;
            color: #007bff;
        }
        .logout-btn {
            background: crimson;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        .logout-btn:hover {
            background: darkred;
            transform: scale(1.05);
        }
        .cards {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        .card {
            background: white;
            width: 300px;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .card-content {
            padding: 15px;
            text-align: center;
        }
        .card h3 {
            margin: 10px 0;
            font-size: 20px;
            color: #007bff;
        }
        .card p {
            font-size: 14px;
            color: #555;
        }
        .join-btn {
            display: block;
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            padding: 10px;
            text-align: center;
            border-radius: 5px;
            margin-top: 10px;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s ease;
        }
        .join-btn:hover {
            background: linear-gradient(135deg, #0056b3, #003d80);
            transform: scale(1.05);
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <div class="user-info">Welcome, <%= volunteerUsername %>!</div>
        <button class="logout-btn" onclick="logout()"><i class="fas fa-sign-out-alt"></i> Logout</button>
    </div>

    <h2 style="text-align: center; color: #333;">Join a Campaign</h2><br>

    <div class="cards">
        <%
            Connection conn = null; 
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/campaign_connect", "root", "root");
                ps = conn.prepareStatement("SELECT * FROM campaigns");
                rs = ps.executeQuery();
                while (rs.next()) { 
        %>
        <div class="card">
            <img src="<%= rs.getString("image_url") %>" alt="Campaign Image">
            <div class="card-content">
                <h3><%= rs.getString("title") %></h3>
                <p><%= rs.getString("description") %></p>
                <p><strong>Date:</strong> <%= rs.getString("date") %></p>
                <p><strong>Location:</strong> <%= rs.getString("location") %></p>
                <p><strong>Roles:</strong> <%= rs.getString("roles") %></p>
                <a href="joincampaign.jsp?campaignId=<%= rs.getInt("id") %>" class="join-btn">Join Now</a>
            </div>
        </div>
        <% } } catch (Exception e) { e.printStackTrace();
            } finally { if (rs != null) rs.close(); if (ps != null) ps.close(); if (conn != null) conn.close(); }
        %>
    </div>
</div>

<script>
    function logout() {
        if (confirm("Are you sure you want to logout?")) {
            window.location.href = "index.html";
        }
    }
</script>

</body>
</html>
