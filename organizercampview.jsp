<%@ page import="java.sql.*" %>
<%@ page import="java.io.*, javax.servlet.*, javax.servlet.http.*" %>

<%
    // Get the logged-in organizer's username
    String organizerUsername = (String) session.getAttribute("organizerUsername");
    if (organizerUsername == null) {
        response.sendRedirect("login.html");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/campaign_connect", "root", "root");

        // Fetch campaigns only for the logged-in organizer
        String sql = "SELECT * FROM campaigns WHERE organizer = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, organizerUsername);
        rs = pstmt.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Campaigns</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            text-align: center;
        }
        h2 {
            color: #333;
        }
        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #007BFF;
            color: white;
        }
        img {
            border-radius: 5px;
        }
        .action-btn {
            padding: 8px 12px;
            margin: 5px;
            border: none;
            cursor: pointer;
            color: white;
            text-decoration: none;
            display: inline-block;
        }
        .edit-btn {
            background-color: #28a745;
        }
        .delete-btn {
            background-color: #dc3545;
        }
    </style>
</head>
<body>
    <h2>My Campaigns</h2>
    <table>
        <tr>
            <th>Title</th>
            <th>Description</th>
            <th>Date</th>
            <th>Location</th>
            <th>Roles</th>
            <th>Image</th>
            <th>Actions</th>
        </tr>
        <%
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("title") %></td>
            <td><%= rs.getString("description") %></td>
            <td><%= rs.getDate("date") %></td>
            <td><%= rs.getString("location") %></td>
            <td><%= rs.getString("roles") %></td>
            <td><img src="<%= rs.getString("image_url") %>" width="100" height="100"></td>
            <td>
                <a href="edit_campaign.jsp?id=<%= rs.getInt("id") %>" class="action-btn edit-btn">Edit</a>
                <a href="delete_campaign.jsp?id=<%= rs.getInt("id") %>" class="action-btn delete-btn" onclick="return confirm('Are you sure you want to delete this campaign?');">Delete</a>
            </td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
