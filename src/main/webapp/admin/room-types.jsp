<%@ page import="java.util.List" %>
<%@ page import="model.RoomType" %>
<%@ page import="model.User" %>

<%
User u = (User) session.getAttribute("loggedUser");
if (u == null) { response.sendRedirect(request.getContextPath()+"/view/login.jsp"); return; }
if (!"ADMIN".equalsIgnoreCase(u.getRole())) { out.print("403 - ADMIN only"); return; }

List<RoomType> roomTypes = (List<RoomType>) request.getAttribute("roomTypes");
%>

<!DOCTYPE html>
<html>
<head>
<title>Manage Room Types</title>

<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f6f9;
    margin: 20px;
}

h2 {
    color: #2c3e50;
}

.card {
    background: white;
    padding: 20px;
    margin-bottom: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

input {
    padding: 8px;
    margin-right: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

button {
    padding: 8px 15px;
    background-color: #2c3e50;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

button:hover {
    background-color: #34495e;
}

table {
    width: 100%;
    border-collapse: collapse;
    background: white;
    border-radius: 8px;
    overflow: hidden;
}

th {
    background-color: #2c3e50;
    color: white;
    padding: 12px;
}

td {
    padding: 10px;
    text-align: center;
}

tr:nth-child(even) {
    background-color: #f2f2f2;
}

a.delete-btn {
    color: red;
    text-decoration: none;
    font-weight: bold;
}

a.delete-btn:hover {
    text-decoration: underline;
}

.back-link {
    text-decoration: none;
    color: #2c3e50;
    font-weight: bold;
}
</style>

</head>
<body>

<h2>Manage Room Types</h2>


<div class="card">
    <h3>Add New Room Type</h3>
    <form action="<%= request.getContextPath() %>/admin/room-types" method="post">
        <input type="text" name="name" placeholder="Room Type Name" required />
        <input type="number" step="0.01" name="rate" placeholder="Rate Per Night" required />
        <button type="submit">Add</button>
    </form>
</div>

<div class="card">
    <h3>Room Types List</h3>

    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Rate Per Night</th>
            <th>Action</th>
        </tr>

        <%
        if (roomTypes != null) {
            for (RoomType rt : roomTypes) {
        %>
        <tr>
            <td><%= rt.getId() %></td>
            <td><%= rt.getName() %></td>
            <td>Rs. <%= rt.getRatePerNight() %></td>
            <td>
                <a class="delete-btn"
                   href="<%= request.getContextPath() %>/admin/room-types?delete=<%= rt.getId() %>"
                   onclick="return confirm('Delete this room type?');">
                   Delete
                </a>
            </td>
        </tr>
        <% } } %>

    </table>
</div>

</body>
</html>