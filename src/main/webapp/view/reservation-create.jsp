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
body{font-family:Arial;background:#f4f6f9;margin:20px;}
.card{background:#fff;padding:20px;border-radius:10px;max-width:800px;box-shadow:0 2px 10px rgba(0,0,0,.08);}
h2{color:#2c3e50;margin-top:0;}
.row{display:flex;gap:12px;margin-bottom:12px;}
.row > div{flex:1;}
label{display:block;margin-bottom:6px;color:#2c3e50;font-weight:600;}
input,select{width:100%;padding:10px;border:1px solid #ccc;border-radius:8px;}
button{padding:10px 14px;border:none;border-radius:8px;background:#2c3e50;color:#fff;cursor:pointer;}
button:hover{opacity:.9;}
.err{color:#c0392b;font-weight:600;margin-bottom:10px;}
.top{display:flex;justify-content:space-between;align-items:center;}
a.back{text-decoration:none;color:#2c3e50;font-weight:700;}
</style>
</head>
<body>

<div class="card">
  <div class="top">
    <h2>Create Reservation</h2>
    <a class="back" href="<%= request.getContextPath() %>/<%= "ADMIN".equalsIgnoreCase(u.getRole()) ? "admin/dashboard.jsp" : "staff/dashboard.jsp" %>">⬅ Back</a>
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
          <% if (roomTypes != null) {
               for (RoomType rt : roomTypes) { %>
            <option value="<%= rt.getId() %>"><%= rt.getName() %> - <%= rt.getRatePerNight() %></option>
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

    <button type="submit">Create Reservation</button>
  </form>

</div>

</body>
</html>