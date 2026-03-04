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
<meta charset="UTF-8">

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

tr:hover{
 background:#ecf0f1;
}

/* Buttons */

a.btn, button.btn{
 padding:7px 12px;
 color:#fff;
 text-decoration:none;
 border:none;
 border-radius:8px;
 font-size:13px;
 font-weight:600;
 display:inline-flex;
 align-items:center;
 justify-content:center;
 gap:6px;
 transition:0.2s ease;
 box-shadow:0 2px 6px rgba(0,0,0,0.12);
 cursor:pointer;
}

a.btn:hover, button.btn:hover{
 transform:translateY(-1px);
 opacity:.95;
}

.pay{ background:#2980b9; }
.pay:hover{ background:#1f6fa5; }

.cancel{ background:#e74c3c; }
.cancel:hover{ background:#c0392b; }

.edit{ background:#f39c12; }
.edit:hover{ background:#e67e22; }

.bill{ background:#27ae60; }
.bill:hover{ background:#2ecc71; }

.delete{ background:#c0392b; }
.delete:hover{ background:#a93226; }

.actions{
 display:flex;
 justify-content:center;
 gap:8px;
 flex-wrap:wrap;
}

/* badges */

.badge{
 padding:4px 10px;
 border-radius:20px;
 color:#fff;
 font-size:12px;
 font-weight:600;
 display:inline-block;
}

.badge.cancelled{ background:#7f8c8d; }
.badge.active{ background:#27ae60; }
.badge.paid{ background:#16a085; }
.badge.unpaid{ background:#c0392b; }

.topbar{
 display:flex;
 justify-content:space-between;
 align-items:center;
 margin-bottom:15px;
}

</style>
</head>

<body>

<div class="topbar">
<h2>All Reservations</h2>
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

<a class="btn bill"
href="<%=request.getContextPath()%>/bill?reservationId=<%= r.getReservationId() %>">
Bill
</a>

<% if (isAdmin) { %>

<form action="<%= request.getContextPath() %>/admin/reservations"
method="post"
style="display:inline;">

<input type="hidden" name="action" value="delete">
<input type="hidden" name="id" value="<%= r.getReservationId() %>">

<button type="submit"
class="btn delete"
onclick="return confirm('Delete this reservation permanently?');">
Delete
</button>

</form>

<% } %>

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