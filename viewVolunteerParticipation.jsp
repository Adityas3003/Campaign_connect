<%@ page import="java.sql.*, javax.mail.*, javax.mail.internet.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Volunteers & Campaigns</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
        }
        .container {
            width: 80%;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background: #007bff;
            color: white;
        }
        .reminder-btn {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
        }
        .reminder-btn:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Volunteers Who Joined Campaigns</h2>
    <table>
        <tr>
            <th>Volunteer Name</th>
            <th>Email</th>
            <th>Campaign Title</th>
          <!--    <th>Action</th> -->
        </tr>
        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/campaign_connect", "root", "root");

                // Fetch volunteer names, emails, and campaign titles
                String query = "SELECT v.username, v.email, c.title, v.id FROM campaign_volunteers cv " +
                               "JOIN volunteers v ON cv.volunteer_id = v.id " +
                               "JOIN campaigns c ON cv.campaign_id = c.id";

                ps = conn.prepareStatement(query);
                rs = ps.executeQuery();

                while (rs.next()) {
                    String volunteerId = rs.getString("id");
        %>
                <tr>
                    <td><%= rs.getString("username") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("title") %></td>
                  <!--    <td>
                        <form action="sendreminder.jsp" method="post">
                            <input type="hidden" name="volunteerEmail" value="<%= rs.getString("email") %>">
                            <input type="hidden" name="volunteerId" value="<%= volunteerId %>">
                            <button type="submit" class="reminder-btn">Send Reminder</button>
                        </form>
                    </td>
                    -->
                </tr>
        <%
                }
            } catch (Exception e) {
                out.print("<tr><td colspan='4' style='color: red;'>Error loading data: " + e.getMessage() + "</td></tr>");
            } finally {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            }
        %>
    </table>

    <br>
</div>

</body>
</html>
