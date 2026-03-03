<!DOCTYPE html>
<html>
<head><title>Create Account</title></head>
<body>

<h2>Create Account</h2>

<form action="${pageContext.request.contextPath}/register" method="post">
    Full Name: <input type="text" name="fullName" required /><br><br>
    Email: <input type="email" name="email" required /><br><br>
    Password: <input type="password" name="password" required /><br><br>

    Role:
    <select name="role" required>
        <option value="RECEPTIONIST">RECEPTIONIST</option>
        <option value="ADMIN">ADMIN</option>
    </select>
    <br><br>

    <!-- optional simple protection for ADMIN -->
    Admin Key (only if ADMIN): <input type="text" name="adminKey" placeholder="optional" /><br><br>

    <button type="submit">Register</button>
</form>

<p style="color:red;">${error}</p>
<a href="<%= request.getContextPath() %>/view/login.jsp">Back to Login</a>

</body>
</html>