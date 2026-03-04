<%@ page import="java.util.List" %>
<%@ page import="model.Reservation" %>
<%@ page import="model.User" %>

<%
User user = (User) session.getAttribute("loggedUser");
if (user == null) {
    response.sendRedirect(request.getContextPath()+"/view/login.jsp");
    return;
}

boolean isAdmin = "ADMIN".equalsIgnoreCase(user.getRole());
boolean isReceptionist = "RECEPTIONIST".equalsIgnoreCase(user.getRole());

if (!isAdmin && !isReceptionist) {
    out.print("403 - Access Denied");
    return;
}

List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
%>

<!DOCTYPE html>
<html>
<head>
<title>All Reservations</title>

<style>

body{
 font-family:Arial;
 background:#f4f6f9;
 margin:20px;
}

h2{
 color:#2c3e50;
}

.card{
 background:#fff;
 padding:20px;
 border-radius:10px;
 box-shadow:0 2px 10px rgba(0,0,0,0.08);
}

table{
 width:100%;
 border-collapse:collapse;
 border-radius:10px;
 overflow:hidden;
}

th{
 background:#2c3e50;
 color:#fff;
 padding:12px;
}

td{
 padding:10px;
 text-align:center;
}

tr:nth-child(even){
 background:#f2f2f2;
}

/* Buttons */

a.btn{
 padding:6px 10px;
 color:#fff;
 text-decoration:none;
 border-radius:6px;
 font-size:13px;
 font-weight:600;
 display:inline-block;
}

a.btn:hover{
 opacity:.9;
}

.pay{
 background:#2980b9;
}

.cancel{
 background:#e74c3c;
}

.edit{
 background:#f39c12;
}

.edit:hover{
 background:#e67e22;
}

/* action buttons layout */

.actions{
 display:flex;
 justify-content:center;
 gap:6px;
 flex-wrap:wrap;
}

/* badges */

.badge{
 padding:4px 10px;
 border-radius:20px;
 color:#fff;
 font-size:12px;
 font-weight:600;
}

.badge.cancelled{
 background:#7f8c8d;
}

.badge.active{
 background:#27ae60;
}

.badge.paid{
 background:#16a085;
}

.badge.unpaid{
 background:#c0392b;
}

/* top bar */

.topbar{
 display:flex;
 justify-content:space-between;
 align-items:center;
 margin-bottom:15px;
}

a.back{
 text-decoration:none;
 color:#2c3e50;
 font-weight:bold;
}

</style>
</head>

<body>

<div class="topbar">
<h2>All Reservations</h2>

<a class="back"
href="<%= request.getContextPath() %>/<%= isAdmin ? "admin/dashboard.jsp" : "staff/dashboard.jsp" %>">
⬅ Back to Dashboard
</a>

</div>

<div class="card">

<table>

<tr>
<th>ID</th>
<th>Reservation No</th>
<th>Guest Name</th>
<th>Contact</th>
<th>Room Type</th>
<th>Check-in</th>
<th>Check-out</th>
<th>Status</th>
<th>Payment</th>
<th>Action</th>
</tr>

<%
if (reservations != null && !reservations.isEmpty()) {

for (Reservation r : reservations) {

boolean cancelled = "CANCELLED".equalsIgnoreCase(r.getStatus());
boolean paid = r.isPaid();
%>

<tr>

<td><%= r.getReservationId() %></td>
<td><%= r.getReservationNo() %></td>
<td><%= r.getGuestName() %></td>
<td><%= r.getContactNo() %></td>
<td><%= r.getRoomTypeName() %></td>

<td><%= r.getCheckIn() != null ? r.getCheckIn().toString() : "" %></td>
<td><%= r.getCheckOut() != null ? r.getCheckOut().toString() : "" %></td>

<td>

<span class="badge <%= cancelled ? "cancelled" : "active" %>">
<%= r.getStatus() %>
</span>

</td>

<td>

<% if (paid) { %>

<span class="badge paid">PAID</span>

<% } else { %>

<span class="badge unpaid">UNPAID</span>

<% } %>

</td>

<td class="actions">

<% if (!cancelled && !paid) { %>

<a class="btn pay"
href="<%= request.getContextPath() %>/payments/create?id=<%= r.getReservationId() %>">
Pay
</a>

<% if (isAdmin) { %>

<a class="btn cancel"
href="<%= request.getContextPath() %>/admin/reservations?cancel=<%= r.getReservationId() %>"
onclick="return confirm('Cancel this reservation?');">
Cancel
</a>

<% } %>

<% } %>

<a class="btn edit"
href="<%= request.getContextPath() %>/reservations/edit?id=<%= r.getReservationId() %>">
Edit
</a>

</td>

</tr>

<%
}
}
else{
%>

<tr>
<td colspan="10">No reservations found.</td>
</tr>

<%
}
%>

</table>

</div>

</body>
</html>