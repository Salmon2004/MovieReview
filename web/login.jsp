<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - CineLuxe</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #0c0422;
            font-family: 'Segoe UI', sans-serif;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background-color: #1a1a2e;
            padding: 2rem;
            border-radius: 20px;
            width: 90%;
            max-width: 350px;
            text-align: center;
        }

        .login-container img {
            width: 100%;
            border-radius: 10px;
            margin-bottom: 1.5rem;
        }

        h2 {
            margin: 0 0 1rem;
            font-weight: 500;
        }

        label {
            text-align: left;
            display: block;
            margin: 0.5rem 0 0.2rem;
            font-size: 0.9rem;
            letter-spacing: 0.5px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 0.6rem;
            border-radius: 10px;
            border: none;
            background-color: #2e2e48;
            color: white;
            margin-bottom: 1rem;
            font-size: 1rem;
        }

        input::placeholder {
            color: #bbb;
            font-style: italic;
        }

        button {
            width: 100%;
            padding: 0.7rem;
            background-color: #4e9eff;
            border: none;
            border-radius: 10px;
            color: white;
            font-size: 1rem;
            cursor: pointer;
            font-weight: bold;
        }

        button:hover {
            background-color: #3678d8;
        }

        .link-group {
            margin-top: 1.2rem;
            font-size: 0.85rem;
        }

        .link-group a {
            color: #9ecbff;
            text-decoration: none;
            margin: 0 0.4rem;
        }

        .error-message {
            color: #ff4d4d;
            margin-top: 0.8rem;
        }
    </style>
</head>
<body>
<div class="login-container">
    <img src="${pageContext.request.contextPath}/images/cinelux.png" alt="CineLuxe Logo">
    <h2>Sign in to continue</h2>

    <form action="LoginServlet" method="post">
        <label for="email">Email</label>
        <input type="text" id="email" name="email" placeholder="Email" required>

        <label for="password">PASSWORD</label>
        <input type="password" id="password" name="password" placeholder="********" required>

        <button type="submit">Log in</button>
    </form>

    <% 
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) { 
    %>
        <div class="error-message"><%= errorMessage %></div>
    <% } %>

    <div class="link-group">
        <a href="${pageContext.request.contextPath}/forgotPassword.jsp">Forgot Password?</a> |
        <a href="${pageContext.request.contextPath}/signup.jsp">Signup</a>
    </div>
</div>
</body>
</html>
