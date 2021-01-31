<!DOCTYPE html>
<html>
<head>
<link href="style.css" rel="stylesheet" type="text/css">
<title>Home Page</title>
</head>
<body>

<%
String userName = (String) session.getAttribute("authenticatedUser");
%>

<h1 align="center">Sneaker House</h1>

<h2 align="center"><a href="login.jsp">Login</a></h2>

<h2 align="center"><a href="listprod.jsp">Begin Shopping</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>

<%
// TODO: Display user name that is logged in (or nothing if not logged in)
if (userName == null)
        out.println("");
else
        out.println("<h3 align = \"center\">" + "Sign in as: " + userName + "</h3>");

%>
</body>
</head>


