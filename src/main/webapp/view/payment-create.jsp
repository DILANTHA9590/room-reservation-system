<%@ page import="model.Reservation" %>
<%
Reservation r = (Reservation) request.getAttribute("reservation");
if (r == null) {
    out.print("Reservation not found");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Payment</title>

<style>

body{
 font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
 background:#f4f6f9;
 padding:40px;
 margin:0;
}

/* Card */

.card{
 background:#ffffff;
 padding:30px;
 width:420px;

 border-radius:10px;

 margin:auto;

 box-shadow:0 10px 25px rgba(0,0,0,0.08);
}

h2{
 margin-bottom:25px;
 color:#2c3e50;
 text-align:center;
}

/* Labels */

label{
 font-weight:600;
 color:#333;
 display:block;
 margin-bottom:6px;
}

/* Inputs */

input, select{
 width:100%;
 padding:10px;

 border:1px solid #ccc;
 border-radius:6px;

 margin-bottom:15px;

 font-size:14px;
 transition:0.2s;
}

input:focus, select:focus{
 border-color:#27ae60;
 outline:none;
 box-shadow:0 0 5px rgba(39,174,96,0.3);
}

/* Readonly */

input[readonly]{
 background:#f5f5f5;
}

/* Button */

button{
 width:100%;
 padding:12px;

 background:#27ae60;
 color:#fff;

 border:none;
 border-radius:6px;

 font-weight:600;
 cursor:pointer;

 transition:0.2s;
}

button:hover{
 background:#219150;
}

</style>

</head>

<body>

<div class="card">

<h2>Payment</h2>

<form action="<%= request.getContextPath() %>/payments/create" method="post">

<input type="hidden" name="reservationId" value="<%= r.getReservationId() %>" />

<label>Reservation No</label>
<input type="text" value="<%= r.getReservationNo() %>" readonly />

<label>Guest Name</label>
<input type="text" value="<%= r.getGuestName() %>" readonly />

<label>Amount</label>
<input type="number" step="0.01" name="amount" required />

<label>Payment Method</label>
<select name="method">
<option value="CASH">Cash</option>
<option value="CARD">Card</option>
</select>

<button type="submit">Pay Now</button>

</form>

</div>

</body>
</html>