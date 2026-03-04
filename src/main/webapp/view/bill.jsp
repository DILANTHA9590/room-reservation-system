<%@ page import="model.Reservation" %>
<%
Reservation r = (Reservation) request.getAttribute("reservation");
Long nights = (Long) request.getAttribute("nights");
Double total = (Double) request.getAttribute("total");

if (r == null) {
    out.print("No bill data");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Bill</title>
    <style>
        body{ font-family: Arial; background:#f6f7fb; padding:20px; }
        .bill{ max-width:700px; margin:auto; background:#fff; padding:20px; border-radius:10px;
               box-shadow:0 2px 12px rgba(0,0,0,0.08); }
        .head{ display:flex; justify-content:space-between; align-items:center; }
        h2{ margin:0; }
        table{ width:100%; border-collapse:collapse; margin-top:15px; }
        td{ padding:10px; border-bottom:1px solid #eee; }
        .total{ font-size:18px; font-weight:700; }
        .actions{ margin-top:16px; display:flex; gap:10px; }
        .btn{ padding:10px 14px; border:none; border-radius:8px; cursor:pointer; }
        .print{ background:#2563eb; color:white; }
        .back{ background:#e5e7eb; }
        @media print{
            .actions{ display:none; }
            body{ background:#fff; }
            .bill{ box-shadow:none; }
        }
    </style>
</head>
<body>

<div class="bill">
    <div class="head">
        <div>
            <h2>Ocean View Resort - Bill</h2>
            <div>Reservation No: <b><%= r.getReservationNo() %></b></div>
        </div>
        <div>
            <small>Date: <%= java.time.LocalDate.now() %></small>
        </div>
    </div>

    <table>
        <tr><td>Guest Name</td><td><b><%= r.getGuestName() %></b></td></tr>
        <tr><td>Contact</td><td><%= r.getContactNo() %></td></tr>
        <tr><td>Room Type</td><td><%= r.getRoomTypeName() %></td></tr>
        <tr><td>Check-in</td><td><%= r.getCheckIn() %></td></tr>
        <tr><td>Check-out</td><td><%= r.getCheckOut() %></td></tr>
        <tr><td>Nights</td><td><%= nights %></td></tr>
        <tr><td>Rate per Night</td><td><%= String.format("%.2f", r.getRatePerNight()) %></td></tr>
        <tr><td class="total">Total</td><td class="total"><%= String.format("%.2f", total) %></td></tr>
    </table>

    <div class="actions">
        <button class="btn print" onclick="window.print()">Print</button>
        <button class="btn back" onclick="history.back()">Back</button>
    </div>
</div>

</body>
</html>