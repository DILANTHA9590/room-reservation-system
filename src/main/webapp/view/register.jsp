<!DOCTYPE html>
<html>
<head>
<link rel="icon" type="image/png"
href="<%=request.getContextPath()%>/assets/images/favicon.png">
<title>Create Account</title>

<style>

body{
 font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;

 background:
 linear-gradient(rgba(0,0,0,0.6),rgba(0,0,0,0.6)),
 url("<%=request.getContextPath()%>/assets/images/login_background.jpg");

 background-size:cover;
 background-position:center;
 height:100vh;

 display:flex;
 justify-content:center;
 align-items:center;
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
 padding:40px;
 width:420px;

 border-radius:12px;

 backdrop-filter:blur(10px);

 box-shadow:0 20px 40px rgba(0,0,0,0.4);

 animation:fadeIn 0.7s ease;
}

/* Title */

h2{
 text-align:center;
 margin-bottom:25px;
 color:#2a5298;
}

/* Inputs */

input,select{
 width:100%;
 padding:12px;
 margin-top:5px;
 margin-bottom:15px;

 border-radius:6px;
 border:1px solid #ccc;

 font-size:14px;

 transition:0.3s;
}

input:focus,select:focus{
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

 cursor:pointer;
 font-weight:bold;
 font-size:15px;

 transition:0.3s;
}

button:hover{
 transform:translateY(-2px);
 box-shadow:0 8px 20px rgba(0,0,0,0.3);
}

/* Error */

.error{
 color:red;
 text-align:center;
 margin-top:10px;
}

/* Link */

.back-link{
 text-align:center;
 margin-top:15px;
}

.back-link a{
 text-decoration:none;
 color:#2a5298;
 font-weight:600;
}

.back-link a:hover{
 text-decoration:underline;
}

/* Label */

label{
 font-weight:500;
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

<!-- Resort Title -->

<div class="brand">
<h1>Ocean View Resort</h1>
<p>Reservation Management System</p>
</div>

<div class="card">

<h2>Create Account</h2>

<form action="${pageContext.request.contextPath}/register" method="post">

<label>Full Name</label>
<input type="text" name="fullName" required />

<label>Email</label>
<input type="email" name="email" required />

<label>Password</label>
<input type="password" name="password" required />

<label>Role</label>
<select name="role" required>
<option value="ADMIN">ADMIN</option>
</select>

<label>Admin Key</label>
<input type="text" name="adminKey" placeholder="Enter admin key" />

<button type="submit">Register</button>

</form>

<p class="error">${error}</p>

<div class="back-link">
Already have an account?
<a href="<%= request.getContextPath() %>/view/login.jsp">Sign in</a>
</div>

</div>

</div>

</body>
</html>