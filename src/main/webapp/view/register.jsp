<!DOCTYPE html>
<html>
<head>
    <title>Create Account</title>

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .card {
            background: #ffffff;
            padding: 40px;
            width: 400px;
            border-radius: 12px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #2a5298;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border-radius: 6px;
            border: 1px solid #ccc;
            transition: 0.3s;
        }

        input:focus, select:focus {
            border-color: #2a5298;
            outline: none;
            box-shadow: 0 0 5px rgba(42,82,152,0.4);
        }

        button {
            width: 100%;
            padding: 12px;
            background: #2a5298;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            transition: 0.3s;
        }

        button:hover {
            background: #1e3c72;
        }

        .error {
            color: red;
            text-align: center;
            margin-top: 10px;
        }

        .back-link {
            text-align: center;
            margin-top: 15px;
        }

        .back-link a {
            text-decoration: none;
            color: #2a5298;
            font-weight: 500;
        }

        .back-link a:hover {
            text-decoration: underline;
        }

        label {
            font-weight: 500;
        }
    </style>
</head>

<body>

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
            <option value="RECEPTIONIST">RECEPTIONIST</option>
            <option value="ADMIN">ADMIN</option>
        </select>

        <label>Admin Key (only if ADMIN)</label>
        <input type="text" name="adminKey" placeholder="Enter admin key if needed" />

        <button type="submit">Register</button>
    </form>

    <p class="error">${error}</p>

    <div class="back-link">
       <p class="back-link">
    Already have an account? 
    <a href="<%= request.getContextPath() %>/view/login.jsp">Sign in</a>
</p>
    </div>

</div>

</body>
</html>