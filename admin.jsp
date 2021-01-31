<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link href="style.css" rel="stylesheet" type="text/css">
<title>Administrator Page</title>
</head>
<body>

<%@ include file="jdbc.jsp" %>
<%@ include file="auth.jsp" %>
<%@ page import="java.text.NumberFormat, java.util.Locale" %>

<%
// TODO: Include files auth.jsp and jdbc.jsp
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%
	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.CANADA);

	try
	{	// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}
	catch (java.lang.ClassNotFoundException e)
	{
		out.println("ClassNotFoundException: " + e);
	}

	try ( Connection con = DriverManager.getConnection(url, uid, pw);) 
	{
        // TODO: Write SQL query that prints out total order amount by day
		String sql = "SELECT YEAR(orderDate) AS YEAR, MONTH(orderDate) AS MONTH, DAY(orderDate) AS DAY, SUM(totalAmount) FROM ordersummary GROUP BY YEAR(orderDate), MONTH(orderDate), DAY(orderDate)";
		PreparedStatement pstmt = con.prepareStatement(sql);
		//pstmt.setString(1, userName);
		ResultSet rst = pstmt.executeQuery();

		// TODO: Print Customer information
		out.println("<h3>Administrator Sales Report by Day</h3>");
		out.print("<table border = 1><tr><th>Order Date</th><th>Total Order Amount</th></tr>");
        while (rst.next())
		    out.print("<tr><td>" + rst.getString(1) + "-" + rst.getString(2) + "-" + rst.getString(3) +"</td><td>" + currFormat.format(rst.getDouble(4)) + "</td></tr>");
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

