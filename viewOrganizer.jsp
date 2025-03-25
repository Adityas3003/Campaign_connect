<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Organizations</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        .table-container {
            width: 90%;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background: #f9f9f9;
        }
        tr:hover {
            background: #f1f1f1;
        }
        .error {
            color: red;
            text-align: center;
            font-weight: bold;
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <h2>View Organizations</h2>
    <div class="table-container">
        <table>
            <tr>
                <th>ID</th><th>Name</th><th>Email</th><th>Username</th><th>Location</th><th>Registered At</th>
            </tr>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/campaign_connect", "root", "root");
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM organizations");
                    while (rs.next()) {
            %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("org_name") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td><%= rs.getString("username") %></td>
                            <td><%= rs.getString("location") %></td>
                            <td><%= rs.getString("registered_at") %></td>
                        </tr>
            <%
                    }
                    con.close();
                } catch (Exception e) {
            %>
                <p class="error">Error: <%= e.getMessage() %></p>
            <%
                }
            %>
        </table>
    </div>

</body>
</html>
