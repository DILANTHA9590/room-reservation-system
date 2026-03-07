<%@ page import="model.User" %>
<%
User u = (User) session.getAttribute("loggedUser");
if (u == null) {
    response.sendRedirect(request.getContextPath() + "/view/login.jsp");
    return;
}

if (!"ADMIN".equalsIgnoreCase(u.getRole())) {
    out.print("403 - Access Denied (ADMIN only)");
    return;
}

String loginSuccess = (String) session.getAttribute("loginSuccess");
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard</title>
<link rel="icon" type="image/png"
href="<%=request.getContextPath()%>/assets/images/favicon.png">
<style>

:root{
    --bg: #0f172a;
    --sidebar: #111827;
    --sidebar2:#0b1220;
    --text: #e5e7eb;
    --muted:#9ca3af;
    --brand:#38bdf8;
    --brand2:#60a5fa;
    --border: rgba(255,255,255,0.08);
}

*{
    box-sizing:border-box;
}

body{
    margin:0;
    font-family:"Segoe UI", Tahoma, Arial, sans-serif;

    background:
    radial-gradient(1200px 600px at 20% 0%, rgba(56,189,248,0.18), transparent 60%),
    radial-gradient(900px 500px at 80% 20%, rgba(96,165,250,0.14), transparent 55%),
    var(--bg);

    color:var(--text);
}

/* Layout */

.container{
    display:flex;
    height:100vh;
}

/* Sidebar */

.sidebar{
    width:260px;
    padding:18px;

    background:linear-gradient(180deg,var(--sidebar),var(--sidebar2));
    border-right:1px solid var(--border);

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
    background:rgba(255,255,255,0.04);
}

.logo{
    width:34px;
    height:34px;
    border-radius:10px;
    background:linear-gradient(135deg,var(--brand),var(--brand2));
}

.brand h3{
    margin:0;
    font-size:14px;
    text-transform:uppercase;
}

.userbox{
    padding:12px;
    border-radius:12px;
    background:rgba(255,255,255,0.04);
}

.userbox .welcome{
    font-size:12px;
    color:var(--muted);
}

.userbox .name{
    font-weight:700;
}

.nav{
    display:flex;
    flex-direction:column;
    gap:8px;
}

.sidebar a{
    padding:12px;
    border-radius:10px;
    color:var(--text);
    text-decoration:none;
}

.sidebar a:hover{
    background:rgba(56,189,248,0.15);
}

.logoutForm{
    margin-top:auto;
}

.logoutBtn{
    width:100%;
    padding:12px;
    border:none;
    border-radius:10px;
    font-weight:bold;
    cursor:pointer;
    background:linear-gradient(135deg,var(--brand),var(--brand2));
}

/* Content */

.content{
    flex:1;
    padding:20px;
}

.frameWrap{
    width:100%;
    height:100%;
    border-radius:16px;
    overflow:hidden;
    border:1px solid var(--border);
}

iframe{
    width:100%;
    height:100%;
    border:none;
    background:white;
}

/* Toast Notification */

.toast{
position:fixed;
top:20px;
right:20px;
background:#27ae60;
color:white;
padding:14px 20px;
border-radius:8px;
font-weight:600;
box-shadow:0 5px 20px rgba(0,0,0,0.3);
z-index:9999;
}

</style>

</head>

<body>

<% if(loginSuccess != null){ %>
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
<h3>Ocean View Resort</h3>
</div>

<div class="userbox">
<div class="welcome">Welcome</div>
<div class="name"><%= u.getFullName() %></div>
</div>

<div class="nav">

<a href="<%= request.getContextPath() %>/admin/reports" target="contentFrame">
Reports
</a>

<a href="<%= request.getContextPath() %>/admin/room-types" target="contentFrame">
Manage Room Types
</a>

<a href="<%= request.getContextPath() %>/admin/users" target="contentFrame">
Manage Staff Users
</a>

<a href="<%= request.getContextPath() %>/admin/reservations" target="contentFrame">
All Reservations
</a>

<a href="<%= request.getContextPath() %>/reservations/create" target="contentFrame">
Create Reservation
</a>

</div>

<form class="logoutForm" action="<%= request.getContextPath() %>/logout" method="post">
<button class="logoutBtn">Logout</button>
</form>

</div>

<div class="content">

<div class="frameWrap">

<iframe
name="contentFrame"
src="<%= request.getContextPath() %>/admin/reports">
</iframe>

</div>

</div>

</div>

<script>

setTimeout(function(){
 const toast = document.querySelector(".toast");
 if(toast){
  toast.style.display="none";
 }
},3000);

</script>

</body>
</html>