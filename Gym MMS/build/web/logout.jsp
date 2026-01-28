<%-- 
    Document   : logout
    Created on : Nov 14, 2025, 9:52:55 AM
    Author     : yp203
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // End the session
    session.invalidate();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="icon" type="image/x-icon" href="Images/icon.ico"/>
    <title>Logout - FitLife Gym Management</title>
    <meta http-equiv="refresh" content="3;URL=index.html"> <!-- Auto redirect after 3 seconds -->
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            font-family: Tahoma, sans-serif;
            color: white;
            text-align: center;
            background: url("Images/gym_bg.jpg") no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }

        .logout-box {
            background: rgba(0, 0, 0, 0.6);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.5);
        }

        h2 {
            font-size: 36px;
            margin-bottom: 15px;
            text-shadow: 0 2px 3px #000;
        }

        p {
            font-size: 18px;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="logout-box">
        <h2>Logged Out Successfully!</h2>
        <p>You will be redirected to the login page shortly.</p>
        <p>If not, <a href="index.html" style="color: #4CAF50;">click here</a>.</p>
    </div>
</body>
</html>

