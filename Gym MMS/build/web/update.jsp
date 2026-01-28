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
    <title>Update Member - FitLife Gym Management</title>
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
            background: rgba(0,0,0,0.6);
            width: 550px;
            margin: 30px auto;
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

        input[type="submit"] {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            background-color: #4CAF50;
            color: white;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .message {
            text-align: center;
            margin-top: 15px;
            font-size: 18px;
            color: #00ff00;
        }
    </style>
</head>
<body>

<h2>FitLife Gym Management - Update Member</h2>
<%@ include file="navpage.html" %>

<div class="form-container">
    <!-- Select Member Form -->
    <form method="post">
        <label>Select Member:</label>
        <select name="member_id" onchange="this.form.submit()" required>
            <option value="">-- Select Member --</option>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                String selectedId = request.getParameter("member_id");

                try {
                    AS400JDBCDriver driver = new AS400JDBCDriver();
                    DriverManager.registerDriver(driver);
                    String url = "jdbc:as400:deathstar.gtc.edu;prompt=false";
                    conn = DriverManager.getConnection(url, user, pass);
                    stmt = conn.createStatement();

                    String sql = "SELECT MEMBER_ID, FULL_NAME FROM MEMBERS ORDER BY FULL_NAME";
                    rs = stmt.executeQuery(sql);
                    while(rs.next()){
                        String id = rs.getString("MEMBER_ID");
                        String name = rs.getString("FULL_NAME");
                        if(selectedId != null && selectedId.equals(id)){
                            out.println("<option value='" + id + "' selected>" + name + " (" + id + ")</option>");
                        } else {
                            out.println("<option value='" + id + "'>" + name + " (" + id + ")</option>");
                        }
                    }
                } catch(Exception ex){
                    out.println("<option disabled>Error loading members</option>");
                }
            %>
        </select>
    </form>

<%
    // If a member is selected, load their data
    if(selectedId != null && !selectedId.isEmpty()){
        try{
            String sql = "SELECT * FROM MEMBERS WHERE MEMBER_ID=?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, selectedId);
            ResultSet memberRs = pstmt.executeQuery();
            if(memberRs.next()){
%>
    <!-- Update Member Form -->
    <form method="post">
        <input type="hidden" name="member_id" value="<%= selectedId %>">
        <label>Full Name:</label>
        <input type="text" name="full_name" value="<%= memberRs.getString("FULL_NAME") %>" required>

        <label>Age:</label>
        <input type="number" name="age" value="<%= memberRs.getInt("AGE") %>" required>

        <label>Gender:</label>
        <select name="gender">
            <option value="">Select</option>
            <option value="M" <%= "M".equals(memberRs.getString("GENDER"))?"selected":"" %>>Male</option>
            <option value="F" <%= "F".equals(memberRs.getString("GENDER"))?"selected":"" %>>Female</option>
        </select>

        <label>Phone:</label>
        <input type="text" name="phone" value="<%= memberRs.getString("PHONE") %>" required>

        <label>Email:</label>
        <input type="text" name="email" value="<%= memberRs.getString("EMAIL") %>">

        <label>Address:</label>
        <input type="text" name="address" value="<%= memberRs.getString("ADDRESS") %>">

        <label>Membership Type:</label>
        <input type="text" name="membership_type" value="<%= memberRs.getString("MEMBERSHIP_TYPE") %>" required>

        <label>Join Date:</label>
        <input type="date" name="join_date" value="<%= memberRs.getDate("JOIN_DATE") %>" required>

        <label>Expiry Date:</label>
        <input type="date" name="expiry_date" value="<%= memberRs.getDate("EXPIRY_DATE") %>">

        <label>Status:</label>
        <select name="status">
            <option value="Active" <%= "Active".equals(memberRs.getString("STATUS"))?"selected":"" %>>Active</option>
            <option value="Inactive" <%= "Inactive".equals(memberRs.getString("STATUS"))?"selected":"" %>>Inactive</option>
            <option value="Expired" <%= "Expired".equals(memberRs.getString("STATUS"))?"selected":"" %>>Expired</option>
            <option value="Suspended" <%= "Suspended".equals(memberRs.getString("STATUS"))?"selected":"" %>>Suspended</option>
            <option value="Cancelled" <%= "Cancelled".equals(memberRs.getString("STATUS"))?"selected":"" %>>Cancelled</option>
        </select>

        <label>Emergency Contact:</label>
        <input type="text" name="emergency_contact" value="<%= memberRs.getString("EMERGENCY_CONTACT") %>">

        <label>Last Payment Date:</label>
        <input type="date" name="last_payment_date" value="<%= memberRs.getDate("LAST_PAYMENT_DATE") %>">

        <input type="submit" value="Update Member">
    </form>
<%
            }
            memberRs.close();
            pstmt.close();
        } catch(Exception ex){
            out.println("<div class='message' style='color:red;'>" + ex.getMessage() + "</div>");
        }

        // If update form is submitted
        String full_name = request.getParameter("full_name");
        if(full_name != null){
            try{
                String updateSql = "UPDATE MEMBERS SET FULL_NAME=?, AGE=?, GENDER=?, PHONE=?, EMAIL=?, ADDRESS=?, MEMBERSHIP_TYPE=?, JOIN_DATE=?, EXPIRY_DATE=?, STATUS=?, EMERGENCY_CONTACT=?, LAST_PAYMENT_DATE=? WHERE MEMBER_ID=?";
                PreparedStatement updatePstmt = conn.prepareStatement(updateSql);
                updatePstmt.setString(1, request.getParameter("full_name"));
                updatePstmt.setInt(2, Integer.parseInt(request.getParameter("age")));
                updatePstmt.setString(3, request.getParameter("gender"));
                updatePstmt.setString(4, request.getParameter("phone"));
                updatePstmt.setString(5, request.getParameter("email"));
                updatePstmt.setString(6, request.getParameter("address"));
                updatePstmt.setString(7, request.getParameter("membership_type"));
                updatePstmt.setDate(8, java.sql.Date.valueOf(request.getParameter("join_date")));

                String expiry = request.getParameter("expiry_date");
                if(expiry != null && !expiry.isEmpty())
                    updatePstmt.setDate(9, java.sql.Date.valueOf(expiry));
                else
                    updatePstmt.setNull(9, java.sql.Types.DATE);

                updatePstmt.setString(10, request.getParameter("status"));
                updatePstmt.setString(11, request.getParameter("emergency_contact"));

                String lastPayment = request.getParameter("last_payment_date");
                if(lastPayment != null && !lastPayment.isEmpty())
                    updatePstmt.setDate(12, java.sql.Date.valueOf(lastPayment));
                else
                    updatePstmt.setNull(12, java.sql.Types.DATE);

                updatePstmt.setString(13, selectedId);

                int rows = updatePstmt.executeUpdate();
                if(rows > 0){
                    out.println("<div class='message'>Member updated successfully!</div>");
                } else {
                    out.println("<div class='message' style='color:red;'>Update failed.</div>");
                }
                updatePstmt.close();
            } catch(Exception ex){
                out.println("<div class='message' style='color:red;'>" + ex.getMessage() + "</div>");
            } finally {
                if(rs != null) rs.close();
                if(stmt != null) stmt.close();
                if(conn != null) conn.close();
            }
        }
    }
%>
</div>

</body>
</html>

