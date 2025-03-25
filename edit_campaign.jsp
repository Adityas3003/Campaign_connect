<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String id = request.getParameter("id");
    String title = "";
    String description = "";
    String date = "";
    String location = "";
    String roles = "";
    String imageUrl = "";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/campaign_connect", "root", "root");
        
        String sql = "SELECT * FROM campaigns WHERE id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(id));
        rs = pstmt.executeQuery();

        if (rs.next()) {
            title = rs.getString("title");
            description = rs.getString("description");
            date = rs.getString("date");
            location = rs.getString("location");
            roles = rs.getString("roles");
            imageUrl = rs.getString("image_url");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Campaign</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Poppins', sans-serif;
            background: transparent;
            color: #333;
        }
        .form-container {
            width: 100%;
            max-width: 600px;
            margin: auto;
            background: whitesmoke;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
            text-align: left;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #0056b3;
        }
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
            color: #333;
        }
        input, textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn {
            display: block;
            width: 100%;
            margin-top: 20px;
            padding: 12px;
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 8px;
            font-size: 16px;
            transition: 0.3s ease;
        }
        .btn:hover {
            background: linear-gradient(135deg, #0056b3, #003d80);
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Edit Campaign</h2>
        <form action="update_campaign.jsp" method="post">
            <input type="hidden" name="id" value="<%= id %>">
            
            <label>Title:</label>
            <input type="text" name="title" value="<%= title %>" required>

            <label>Description:</label>
            <textarea name="description" required><%= description %></textarea>

            <label>Date:</label>
            <input type="date" name="date" value="<%= date %>" required>

            <label>Location:</label>
            <input type="text" name="location" value="<%= location %>" required>

            <label>Roles:</label>
            <textarea name="roles" required><%= roles %></textarea>

            <label>Image URL:</label>
            <input type="text" name="image_url" value="<%= imageUrl %>">

            <button type="submit" class="btn">Update Campaign</button>
        </form>
    </div>
</body>
</html>
