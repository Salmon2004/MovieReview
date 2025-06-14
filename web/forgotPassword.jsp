<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password - CineLuxe</title>
    <style>
        body {
            margin: 0;
            background-color: #0c0422;
            font-family: 'Segoe UI', sans-serif;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .form-container {
            background-color: #1a1a2e;
            padding: 2rem;
            border-radius: 20px;
            width: 90%;
            max-width: 360px;
            text-align: center;
        }

        img {
            width: 100%;
            border-radius: 10px;
            margin-bottom: 1.5rem;
        }

        h2 {
            margin-bottom: 1rem;
        }

        label {
            display: block;
            margin: 0.6rem 0 0.2rem;
            text-align: left;
            font-size: 0.9rem;
        }

        input[type="text"], input[type="email"] {
            width: 100%;
            padding: 0.7rem;
            border: none;
            border-radius: 10px;
            background-color: #2e2e48;
            color: white;
            font-size: 1rem;
        }

        input::placeholder {
            color: #bbb;
            font-style: italic;
        }

        button {
            margin-top: 1rem;
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

        .back-btn {
            margin-top: 1rem;
            display: block;
            text-align: center;
            color: #9ecbff;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .message, .error {
            margin-top: 1rem;
            font-size: 0.9rem;
        }

        .message {
            color: #4effb1;
        }

        .error {
            color: #ff4d4d;
        }
    </style>
</head>
<body>
<div class="form-container">
    <img src="${pageContext.request.contextPath}/images/skillissue.jpg" alt="Forgot Password Banner" />
    <h2>Forgot Password</h2>
    <form action="ForgotPasswordServlet" method="post">
        <label for="email">Enter your email address:</label>
        <input type="email" id="email" name="email" placeholder="you@example.com" required />
        <button type="submit">Send Reset Link</button>
    </form>

    <a href="${pageContext.request.contextPath}/login.jsp" class="back-btn">Back to Login</a>

    <%
        String message = (String) request.getAttribute("message");
        String error = (String) request.getAttribute("error");
        if (message != null) {
    %>
        <div class="message"><%= message %></div>
    <%
        } else if (error != null) {
    %>
        <div class="error"><%= error %></div>
    <%
        }
    %>
</div>
</body>
</html>
