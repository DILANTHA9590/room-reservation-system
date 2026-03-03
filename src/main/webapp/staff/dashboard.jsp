<%@ page import="model.User" %>
<%
User u = (User) session.getAttribute("loggedUser");
if (u == null) {
    response.sendRedirect(request.getContextPath() + "/view/login.jsp");
    return;
}
if (!"RECEPTIONIST".equalsIgnoreCase(u.getRole())) {
    out.print("403 - Access Denied (RECEPTIONIST only)");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Staff Dashboard</title>
</head>
<body>

<h2>Ocean View Resort - STAFF Dashboard</h2>
<p>Welcome <b><%= u.getFullName() %></b> | Role: <b><%= u.getRole() %></b></p>

<hr>

<h3>Receptionist Functions</h3>
<ul>
    <li><a href="#">Create / Update / Cancel Reservation</a></li>
    <li><a href="#">Mark Check-in / Check-out</a></li>
    <li><a href="#">Record Payments</a></li>
</ul>

<hr>

<form action="<%= request.getContextPath() %>/logout" method="post">
    <button type="submit">Logout</button>
</form>

</body>
</html>