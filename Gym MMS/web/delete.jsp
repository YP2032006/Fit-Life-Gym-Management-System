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
    <title>Delete Member - FitLife Gym Management</title>
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
            width: 400px;
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

        select {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: none;
            margin-bottom: 20px;
        }

        input[type="submit"] {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            background-color: #f44336;
            color: white;
        }
        input[type="submit"]:hover {
            background-color: #da190b;
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

<h2>FitLife Gym Management - Delete Member</h2>
<%@ include file="navpage.html" %>

<div class="form-container">
    <form method="post" onsubmit="return confirm('Are you sure you want to delete this member?');">
        <label>Select Member:</label>
        <select name="member_id" required>
            <option value="">-- Select Member --</option>
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

                    String sql = "SELECT MEMBER_ID, FULL_NAME FROM MEMBERS ORDER BY FULL_NAME";
                    rs = stmt.executeQuery(sql);
                    while(rs.next()){
                        String id = rs.getString("MEMBER_ID");
                        String name = rs.getString("FULL_NAME");
                        out.println("<option value='" + id + "'>" + name + " (" + id + ")</option>");
                    }
                } catch(Exception ex){
                    out.println("<option disabled>Error loading members</option>");
                }
            %>
        </select>
        <input type="submit" value="Delete Member">
    </form>

    <%
        String memberId = request.getParameter("member_id");
        if(memberId != null && !memberId.isEmpty()){
            try{
                String sqlDelete = "DELETE FROM MEMBERS WHERE MEMBER_ID=?";
                PreparedStatement pstmt = conn.prepareStatement(sqlDelete);
                pstmt.setString(1, memberId);
                int rows = pstmt.executeUpdate();
                if(rows > 0){
                    out.println("<div class='message'>Member deleted successfully!</div>");
                } else {
                    out.println("<div class='message' style='color:red;'>No member found to delete.</div>");
                }
                pstmt.close();
            } catch(Exception ex){
                out.println("<div class='message' style='color:red;'>" + ex.getMessage() + "</div>");
            } finally {
                if(rs != null) rs.close();
                if(stmt != null) stmt.close();
                if(conn != null) conn.close();
            }
        }
    %>
</div>

</body>
</html>
