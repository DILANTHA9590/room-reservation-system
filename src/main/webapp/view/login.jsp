<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>

<h2>Ocean View Resort - Login</h2>

<form action="${pageContext.request.contextPath}/login" method="post">
    Email: <input type="email" name="email" required /><br><br>
    Password: <input type="password" name="password" required /><br><br>
    <button type="submit">Login</button>
</form>

<p style="color:red;">
    ${error}
</p>

</body>
</html>