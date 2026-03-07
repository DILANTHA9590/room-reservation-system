<%@ page import="model.User" %>

<%
User u = (User) session.getAttribute("loggedUser");
if (u == null) { 
    response.sendRedirect(request.getContextPath()+"/view/login.jsp"); 
    return; 
}

String role = u.getRole();

boolean isAdmin = "ADMIN".equalsIgnoreCase(role);
boolean isReceptionist = "RECEPTIONIST".equalsIgnoreCase(role);

if (!isAdmin && !isReceptionist) { 
    out.print("403 - Access Denied"); 
    return; 
}

Integer totalRoomTypesObj = (Integer) request.getAttribute("totalRoomTypes");
Integer totalUsersObj = (Integer) request.getAttribute("totalUsers");
Integer totalReservationsObj = (Integer) request.getAttribute("totalReservations");
Integer cancelledReservationsObj = (Integer) request.getAttribute("cancelledReservations");
Integer totalPaymentsObj = (Integer) request.getAttribute("totalPayments");
Double totalRevenueObj = (Double) request.getAttribute("totalRevenue");

int totalRoomTypes = totalRoomTypesObj != null ? totalRoomTypesObj : 0;
int totalUsers = totalUsersObj != null ? totalUsersObj : 0;
int totalReservations = totalReservationsObj != null ? totalReservationsObj : 0;
int cancelledReservations = cancelledReservationsObj != null ? cancelledReservationsObj : 0;
int totalPayments = totalPaymentsObj != null ? totalPaymentsObj : 0;
double totalRevenue = totalRevenueObj != null ? totalRevenueObj : 0.0;
%>

<!DOCTYPE html>
<html>
<head>
<title>Reports</title>

<style>

body{
font-family:Arial;
background:#f4f6f9;
margin:30px;
}

/* title */

h2{
color:#2c3e50;
margin-bottom:25px;
font-size:26px;
}

/* grid layout */

.grid{
display:grid;
grid-template-columns:repeat(3, 1fr);
gap:25px;
}

/* cards */

.card{
background:#fff;
border-radius:12px;
padding:35px;

box-shadow:0 4px 15px rgba(0,0,0,0.08);

transition:0.2s;
}

.card:hover{
transform:translateY(-4px);
box-shadow:0 8px 20px rgba(0,0,0,0.12);
}

.label{
color:#7f8c8d;
font-size:16px;
margin-bottom:10px;
}

.value{
font-size:40px;
font-weight:bold;
color:#2c3e50;
}

.small{
margin-top:10px;
color:#95a5a6;
font-size:13px;
}

</style>

</head>

<body>

<h2>Reports</h2>

<div class="grid">

<div class="card">
<div class="label">Total Room Types</div>
<div class="value"><%= totalRoomTypes %></div>
</div>

<div class="card">
<div class="label">Total Staff Users</div>
<div class="value"><%= totalUsers %></div>
</div>

<div class="card">
<div class="label">Total Reservations</div>
<div class="value"><%= totalReservations %></div>
</div>

<div class="card">
<div class="label">Cancelled Reservations</div>
<div class="value"><%= cancelledReservations %></div>
</div>

<div class="card">
<div class="label">Total Payments</div>
<div class="value"><%= totalPayments %></div>
</div>

<div class="card">
<div class="label">Total Revenue</div>
<div class="value"><%= String.format("%.2f", totalRevenue) %></div>
</div>

</div>

</body>
</html>