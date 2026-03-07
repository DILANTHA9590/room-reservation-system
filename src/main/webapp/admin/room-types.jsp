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

body{
font-family:'Segoe UI', Arial;
background:#f4f6f9;
margin:25px;
}

h2{
color:#2c3e50;
margin-bottom:20px;
}

/* Cards */

.card{
background:white;
padding:25px;
margin-bottom:25px;

border-radius:10px;

box-shadow:0 4px 15px rgba(0,0,0,0.08);
}

.card h3{
margin-top:0;
margin-bottom:15px;
color:#34495e;
}

/* Form inputs */

input{
padding:10px 12px;
margin-right:10px;

border:1px solid #ccc;
border-radius:6px;

font-size:14px;
}

input:focus{
border-color:#2c3e50;
outline:none;
}

/* Button */

button{
padding:10px 18px;

background:#2c3e50;
color:white;

border:none;
border-radius:6px;

font-weight:600;
cursor:pointer;

transition:0.2s;
}

button:hover{
background:#34495e;
}

/* Table */

table{
width:100%;
border-collapse:collapse;
background:white;

border-radius:8px;
overflow:hidden;
}

th{
background:#2c3e50;
color:white;

padding:14px;

font-size:14px;
}

td{
padding:12px;
text-align:center;

font-size:14px;
}

/* zebra rows */

tr:nth-child(even){
background:#f7f9fb;
}

/* row hover */

tr:hover{
background:#eef3f8;
}

/* delete button */

a.delete-btn{
color:#e74c3c;
text-decoration:none;
font-weight:600;
}

a.delete-btn:hover{
text-decoration:underline;
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