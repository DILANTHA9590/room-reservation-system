<%@ page import="model.User" %>
<%
User u = (User) session.getAttribute("loggedUser");
if (u == null) {
    response.sendRedirect(request.getContextPath() + "/view/login.jsp");
    return;
}
if (!"ADMIN".equalsIgnoreCase(u.getRole())) {
    out.print("403 - Access Denied (ADMIN only)");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>

<h2>Ocean View Resort - ADMIN Dashboard</h2>
<p>Welcome <b><%= u.getFullName() %></b> | Role: <b><%= u.getRole() %></b></p>

<hr>

<h3>Admin Functions</h3>
<ul>
    <li><a href="#">Manage Room Types / Categories</a></li>
    <li><a href="#">Manage Staff Users</a></li>
    <li><a href="#">View / Cancel All Reservations</a></li>
    <li><a href="#">Reports</a></li>
</ul>

<hr>

<form action="<%= request.getContextPath() %>/logout" method="post">
    <button type="submit">Logout</button>
</form>

</body>
</html>