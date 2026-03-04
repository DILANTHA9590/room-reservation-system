<%@ page import="model.User" %>

<%
User u = (User) session.getAttribute("loggedUser");
if (u == null) { 
    response.sendRedirect(request.getContextPath()+"/view/login.jsp"); 
    return; 
}

// allow ADMIN + RECEPTIONIST
String role = u.getRole();

boolean isAdmin = "ADMIN".equalsIgnoreCase(role);
boolean isReceptionist = "RECEPTIONIST".equalsIgnoreCase(role);

if (!isAdmin && !isReceptionist) { 
    out.print("403 - Access Denied"); 
    return; 
}

// safe casting
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

// back link
String backUrl = request.getContextPath() + (isAdmin ? "/admin/dashboard.jsp" : "/staff/dashboard.jsp");
%>

<!DOCTYPE html>
<html>
<head>

<title>Reports</title>

<style>

body{
font-family:Arial;
background:#f4f6f9;
margin:20px;
}

/* top bar */

.topbar{
display:flex;
align-items:center;
margin-bottom:20px;
}

a.back{
display:inline-flex;
align-items:center;
gap:6px;
text-decoration:none;
color:#2c3e50;
font-weight:bold;
font-size:14px;
padding:6px 12px;
border-radius:6px;
background:#eef2f6;
}

a.back:hover{
background:#dde3ea;
}

h2{
color:#2c3e50;
margin-bottom:15px;
}

/* grid layout */

.grid{
display:grid;
grid-template-columns:repeat(3, minmax(200px, 1fr));
gap:15px;
}

/* cards */

.card{
background:#fff;
border-radius:10px;
padding:18px;
box-shadow:0 2px 8px rgba(0,0,0,0.08);
transition:0.2s;
}

.card:hover{
transform:translateY(-2px);
}

.label{
color:#7f8c8d;
font-size:13px;
margin-bottom:6px;
}

.value{
font-size:28px;
font-weight:bold;
color:#2c3e50;
}

.small{
margin-top:8px;
color:#95a5a6;
font-size:12px;
}

</style>

</head>

<body>

<div class="topbar">

<a class="back" href="<%= backUrl %>">
⬅ Back to Dashboard
</a>

</div>

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
<div class="small">(If payments table exists)</div>
</div>

<div class="card">
<div class="label">Total Revenue</div>
<div class="value"><%= String.format("%.2f", totalRevenue) %></div>
<div class="small">(If payments table exists)</div>
</div>

</div>

</body>
</html>