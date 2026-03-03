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

<style>
body { margin:0; font-family:Arial; }

.container {
    display:flex;
    height:100vh;
}

.sidebar {
    width:220px;
    background:#2c3e50;
    color:white;
    padding:20px;
}

.sidebar h3 {
    margin-top:0;
}

.sidebar a {
    display:block;
    padding:10px;
    color:white;
    text-decoration:none;
}

.sidebar a:hover {
    background:#34495e;
}

.content {
    flex:1;
}

iframe {
    width:100%;
    height:100%;
    border:none;
}
</style>

</head>
<body>

<div class="container">

    <div class="sidebar">
        <h3>ADMIN PANEL</h3>

        <p>Welcome <%= u.getFullName() %></p>
        <hr>

        <a href="<%= request.getContextPath() %>/admin/room-types" target="contentFrame">
            Manage Room Types
        </a>

        <a href="<%= request.getContextPath() %>/admin/users" target="contentFrame">
            Manage Staff Users
        </a>

        <a href="<%= request.getContextPath() %>/admin/reservations" target="contentFrame">
            All Reservations
        </a>

        <a href="<%= request.getContextPath() %>/admin/reports" target="contentFrame">
            Reports
        </a>

        <hr>

        <form action="<%= request.getContextPath() %>/logout" method="post">
            <button type="submit">Logout</button>
        </form>

    </div>

    <div class="content">
        <iframe name="contentFrame"></iframe>
    </div>

</div>

</body>
</html>