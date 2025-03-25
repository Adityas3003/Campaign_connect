<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Campaign Connect Feedback</title>
    <link rel="stylesheet" href="feedback.css">
    <link rel="icon" href="https://yt3.ggpht.com/a/AGF-l78km1YyNXmF0r3-0CycCA0HLA_i6zYn_8NZEg=s900-c-k-c0xffffffff-no-rj-mo" type="image/gif" sizes="16x16">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
    <div class="feedback-form">
        <div class="icons">
            <a class="icons" href="index.html" title="Home"><i class="fas fa-home"></i></a>
        </div>
        <h2>Feedback Form</h2>

        <form action="feedback.jsp" method="POST">
            <input type="text" id="name" name="name" placeholder="Your Name" required>
            <input type="email" id="email" name="email" placeholder="Your Email" required>
            <div class="star-rating">
                <input type="radio" id="star5" name="rating" value="5" required />
                <label for="star5" title="5 stars">&#9733;</label>
                <input type="radio" id="star4" name="rating" value="4" />
                <label for="star4" title="4 stars">&#9733;</label>
                <input type="radio" id="star3" name="rating" value="3" />
                <label for="star3" title="3 stars">&#9733;</label>
                <input type="radio" id="star2" name="rating" value="2" />
                <label for="star2" title="2 stars">&#9733;</label>
                <input type="radio" id="star1" name="rating" value="1" />
                <label for="star1" title="1 star">&#9733;</label>
            </div>
            <textarea id="comments" name="comments" placeholder="Your feedback..." required></textarea>
            <button type="submit">Submit Feedback</button>
        </form>
    </div>

<%  
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String rating = request.getParameter("rating");
        String comments = request.getParameter("comments");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/campaign_connect", "root", "root"); 

            String sql = "INSERT INTO feedback (name, email, rating, comments) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setInt(3, Integer.parseInt(rating));
            stmt.setString(4, comments);

            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                out.println("<script>alert('Thank you for your feedback!'); window.location.href='index.html';</script>");
            } else {
                out.println("<script>alert('Failed to submit feedback. Please try again later.'); window.location.href='feedback.html';</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error occurred while submitting feedback. Please try again.'); window.location.href='feedback.html';</script>");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }
        }
    }
%>

</body>
</html>
