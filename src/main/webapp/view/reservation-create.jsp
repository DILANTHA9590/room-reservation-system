<%@ page import="java.util.List" %>
<%@ page import="model.RoomType" %>
<%@ page import="model.User" %>

<%
User u = (User) session.getAttribute("loggedUser");
if (u == null) { response.sendRedirect(request.getContextPath()+"/view/login.jsp"); return; }

List<RoomType> roomTypes = (List<RoomType>) request.getAttribute("roomTypes");
String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
<head>
<title>Create Reservation</title>

<style>

*{box-sizing:border-box;}

body{
font-family:'Segoe UI', Arial;
background:#f4f6f9;
margin:0;

min-height:100vh;

display:flex;
justify-content:center;
align-items:flex-start;

padding:40px 20px;
}

/* Card */

.card{
background:#fff;

padding:30px;

border-radius:14px;

width:100%;
max-width:950px;

box-shadow:0 8px 25px rgba(0,0,0,.08);
}

/* Header */

h2{
color:#2c3e50;
margin:0;
font-size:24px;
}

.top{
display:flex;
justify-content:space-between;
align-items:center;
gap:10px;

margin-bottom:20px;
}

/* Back button */

a.back{
text-decoration:none;

color:#2c3e50;
font-weight:700;

padding:8px 12px;

border-radius:8px;

background:#eef2f6;
}

a.back:hover{
background:#e3e9f0;
}

/* Error */

.err{
color:#c0392b;

font-weight:600;

margin:10px 0 18px;

background:#fdecea;

border:1px solid #f5c2c7;

padding:12px;

border-radius:10px;
}

/* Form rows */

.row{
display:flex;
gap:15px;

margin-bottom:16px;
}

.row > div{
flex:1;
}

/* Labels */

label{
display:block;

margin-bottom:6px;

color:#2c3e50;

font-weight:600;

font-size:14px;
}

/* Inputs */

input,select{
width:100%;

padding:11px;

border:1px solid #cfd6de;

border-radius:10px;

outline:none;

font-size:14px;

transition:0.2s;
}

input:focus,select:focus{
border-color:#2c3e50;

box-shadow:0 0 0 3px rgba(44,62,80,.12);
}

/* Actions */

.actions{
display:flex;
justify-content:flex-start;

margin-top:10px;
}

/* Button */

button{
padding:12px 18px;

border:none;

border-radius:10px;

background:#2c3e50;

color:#fff;

cursor:pointer;

font-weight:700;

font-size:14px;

transition:0.2s;
}

button:hover{
background:#34495e;
}

/* Responsive */

@media (max-width:700px){
.row{
flex-direction:column;
}
}

</style>

</head>

<body>

<div class="card">

<div class="top">
<h2>Create Reservation</h2>

<a class="back" href="<%= request.getContextPath() %>/<%= "ADMIN".equalsIgnoreCase(u.getRole()) ? "admin/dashboard.jsp" : "staff/dashboard.jsp" %>">
⬅ Back
</a>

</div>

<% if (error != null) { %>
<div class="err"><%= error %></div>
<% } %>

<form action="<%= request.getContextPath() %>/reservations/create" method="post">

<div class="row">

<div>
<label>Reservation No</label>
<input type="text" name="reservationNo" required />
</div>

<div>
<label>Contact No</label>
<input type="text" name="contactNo" required />
</div>

</div>

<div class="row">

<div>
<label>Guest Name</label>
<input type="text" name="guestName" required />
</div>

<div>
<label>Room Type</label>

<select name="roomTypeId" required>

<option value="">-- Select --</option>

<%
if (roomTypes != null) {
for (RoomType rt : roomTypes) {
%>

<option value="<%= rt.getId() %>">
<%= rt.getName() %> - LKR <%= rt.getRatePerNight() %>
</option>

<% } } %>

</select>

</div>

</div>

<div class="row">

<div>
<label>Address</label>
<input type="text" name="address" required />
</div>

</div>

<div class="row">

<div>
<label>Check-in</label>
<input type="date" name="checkIn" required />
</div>

<div>
<label>Check-out</label>
<input type="date" name="checkOut" required />
</div>

</div>

<div class="actions">
<button type="submit">Create Reservation</button>
</div>

</form>

</div>

</body>
</html>