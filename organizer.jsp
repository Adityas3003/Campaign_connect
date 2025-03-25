<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    String organizerUsername = (String) session.getAttribute("organizerUsername");
    if (organizerUsername == null) {
        response.sendRedirect("login.html"); // Redirect if not logged in
        return;
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Organizer Panel</title>
    <!-- Favicon -->
    <link rel="icon" href="https://yt3.ggpht.com/a/AGF-l78km1YyNXmF0r3-0CycCA0HLA_i6zYn_8NZEg=s900-c-k-c0xffffffff-no-rj-mo" type="image/gif" sizes="16x16">
    <!-- Font Awesome for icons -->
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
        .header-container {
            width: 100%;
            background: #fff;
            padding: 15px 0;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
        }
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: auto;
            padding: 0 20px;
        }
        .logo {
            font-size: 26px;
            font-weight: bold;
            color: #222;
        }
        .logo span {
            color: #f8a900;
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .user-info span {
            font-size: 16px;
            font-weight: bold;
            color: #007bff;
        }
        .logout-btn {
            background: none;
            border: none;
            color: #333;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 5px;
            transition: all 0.3s ease-in-out;
        }
        .logout-btn:hover {
            color: #fc5711f9;
        }
        .logout-btn i {
            font-size: 18px;
        }
        .container {
            max-width: 80%;
            margin: 150px auto 50px;
            background: white;
            padding: 10px;
            border-radius: 12px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .btn-container {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 20px;
        }
        .btn {
            padding: 15px 30px;
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 8px;
            font-size: 18px;
            transition: all 0.3s;
            box-shadow: 0 4px 8px rgba(0, 123, 255, 0.3);
        }
        .btn:hover {
            background: linear-gradient(135deg, #0056b3, #003d80);
            transform: translateY(-2px);
        }
        .content {
            margin-top: 30px;
            padding: 20px;
            background: whitesmoke;
            border-radius: 12px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            min-height: 400px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        iframe {
            width: 100%;
            min-height: 400px;
            border: none;
        }
    </style>
</head>
<body>
    <div class="header-container">
        <header>
            <div class="logo">Campaign Connect<span>●</span></div>
            <!-- Show logged-in organizer -->
            <div class="user-info">
                <span>Welcome, <%= organizerUsername %> 👋</span>
                <button class="logout-btn" onclick="logout()">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </button>
            </div>
        </header>
    </div>
    <div class="container">
        <h1>Organizer Panel</h1>
        <div class="btn-container">
            <button class="btn" onclick="showPage('camp_add.html')">Add Campaign</button>
            <button class="btn" onclick="showPage('organizercampview.jsp')">View Campaign</button>
        </div>
        <div class="content" id="content-area">
            <p>Select an option to proceed.</p>
        </div>
    </div>

    <script>
        function showPage(page) {
            document.getElementById('content-area').innerHTML = 
                '<iframe src="' + page + '"></iframe>';
        }

        function logout() {
            sessionStorage.clear();
            localStorage.clear();
            window.location.href = "login.html";
        }
    </script>
</body>
</html>
