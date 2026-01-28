<%-- 
    Document   : sessionpage
    Created on : Nov 14, 2025, 9:30:25 AM
    Author     : yp203
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="icon" type="image/x-icon" href="Images/icon.ico"/>
    <title>Processing...</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #0d47a1, #1976d2);
            color: white;
        }
        .loader-box {
            text-align: center;
            animation: fadeIn 1.5s ease-in-out;
        }
        .loader {
            border: 6px solid rgba(255,255,255,0.3);
            border-top: 6px solid white;
            border-radius: 50%;
            width: 55px;
            height: 55px;
            animation: spin 1s linear infinite;
            margin: auto;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
</head>
<body>

<div class="loader-box">
    <div class="loader"></div>
    <h2>Looking up...</h2>
</div>

<%
    String uname = request.getParameter("username");
    String pass = request.getParameter("pass");

    if (uname != null && !uname.isEmpty() &&
        pass != null && !pass.isEmpty()) {

        // Store session variables
        session.setAttribute("username", uname);
        session.setAttribute("password", pass);

        // Redirect to home page
        response.setHeader("Refresh", "1; URL=home.jsp");
    } else {
        // Redirect back to login page
        response.setHeader("Refresh", "1; URL=index.html");
    }
%>

</body>
</html>

