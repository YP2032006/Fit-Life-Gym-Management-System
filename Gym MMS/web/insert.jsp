<%-- 
    Document   : insert
    Created on : Nov 14, 2025, 10:07:21 AM
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
    <title>Insert Member - FitLife Gym Management</title>
    <style>
        html, body {
            margin: 0; padding: 0;
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

        .form-container {
            background: rgba(0, 0, 0, 0.6);
            width: 550px;
            margin: 50px auto;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.5);
        }

        label {
            display: block;
            text-align: left;
            font-weight: bold;
            margin: 10px 0 5px;
        }

        input[type="text"], input[type="number"], input[type="date"], select {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: none;
            margin-bottom: 15px;
        }

        input[type="submit"], input[type="reset"] {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        input[type="submit"] { background-color: #4CAF50; color: white; }
        input[type="submit"]:hover { background-color: #45a049; }

        input[type="reset"] { background-color: #f44336; color: white; }
        input[type="reset"]:hover { background-color: #da190b; }

        .message {
            text-align: center;
            margin-top: 20px;
            font-size: 18px;
            color: #00ff00;
        }

        a { color: #4CAF50; text-decoration: none; }
    </style>
</head>
<body>

<h2>FitLife Gym Management - Insert Member</h2>
<%@ include file="navpage.html" %>

<div class="form-container">
    <form method="post">
        <label>Member ID:</label>
        <input type="text" name="member_id" maxlength="10" required>

        <label>Full Name:</label>
        <input type="text" name="full_name" maxlength="50" required>

        <label>Age:</label>
        <input type="number" name="age" required>

        <label>Gender:</label>
        <select name="gender">
            <option value="">Select</option>
            <option value="M">Male</option>
            <option value="F">Female</option>
        </select>

        <label>Phone:</label>
        <input type="text" name="phone" maxlength="20" required>

        <label>Email:</label>
        <input type="text" name="email" maxlength="50">

        <label>Address:</label>
        <input type="text" name="address" maxlength="100">

        <label>Membership Type:</label>
        <input type="text" name="membership_type" maxlength="20" required>

        <label>Join Date:</label>
        <input type="date" name="join_date" required>

        <label>Expiry Date:</label>
        <input type="date" name="expiry_date">

        <label>Status:</label>
        <input type="text" name="status" maxlength="20">

        <label>Emergency Contact:</label>
        <input type="text" name="emergency_contact" maxlength="50">

        <label>Last Payment Date:</label>
        <input type="date" name="last_payment_date">

        <input type="reset" value="Reset">
        <input type="submit" value="Add Member">
    </form>

    <%
        String member_id = request.getParameter("member_id");
        if(member_id != null){
            try{
                AS400JDBCDriver driver = new AS400JDBCDriver();
                DriverManager.registerDriver(driver);
                String url = "jdbc:as400:deathstar.gtc.edu;prompt=false";
                Connection conn = DriverManager.getConnection(url, user, pass);

                String sql = "INSERT INTO MEMBERS (MEMBER_ID, FULL_NAME, AGE, GENDER, PHONE, EMAIL, ADDRESS, MEMBERSHIP_TYPE, JOIN_DATE, EXPIRY_DATE, STATUS, EMERGENCY_CONTACT, LAST_PAYMENT_DATE) "
                           + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, member_id);
                ps.setString(2, request.getParameter("full_name"));
                ps.setInt(3, Integer.parseInt(request.getParameter("age")));
                ps.setString(4, request.getParameter("gender"));
                ps.setString(5, request.getParameter("phone"));
                ps.setString(6, request.getParameter("email"));
                ps.setString(7, request.getParameter("address"));
                ps.setString(8, request.getParameter("membership_type"));
                ps.setDate(9, java.sql.Date.valueOf(request.getParameter("join_date")));
                
                String expiry = request.getParameter("expiry_date");
                if(expiry != null && !expiry.isEmpty())
                    ps.setDate(10, java.sql.Date.valueOf(expiry));
                else
                    ps.setNull(10, java.sql.Types.DATE);

                ps.setString(11, request.getParameter("status"));
                ps.setString(12, request.getParameter("emergency_contact"));

                String lastPayment = request.getParameter("last_payment_date");
                if(lastPayment != null && !lastPayment.isEmpty())
                    ps.setDate(13, java.sql.Date.valueOf(lastPayment));
                else
                    ps.setNull(13, java.sql.Types.DATE);

                int rows = ps.executeUpdate();
                if(rows > 0){
                    out.println("<div class='message'>Member inserted successfully!</div>");
                } else {
                    out.println("<div class='message' style='color:red;'>Failed to insert member.</div>");
                }
                ps.close();
                conn.close();
            } catch(Exception ex){
                out.println("<div class='message' style='color:red;'>"+ex.getMessage()+"</div>");
            }
        }
    %>
</div>

</body>
</html>
