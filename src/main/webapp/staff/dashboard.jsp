<%@ page import="model.User" %>
<%
User u = (User) session.getAttribute("loggedUser");
if (u == null) {
    response.sendRedirect(request.getContextPath() + "/view/login.jsp");
    return;
}
if (!"RECEPTIONIST".equalsIgnoreCase(u.getRole())) {
    out.print("403 - Access Denied (RECEPTIONIST only)");
    return;
}

String pageKey = request.getParameter("page");
String iframeSrc = request.getContextPath() + "/reservations/create";

if (pageKey != null) {
    if ("createReservation".equalsIgnoreCase(pageKey)) iframeSrc = request.getContextPath() + "/reservations/create";
    else if ("reservations".equalsIgnoreCase(pageKey)) iframeSrc = request.getContextPath() + "/staff/reservations";
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Receptionist Dashboard</title>
<link rel="icon" type="image/png"
href="<%=request.getContextPath()%>/assets/images/favicon.png">
<style>

<style>
:root{
    --bg: #0f172a;
    --sidebar: #111827;
    --sidebar2:#0b1220;
    --text: #e5e7eb;
    --muted:#9ca3af;
    --brand:#34d399;
    --brand2:#22c55e;
    --border: rgba(255,255,255,0.08);
}
*{ box-sizing:border-box; }

body{
    margin:0;
    font-family: "Segoe UI", Tahoma, Arial, sans-serif;
    background: radial-gradient(1200px 600px at 20% 0%, rgba(34,197,94,0.14), transparent 60%),
                radial-gradient(900px 500px at 80% 20%, rgba(52,211,153,0.12), transparent 55%),
                var(--bg);
    color: var(--text);
}

.container{ display:flex; height:100vh; overflow:hidden; }

/* Sidebar */

.sidebar{
    width:260px;
    padding:18px;
    background: linear-gradient(180deg, var(--sidebar), var(--sidebar2));
    border-right: 1px solid var(--border);
    display:flex;
    flex-direction:column;
    gap:14px;
}

.brand{
    display:flex;
    align-items:center;
    gap:10px;
    padding:10px 12px;
    border-radius:12px;
    background: rgba(255,255,255,0.04);
    border: 1px solid var(--border);
}

.logo{
    width:34px;
    height:34px;
    border-radius:10px;
    background: linear-gradient(135deg, var(--brand), var(--brand2));
}

.brand h3{
    margin:0;
    font-size:14px;
    letter-spacing:0.8px;
    text-transform:uppercase;
}

.userbox{
    padding:12px;
    border-radius:12px;
    background: rgba(255,255,255,0.04);
    border: 1px solid var(--border);
}

.userbox .welcome{
    font-size:12px;
    color: var(--muted);
    margin-bottom:6px;
}

.userbox .name{
    font-weight:700;
    font-size:14px;
}

.nav{
    display:flex;
    flex-direction:column;
    gap:8px;
}

.sidebar a{
    display:flex;
    align-items:center;
    justify-content:space-between;
    padding:12px;
    border-radius:12px;
    color: var(--text);
    text-decoration:none;
    border: 1px solid transparent;
    transition: 0.25s;
    font-size:14px;
}

.sidebar a:hover{
    background: rgba(34,197,94,0.10);
    border-color: rgba(34,197,94,0.18);
    transform: translateX(2px);
}

.divider{
    height:1px;
    background: var(--border);
    margin:6px 0;
}

.logoutForm{
    margin-top:auto;
    padding-top:10px;
}

.logoutBtn{
    width:100%;
    padding:12px;
    border:none;
    border-radius:12px;
    cursor:pointer;
    font-weight:700;
    color:#0b1220;
    background: linear-gradient(135deg, var(--brand), var(--brand2));
}

.logoutBtn:hover{
    filter: brightness(1.05);
    transform: translateY(-1px);
}

.content{
    flex:1;
    padding:16px;
}

.frameWrap{
    width:100%;
    height:100%;
    border-radius:16px;
    overflow:hidden;
    border: 1px solid var(--border);
    background: rgba(255,255,255,0.03);
}

iframe{
    width:100%;
    height:100%;
    border:none;
    background:white;
}

/* Login success toast */

.toast{
position:fixed;
top:20px;
right:20px;
background:#22c55e;
color:white;
padding:14px 20px;
border-radius:8px;
font-weight:600;
box-shadow:0 5px 20px rgba(0,0,0,0.3);
z-index:9999;
animation:fadeToast 0.4s ease;
}

@keyframes fadeToast{
from{
opacity:0;
transform:translateY(-10px);
}
to{
opacity:1;
transform:translateY(0);
}
}
</style>

</head>

<body>

<%
String loginSuccess = (String) session.getAttribute("loginSuccess");
if(loginSuccess != null){
%>

<div class="toast">
<%= loginSuccess %>
</div>

<%
session.removeAttribute("loginSuccess");
}
%>

<div class="container">

<div class="sidebar">

<div class="brand">
<div class="logo"></div>
<h3>Reception Panel</h3>
</div>

<div class="userbox">
<div class="welcome">Welcome</div>
<div class="name"><%= u.getFullName() %></div>
</div>

<div class="nav">

<a href="<%= request.getContextPath() %>/admin/reports" target="contentFrame">
Reports
</a>

<a href="<%= request.getContextPath() %>/reservations/create" target="contentFrame">
Create Reservation
</a>

<a href="<%= request.getContextPath() %>/admin/reservations" target="contentFrame">
All Reservations
</a>

</div>

<div class="divider"></div>

<form class="logoutForm" action="<%= request.getContextPath() %>/logout" method="post">
<button class="logoutBtn" type="submit">Logout</button>
</form>

</div>

<div class="content">

<div class="frameWrap">
<iframe name="contentFrame" src="<%= iframeSrc %>"></iframe>
</div>

</div>

</div>

<script>
setTimeout(function(){
 const toast=document.querySelector(".toast");
 if(toast){
  toast.style.display="none";
 }
},3000);
</script>

</body>
</html>