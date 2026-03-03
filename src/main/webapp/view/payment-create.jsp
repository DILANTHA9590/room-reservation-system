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
body { font-family: Arial; background:#f4f6f9; padding:30px; }
.card { background:#fff; padding:25px; border-radius:8px; width:400px; margin:auto; box-shadow:0 2px 8px rgba(0,0,0,0.1); }
h2 { margin-bottom:20px; }
input, select { width:100%; padding:8px; margin-bottom:15px; }
button { background:#27ae60; color:#fff; padding:10px; border:none; width:100%; border-radius:5px; }
button:hover { opacity:0.9; }
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