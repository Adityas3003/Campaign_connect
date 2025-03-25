<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Campaigns</title>
    <link rel="icon" href="https://yt3.ggpht.com/a/AGF-l78km1YyNXmF0r3-0CycCA0HLA_i6zYn_8NZEg=s900-c-k-c0xffffffff-no-rj-mo" type="image/gif" sizes="16x16">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .container {
            width: 80%;
            margin: 50px auto;
            background: whitesmoke;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background: teal;
            color: white;
        }
        .btn {
            padding: 8px 12px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }
        .btn:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>View Campaigns</h2>
    <table>
        <thead>
            <tr>
                <th>Image</th>
                <th>Title</th>
                <th>Description</th>
                <th>Date</th>
                <th>Location</th>
                <th>Roles</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% 
               Connection conn = null; 
               Statement stmt = null; 
               ResultSet rs = null;
               try {
                   Class.forName("com.mysql.cj.jdbc.Driver");
                   conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/campaign_connect", "root", "root");
                   stmt = conn.createStatement();
                   rs = stmt.executeQuery("SELECT * FROM campaigns");
                   while (rs.next()) { %>
            <tr>
                <td><img src="<%= rs.getString("image_url") %>" alt="Campaign Image" width="100"></td>
                <td><%= rs.getString("title") %></td>
                <td><%= rs.getString("description") %></td>
                <td><%= rs.getString("date") %></td>
                <td><%= rs.getString("location") %></td>
                <td><%= rs.getString("roles") %></td>
                <td>
                    <a href="becomeVolunteer.html" class="btn">Join</a><br><br>
                    
                </td>
               
            </tr>
            <% } } catch (Exception e) { e.printStackTrace();
               } finally { if (rs != null) rs.close(); if (stmt != null) stmt.close(); if (conn != null) conn.close(); }
            %>
        </tbody>
    </table>
</div>

</body>
</html>
