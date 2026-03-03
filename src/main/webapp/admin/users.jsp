<%@ page import="java.util.List" %>
<%@ page import="model.User" %>

<%
User admin = (User) session.getAttribute("loggedUser");
if (admin == null) { response.sendRedirect(request.getContextPath()+"/view/login.jsp"); return; }
if (!"ADMIN".equalsIgnoreCase(admin.getRole())) { out.print("403 - ADMIN only"); return; }

List<User> users = (List<User>) request.getAttribute("users");
String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
<head>
<title>Manage Staff Users</title>
<style>
body { font-family: Arial, sans-serif; background:#f4f6f9; margin:20px; }
h2 { color:#2c3e50; }
.card { background:#fff; padding:20px; margin-bottom:20px; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,0.1); }
input, select { padding:8px; margin-right:10px; border:1px solid #ccc; border-radius:5px; }
button { padding:8px 15px; background:#2c3e50; color:#fff; border:none; border-radius:5px; cursor:pointer; }
button:hover { background:#34495e; }
table { width:100%; border-collapse:collapse; background:#fff; border-radius:8px; overflow:hidden; }
th { background:#2c3e50; color:#fff; padding:12px; }
td { padding:10px; text-align:center; }
tr:nth-child(even) { background:#f2f2f2; }
a.delete-btn { color:red; text-decoration:none; font-weight:bold; }
a.delete-btn:hover { text-decoration:underline; }
.msg { color:red; font-weight:bold; margin-bottom:10px; }
</style>
</head>
<body>

<h2>Manage Staff Users</h2>

<div class="card">
    <h3>Add New Staff User</h3>

    <% if (error != null) { %>
        <div class="msg"><%= error %></div>
    <% } %>

    <form action="<%= request.getContextPath() %>/admin/users" method="post">
        <input type="text" name="fullName" placeholder="Full Name" required />
        <input type="email" name="email" placeholder="Email" required />
        <input type="password" name="password" placeholder="Password" required />

        <select name="role" required>
            <option value="RECEPTIONIST">RECEPTIONIST</option>
            <option value="ADMIN">ADMIN</option>
        </select>

        <button type="submit">Create</button>
    </form>
</div>

<div class="card">
    <h3>Staff Users List</h3>

    <table>
        <tr>
            <th>ID</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Role</th>
            <th>Action</th>
        </tr>

        <%
        if (users != null) {
            for (User u : users) {
        %>
        <tr>
            <td><%= u.getUserId() %></td>
            <td><%= u.getFullName() %></td>
            <td><%= u.getEmail() %></td>
            <td><%= u.getRole() %></td>
            <td>
                <a class="delete-btn"
                   href="<%= request.getContextPath() %>/admin/users?delete=<%= u.getUserId() %>"
                   onclick="return confirm('Delete this user?');">
                    Delete
                </a>
            </td>
        </tr>
        <% } } %>
    </table>
</div>

</body>
</html>