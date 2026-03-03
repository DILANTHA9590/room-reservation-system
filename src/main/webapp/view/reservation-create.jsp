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
  font-family:Arial;
  background:#f4f6f9;
  margin:0;                 /* ✅ remove default margin */
  min-height:100vh;         /* ✅ full height */
  display:flex;             /* ✅ center */
  justify-content:center;   /* ✅ center */
  align-items:flex-start;   /* top-ish */
  padding:30px 15px;        /* ✅ spacing */
}

.card{
  background:#fff;
  padding:22px;
  border-radius:12px;
  width:100%;
  max-width:900px;          /* ✅ centered width */
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
a.back:hover{background:#e3e9f0;}

.err{
  color:#c0392b;
  font-weight:600;
  margin:10px 0 16px;
  background:#fdecea;
  border:1px solid #f5c2c7;
  padding:10px;
  border-radius:10px;
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
  font-size:14px;
}

input,select{
  width:100%;
  padding:10px;
  border:1px solid #cfd6de;
  border-radius:10px;
  outline:none;
}
input:focus,select:focus{
  border-color:#2c3e50;
  box-shadow:0 0 0 3px rgba(44,62,80,.12);
}

.actions{
  display:flex;
  justify-content:flex-start;
  margin-top:6px;
}

button{
  padding:10px 14px;
  border:none;
  border-radius:10px;
  background:#2c3e50;
  color:#fff;
  cursor:pointer;
  font-weight:700;
}
button:hover{opacity:.92;}

/* ✅ mobile responsive */
@media (max-width: 700px){
  .row{flex-direction:column;}
}
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

    <div class="actions">
      <button type="submit">Create Reservation</button>
    </div>

  </form>
</div>

</body>
</html>