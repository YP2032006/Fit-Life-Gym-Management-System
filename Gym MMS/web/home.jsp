<%-- 
    Document   : home
    Created on : Nov 14, 2025, 9:38:46 AM
    Author     : yp203
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // validation
    String user = (String) session.getAttribute("username");
    if (user == null) {
        response.sendRedirect("index.html");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="icon" type="image/x-icon" href="Images/icon.ico"/>
    <title>Gym Home</title>
    <style>
        
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            font-family: Tahoma, sans-serif;
            color: white;
            text-align: center;
            background: url("Images/gym_bg2.jpg") no-repeat center center fixed;
            background-size: cover;
        }

        h2 {
            margin-top: 30px;
            font-size: 45px;
            text-shadow: 0px 2px 3px #000;
            font-variant: small-caps;
            letter-spacing: 2px;
        }

        .message-box {
            margin: 60px auto;
            width: 700px;
            padding: 30px;
            background: rgba(255, 255, 255, 0.15);
            border-radius: 15px;
            backdrop-filter: blur(30px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.5);
        }

        h3 {
            font-size: 32px;
            text-shadow: 0px 2px 3px #000;
            margin-bottom: 15px;
        }

        p {
            font-size: 18px;
            margin-top: 10px;
        }

        a {
            color: #fff;
            text-decoration: none;
            margin: 0 15px;
            font-weight: bold;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <h2>FitLife Gym Management</h2>

    <%@ include file="navpage.html" %>

    <div class="message-box">
        <h3>SUCCESS!!</h3>
        <p>Welcome <b><%= user %></b>, you are successfully logged in.</p>
         <h3>About FitLife Gym MMS</h3>
          <p>
        At FitLife Gym, our mission is to help individuals realize their highest potential 
        through fitness, discipline, and motivation-supported by a smooth digital 
        management system that simplifies daily operations.
         </p>
         <p>
        This Gym Management System helps staff manage members, membership plans, 
        renewals, payments, and gym records quickly and efficiently.
         </p>
         <p>
        Use the navigation bar above to add new members, update member information,
        delete accounts, or view complete member reports.
         </p>
         <p>
        FitLife MMS improves accuracy, saves time, and keeps your gym running smoothly.
         </p>
    </div>

</body>
</html>