<!DOCTYPE html>
<html>
<head>
    <title>Login</title>

    <style>
        body{
            font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            display:flex;
            justify-content:center;
            align-items:center;
            height:100vh;
            margin:0;
        }

        .card{
            background:#fff;
            width:400px;
            padding:40px;
            border-radius:12px;
            box-shadow:0 15px 35px rgba(0,0,0,0.2);
        }

        h2{
            text-align:center;
            margin:0 0 25px 0;
            color:#2a5298;
            font-size:22px;
        }

        label{
            font-weight:600;
            display:block;
            margin-bottom:6px;
            color:#333;
        }

        input{
            width:100%;
            padding:10px;
            border:1px solid #ccc;
            border-radius:6px;
            margin-bottom:15px;
            transition:0.3s;
        }

        input:focus{
            border-color:#2a5298;
            outline:none;
            box-shadow:0 0 5px rgba(42,82,152,0.4);
        }

        button{
            width:100%;
            padding:12px;
            background:#2a5298;
            color:white;
            border:none;
            border-radius:6px;
            font-weight:700;
            cursor:pointer;
            transition:0.3s;
        }

        button:hover{
            background:#1e3c72;
        }

        .error{
            color:#d60000;
            text-align:center;
            margin-top:12px;
            min-height:18px;
        }

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

        .subtitle{
            text-align:center;
            color:#666;
            font-size:13px;
            margin-top:-15px;
            margin-bottom:20px;
        }
    </style>
</head>

<body>

<div class="card">
    <h2>Ocean View Resort</h2>
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

</body>
</html>