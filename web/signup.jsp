<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up</title>
    <style>
        body {
            background-color: #0c0422;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: white;
        }
        .signup-container {
            width: 90%;
            max-width: 400px;
            background-color: #1a1a2e;
            border-radius: 20px;
            padding: 1.5rem;
            text-align: center;
        }
        .signup-container img {
            width: 100%;
            max-height: 250px;
            object-fit: cover;
            border-radius: 12px;
        }
        .signup-container h2 {
            margin: 1rem 0 0.2rem;
        }
        .signup-container p {
            font-size: 0.9rem;
            color: #ccc;
        }
        form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            margin-top: 1rem;
        }
        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="date"] {
            background-color: #333;
            color: white;
            padding: 0.75rem;
            border-radius: 10px;
            border: none;
            width: 100%;
        }
        button {
            background-color: white;
            color: #0c0422;
            font-weight: bold;
            padding: 0.75rem;
            border: none;
            border-radius: 10px;
            cursor: pointer;
        }
        .login-link {
            margin-top: 1rem;
            font-size: 0.9rem;
        }
        .login-link a {
            color: #ccc;
            text-decoration: none;
        }
        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="signup-container">
    <img src="${pageContext.request.contextPath}/images/cinelux.png" alt="Cinelux Banner">
    <h2>Create new Account</h2>
    <p>Already Registered? <a href="login.jsp" style="color:white; text-decoration:underline;">Log in here.</a></p>
    <form action="SignupServlet" method="post">
        <input type="text" name="username" placeholder="Username" required>
        <input type="email" name="email" placeholder="example@gmail.com" required>
        <input type="password" name="password" placeholder="********" required>
        <input type="date" name="profileInfo" placeholder="dd/mm/yyyy" required>
        <button type="submit">Sign up</button>
    </form>
</div>
</body>
</html>