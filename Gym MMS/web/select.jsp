<%-- 
    Document   : insert
    Created on : Nov 14, 2025, 10:07:21 AM
    Author     : yp203
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.ibm.as400.access.*" %>

<%
    // Session validation
    String user = (String) session.getAttribute("username");
    String pass = (String) session.getAttribute("password");
    if(user == null || pass == null){
        response.sendRedirect("index.html");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="icon" type="image/x-icon" href="Images/icon.ico"/>
    <title>View Members - FitLife Gym Management</title>

    <style>
        html, body {
            margin: 0;
            padding: 0;
            font-family: Tahoma, sans-serif;
            height: 100%;
            background: url("Images/gym_bg2.jpg") no-repeat center center fixed;
            background-size: cover;
            color: white;
        }

        h2 {
            text-align: center;
            margin-top: 30px;
            font-size: 40px;
            font-variant: small-caps;
            letter-spacing: 2px;
            text-shadow: 0px 2px 3px #000;
        }

        .table-container {
            width: 95%;
            max-width: 1200px;
            margin: 30px auto;
            background: rgba(0,0,0,0.75);
            border-radius: 12px;
            padding: 20px;
            overflow-x: auto;
            backdrop-filter: blur(6px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.6);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            border: 1px solid #4CAF50;
            padding: 10px 12px;
            text-align: left;
            font-size: 14px;
            white-space: nowrap;
        }

        th {
            background: linear-gradient(135deg, #4CAF50, #2e7d32);
            color: white;
            text-transform: uppercase;
            letter-spacing: 1px;
            position: sticky;
            top: 0;
            z-index: 2;
        }

        tr {
            transition: all 0.25s ease-in-out;
        }

        tr:nth-child(even) {
            background-color: rgba(255,255,255,0.08);
        }

        tr:hover {
            background-color: rgba(76, 175, 80, 0.35);
            transform: scale(1.01);
        }

        a {
            color: #4CAF50;
            text-decoration: none;
        }

        /* Scrollbar styling */
        .table-container::-webkit-scrollbar {
            height: 8px;
        }

        .table-container::-webkit-scrollbar-track {
            background: rgba(255,255,255,0.1);
        }

        .table-container::-webkit-scrollbar-thumb {
            background: #4CAF50;
            border-radius: 10px;
        }
    </style>
</head>

<body>

<h2>FitLife Gym Management - Members List</h2>
<%@ include file="navpage.html" %>

<div class="table-container">
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    try{
        AS400JDBCDriver driver = new AS400JDBCDriver();
        DriverManager.registerDriver(driver);
        String url = "jdbc:as400:deathstar.gtc.edu;prompt=false";
        conn = DriverManager.getConnection(url, user, pass);
        stmt = conn.createStatement();

        String sql = "SELECT * FROM MEMBERS ORDER BY FULL_NAME";
        rs = stmt.executeQuery(sql);
%>
    <table>
        <tr>
            <th>ID</th>
            <th>Full Name</th>
            <th>Age</th>
            <th>Gender</th>
            <th>Phone</th>
            <th>Email</th>
            <th>Address</th>
            <th>Membership Type</th>
            <th>Join Date</th>
            <th>Expiry Date</th>
            <th>Status</th>
            <th>Emergency Contact</th>
            <th>Last Payment</th>
        </tr>
<%
        while(rs.next()){
            out.println("<tr>");
            out.println("<td>" + rs.getString("MEMBER_ID") + "</td>");
            out.println("<td>" + rs.getString("FULL_NAME") + "</td>");
            out.println("<td>" + rs.getInt("AGE") + "</td>");
            out.println("<td>" + rs.getString("GENDER") + "</td>");
            out.println("<td>" + rs.getString("PHONE") + "</td>");
            out.println("<td>" + rs.getString("EMAIL") + "</td>");
            out.println("<td>" + rs.getString("ADDRESS") + "</td>");
            out.println("<td>" + rs.getString("MEMBERSHIP_TYPE") + "</td>");
            out.println("<td>" + rs.getDate("JOIN_DATE") + "</td>");
            out.println("<td>" + rs.getDate("EXPIRY_DATE") + "</td>");
            out.println("<td>" + rs.getString("STATUS") + "</td>");
            out.println("<td>" + rs.getString("EMERGENCY_CONTACT") + "</td>");
            out.println("<td>" + rs.getDate("LAST_PAYMENT_DATE") + "</td>");
            out.println("</tr>");
        }
    } catch(Exception ex){
        out.println("<tr><td colspan='13' style='color:red; text-align:center;'>" + ex.getMessage() + "</td></tr>");
    } finally {
        if(rs != null) rs.close();
        if(stmt != null) stmt.close();
        if(conn != null) conn.close();
    }
%>
    </table>
</div>

</body>
</html>
