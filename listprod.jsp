<%@ page import="java.sql.*,java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link href="style.css" rel="stylesheet" type="text/css">
<title>Ray's Grocery</title>
</head>
<body>

<h1>Collection</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<%
	// Get product name to search for
	String name = request.getParameter("productName");
	boolean hasParameter = false;
	String sql = "";

	if (name == null)
		name = "";

	if (name.equals("")) 
	{
		out.println("<h2>All Products</h2>");
		sql = "SELECT productId, productName, productPrice FROM Product";
	} 
	else 
	{
		out.println("<h2>Products containing '" + name + "'</h2>");
		hasParameter = true;
		sql = "SELECT productId, productName, productPrice FROM Product WHERE productName LIKE ?";
		name = '%' + name + '%';
	}
	
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
		out.println("ClassNotFoundException: " +e);
	}

	try ( Connection con = DriverManager.getConnection(url, uid, pw);) 
	{			
		PreparedStatement pstmt = con.prepareStatement(sql);
		if (hasParameter)
			pstmt.setString(1, name);

		ResultSet rst = pstmt.executeQuery();
		out.println("<table class=table border = 1><tr><th></th><th>Product Name</th><th>Price</th></tr>");
		while (rst.next()) 
		{
			out.print("<tr><td><a href=\"addcart.jsp?id=" + rst.getInt(1) + "&name=" + rst.getString(2)
					+ "&price=" + rst.getDouble(3) + "\">Add to Cart</a></td>");
			out.println("<td><a href=\"product.jsp?id=" + rst.getInt(1) + "\">" + rst.getString(2) + "</a></td>" + "<td>" + currFormat.format(rst.getDouble(3))
					+ "</td></tr>");
		}
		out.println("</table>");
	} 
	catch (SQLException ex) 
	{
		out.println(ex);
	} 	
%>
</body>
</html>