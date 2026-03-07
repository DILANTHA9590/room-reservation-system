<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png"
href="<%=request.getContextPath()%>/assets/images/favicon.png">

<title>Login</title>

<style>

body{
 font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;

 background:
 linear-gradient(rgba(0,0,0,0.6),rgba(0,0,0,0.6)),
 url("<%=request.getContextPath()%>/assets/images/login_background.jpg");

 background-size:cover;
 background-position:center;

 display:flex;
 justify-content:center;
 align-items:center;

 height:100vh;
 margin:0;
}

/* Resort Brand */

.brand{
 text-align:center;
 margin-bottom:15px;
}

.brand h1{
 margin:0;
 font-size:28px;
 font-weight:700;
 color:white;
 letter-spacing:1px;
 text-shadow:0 3px 10px rgba(0,0,0,0.6);
}

.brand p{
 margin:4px 0 20px 0;
 font-size:13px;
 color:#e2e8f0;
}

/* Glass Card */

.card{
 background:rgba(255,255,255,0.95);
 width:400px;
 padding:40px;

 border-radius:12px;

 backdrop-filter:blur(10px);

 box-shadow:0 20px 40px rgba(0,0,0,0.4);

 animation:fadeIn 0.7s ease;
}

/* Title */

h2{
 text-align:center;
 margin:0 0 10px 0;
 color:#2a5298;
 font-size:22px;
}

.subtitle{
 text-align:center;
 color:#666;
 font-size:13px;
 margin-bottom:25px;
}

/* Labels */

label{
 font-weight:600;
 display:block;
 margin-bottom:6px;
 color:#333;
}

/* Inputs */

input{
 width:100%;
 padding:12px;

 border:1px solid #ccc;
 border-radius:6px;

 margin-bottom:15px;

 transition:0.3s;
 font-size:14px;
}

input:focus{
 border-color:#2a5298;
 outline:none;
 box-shadow:0 0 8px rgba(42,82,152,0.4);
}

/* Button */

button{
 width:100%;
 padding:12px;

 background:linear-gradient(135deg,#2a5298,#1e3c72);

 color:white;
 border:none;
 border-radius:6px;

 font-weight:700;
 font-size:15px;

 cursor:pointer;
 transition:0.3s;
}

button:hover{
 transform:translateY(-2px);
 box-shadow:0 8px 20px rgba(0,0,0,0.3);
}

/* Error */

.error{
 color:#d60000;
 text-align:center;
 margin-top:12px;
 min-height:18px;
}

/* Link */

.link{
 text-align:center;
 margin-top:14px;
 font-size:14px;
}

.link a{
 color:#2a5298;
 text-decoration:none;
 font-weight:600;
}

.link a:hover{
 text-decoration:underline;
}

/* Animation */

@keyframes fadeIn{
 from{
 opacity:0;
 transform:translateY(20px);
 }
 to{
 opacity:1;
 transform:translateY(0);
 }
}

</style>

</head>

<body>

<div>

<!-- Resort Branding -->

<div class="brand">
<h1>Ocean View Resort</h1>
<p>Reservation Management System</p>
</div>

<div class="card">

<h2>Login</h2>
<div class="subtitle">Sign in to continue</div>

<form action="${pageContext.request.contextPath}/login" method="post">

<label>Email</label>
<input type="email" name="email" required />

<label>Password</label>
<input type="password" name="password" required />

<button type="submit">Login</button>

</form>

<p class="error">${error}</p>

<div class="link">
Don't have an account?
<a href="<%= request.getContextPath() %>/view/register.jsp">Create Account</a>
</div>

</div>

</div>

</body>
</html>