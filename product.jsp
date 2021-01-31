<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.sql.*,java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product
// String productId = request.getParameter("id");

String id = request.getParameter("id");
int productId = Integer.parseInt(id);
String sql = "SELECT productName, productPrice FROM product WHERE productId = ?";

//MAKE CONNECTION
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

try ( Connection con = DriverManager.getConnection(url, uid, pw);
        Statement stmt = con.createStatement();) 
{					
	PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setInt(1, productId);
    ResultSet rst = pstmt.executeQuery();	
    
    //EXTRACT DATA
    rst.next();
    String productName = rst.getString(1);
    double productPrice = rst.getDouble(2);

    //PRINT DATA
    out.println("<h2>" + productName + "</h2>");
    out.println("<table><tr><th>Id:</th><td>" + productId + "</td></tr><tr><th>Price:</th><td>" + currFormat.format(productPrice) + "</td></tr>");
    out.println("<img src=\"img/" + id + ".jpg\"></table>");
    //out.println("<img src=\"displayImage.jsp?id=" + id +"\"></table>");
    out.println("<h3><a href=\"addcart.jsp?id=" + productId + "&name=" + productName + "&price=" + productPrice + "\">Add to Cart</a></h3>");
    out.println("<h3><a href=\"listprod.jsp\">Continue Shopping</a></h3>");
}
catch (SQLException ex) 
{ 	out.println(ex); 
}

// TODO: If there is a productImageURL, display using IMG tag
		
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		
// TODO: Add links to Add to Cart and Continue Shopping
%>

</body>
</html>

