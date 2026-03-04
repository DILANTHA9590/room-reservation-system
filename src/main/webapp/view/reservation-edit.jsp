<%@ page import="java.util.List" %>
<%@ page import="model.RoomType" %>
<%@ page import="model.Reservation" %>
<%@ page import="model.User" %>

<%
User u = (User) session.getAttribute("loggedUser");
if (u == null) { response.sendRedirect(request.getContextPath()+"/view/login.jsp"); return; }

Reservation r = (Reservation) request.getAttribute("reservation");
List<RoomType> roomTypes = (List<RoomType>) request.getAttribute("roomTypes");
String error = (String) request.getAttribute("error");
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Reservation</title>

<style>
*{box-sizing:border-box;}
body{
  font-family:Arial;
  background:#f4f6f9;
  margin:0;
  min-height:100vh;
  display:flex;
  justify-content:center;
  align-items:flex-start;
  padding:30px 15px;
}

.card{
  background:#fff;
  padding:22px;
  border-radius:12px;
  width:100%;
  max-width:900px;
  box-shadow:0 2px 12px rgba(0,0,0,.08);
}

h2{color:#2c3e50;margin:0;}

.top{
  display:flex;
  justify-content:space-between;
  align-items:center;
  gap:10px;
  margin-bottom:16px;
}

a.back{
  text-decoration:none;
  color:#2c3e50;
  font-weight:700;
  padding:8px 10px;
  border-radius:8px;
  background:#eef2f6;
}

.row{
  display:flex;
  gap:12px;
  margin-bottom:12px;
}

.row > div{flex:1;}

label{
  display:block;
  margin-bottom:6px;
  color:#2c3e50;
  font-weight:600;
}

input,select{
  width:100%;
  padding:10px;
  border:1px solid #cfd6de;
  border-radius:10px;
}

.actions{
  margin-top:10px;
}

button{
  padding:10px 14px;
  border:none;
  border-radius:10px;
  background:#2c3e50;
  color:#fff;
  cursor:pointer;
}

</style>
</head>

<body>

<div class="card">

<div class="top">
<h2>Edit Reservation</h2>
<a class="back" href="<%= request.getContextPath() %>/admin/reservations">⬅ Back</a>
</div>

<form action="<%= request.getContextPath() %>/reservations/update" method="post">

<input type="hidden" name="id" value="<%= r.getReservationId() %>">

<div class="row">
<div>
<label>Reservation No</label>
<input type="text" value="<%= r.getReservationNo() %>" readonly>
</div>

<div>
<label>Contact No</label>
<input type="text" name="contactNo" value="<%= r.getContactNo() %>" required>
</div>
</div>

<div class="row">
<div>
<label>Guest Name</label>
<input type="text" name="guestName" value="<%= r.getGuestName() %>" required>
</div>

<div>
<label>Room Type</label>
<select name="roomTypeId">

<% for(RoomType rt : roomTypes){ %>

<option value="<%= rt.getId() %>"
<%= rt.getId()==r.getRoomTypeId() ? "selected":"" %>>

<%= rt.getName() %> - <%= rt.getRatePerNight() %>

</option>

<% } %>

</select>

</div>
</div>

<div class="row">
<div>
<label>Address</label>
<input type="text" name="address" value="<%= r.getAddress() %>" required>
</div>
</div>

<div class="row">
<div>
<label>Check-in</label>
<input type="date" name="checkIn" value="<%= r.getCheckIn() %>" required>
</div>

<div>
<label>Check-out</label>
<input type="date" name="checkOut" value="<%= r.getCheckOut() %>" required>
</div>
</div>

<div class="actions">
<button type="submit">Update Reservation</button>
</div>

</form>

</div>

</body>
</html>