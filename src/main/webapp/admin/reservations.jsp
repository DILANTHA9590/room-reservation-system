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
boolean isReceptionist = "RECEPTIONIST".equalsIgnoreCase(user.getRole()); // staff role eka me name eka neda?

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
body { font-family: Arial, sans-serif; background:#f4f6f9; margin:20px; }
h2 { color:#2c3e50; }
.card { background:#fff; padding:20px; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,0.1); }
table { width:100%; border-collapse:collapse; border-radius:8px; overflow:hidden; }
th { background:#2c3e50; color:#fff; padding:12px; }
td { padding:10px; text-align:center; }
tr:nth-child(even) { background:#f2f2f2; }

a.btn { padding:6px 10px; color:#fff; text-decoration:none; border-radius:5px; display:inline-block; }
a.btn:hover { opacity:0.9; }

a.cancel { background:#e74c3c; }
a.pay { background:#2980b9; }

.badge { padding:4px 8px; border-radius:10px; color:#fff; font-size:12px; display:inline-block; }
.badge.cancelled { background:#7f8c8d; }
.badge.active { background:#27ae60; }
.badge.paid { background:#16a085; }

.topbar { display:flex; justify-content:space-between; align-items:center; margin-bottom:15px; }
a.back { text-decoration:none; color:#2c3e50; font-weight:bold; }
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
                <span class="badge cancelled">UNPAID</span>
            <% } %>
        </td>

        <td>
            <% if (cancelled || paid) { %>
                -
            <% } else { %>

                <!-- Pay: Admin + Receptionist both allowed -->
                <a class="btn pay"
                   href="<%= request.getContextPath() %>/payments/create?id=<%= r.getReservationId() %>">
                   Pay
                </a>

                <!-- Cancel: ADMIN only -->
                <% if (isAdmin) { %>
                    &nbsp;
                    <a class="btn cancel"
                       href="<%= request.getContextPath() %>/admin/reservations?cancel=<%= r.getReservationId() %>"
                       onclick="return confirm('Cancel this reservation?');">
                       Cancel
                    </a>
                <% } %>

            <% } %>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="10">No reservations found.</td>
    </tr>
    <% } %>

</table>
</div>

</body>
</html>