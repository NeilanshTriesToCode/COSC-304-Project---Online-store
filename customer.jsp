<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link href="style.css" rel="stylesheet" type="text/css">
<title>Customer Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%
	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";

	try
	{	// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}
	catch (java.lang.ClassNotFoundException e)
	{
		out.println("ClassNotFoundException: " +e);
	}

	try ( Connection con = DriverManager.getConnection(url, uid, pw);) 
	{
		String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid FROM customer WHERE userid = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, userName);
		ResultSet rst = pstmt.executeQuery();

		// TODO: Print Customer information
		rst.next();
		out.println("<h3>Customer Profile</h3>");
		out.print("<table border = 1><tr><th>Id</th><td>"+ rst.getInt(1) +"</tr>");
		out.print("<tr><th>First Name</th><td>" + rst.getString(2) +"</td></tr>");
		out.print("<tr><th>Last Name</th><td>" + rst.getString(3) +"</td></tr>");
		out.print("<tr><th>Email</th><td>" + rst.getString(4) +"</td></tr>");
		out.print("<tr><th>Phone</th><td>" + rst.getString(5) +"</td></tr>");
		out.print("<tr><th>Address</th><td>" + rst.getString(6) +"</td></tr>");
		out.print("<tr><th>City</th><td>" + rst.getString(7) +"</td></tr>");
		out.print("<tr><th>State</th><td>" + rst.getString(8) +"</td></tr>");
		out.print("<tr><th>Postal code</th><td>" + rst.getString(9) +"</td></tr>");
		out.print("<tr><th>Country</th><td>" + rst.getString(10) +"</td></tr>");
		out.print("<tr><th>User Id</th><td>" + rst.getString(11) +"</td></tr>");
		out.println("</table>");
	} 
	catch (SQLException ex) {
		out.println(ex);
	}
	// Make sure to close connection
	finally
	{
		closeConnection();
	}	
%>

</body>
</html>

