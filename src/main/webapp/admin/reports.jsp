<%@ page import="model.User" %>
<%
User u = (User) session.getAttribute("loggedUser");
if (u == null) { response.sendRedirect(request.getContextPath()+"/view/login.jsp"); return; }
if (!"ADMIN".equalsIgnoreCase(u.getRole())) { out.print("403 - ADMIN only"); return; }

int totalRoomTypes = (Integer) request.getAttribute("totalRoomTypes");
int totalUsers = (Integer) request.getAttribute("totalUsers");
int totalReservations = (Integer) request.getAttribute("totalReservations");
int cancelledReservations = (Integer) request.getAttribute("cancelledReservations");
int totalPayments = (Integer) request.getAttribute("totalPayments");
double totalRevenue = (Double) request.getAttribute("totalRevenue");
%>

<!DOCTYPE html>
<html>
<head>
<title>Reports</title>
<style>
body{font-family:Arial;background:#f4f6f9;margin:20px;}
h2{color:#2c3e50;margin-bottom:10px;}
.grid{display:grid;grid-template-columns:repeat(3, minmax(200px, 1fr));gap:15px;}
.card{background:#fff;border-radius:10px;padding:18px;box-shadow:0 2px 8px rgba(0,0,0,0.08);}
.label{color:#7f8c8d;font-size:13px;margin-bottom:6px;}
.value{font-size:28px;font-weight:bold;color:#2c3e50;}
.small{margin-top:8px;color:#95a5a6;font-size:12px;}
a.back{display:inline-block;margin:10px 0;text-decoration:none;color:#2c3e50;font-weight:bold;}
</style>
</head>
<body>

<h2>Reports</h2>
<a class="back" href="<%= request.getContextPath() %>/admin/dashboard.jsp">⬅ Back to Dashboard</a>

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