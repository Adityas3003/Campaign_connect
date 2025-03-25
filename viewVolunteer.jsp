<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Volunteers</title>
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
        /* Styling for Download PDF Button */
        .btn {
            display: block;
            width: 200px;
            margin: 20px auto;
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background: #007bff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
        }
        .btn:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>

    <h2>View Volunteers</h2>
    <div class="table-container">
        <table>
            <tr>
                <th>ID</th><th>Name</th><th>Email</th><th>Username</th><th>Location</th><th>Contact</th><th>Registered At</th>
            </tr>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/campaign_connect", "root", "root");
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM volunteers");
                    while (rs.next()) {
            %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("full_name") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td><%= rs.getString("username") %></td>
                            <td><%= rs.getString("location") %></td>
                            <td><%= rs.getString("contact_no") %></td>
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

    <!-- Download PDF Button -->
    <!-- <button class="btn" onclick="printPage()">Download PDF</button>

    <script>
        function printPage() {
            window.print();
        }
    </script> -->

</body>
</html>
