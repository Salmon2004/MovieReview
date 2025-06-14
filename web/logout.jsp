<%-- 
    Document   : logout
    Created on : 12 Jun 2025, 2:30:43 pm
    Author     : U S E R
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logged Out - CineLuxe</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            background-color: #0c0422;
            color: white;
            font-family: Arial, sans-serif;
            text-align: center;
            padding-top: 100px;
        }

        .logout-box {
            background-color: #1f1f2f;
            padding: 2rem;
            border-radius: 12px;
            display: inline-block;
        }

        h2 {
            color: #ff4f81;
            margin-bottom: 1rem;
        }

        a {
            color: white;
            background-color: #444;
            padding: 0.6rem 1.2rem;
            text-decoration: none;
            border-radius: 8px;
            margin-top: 1rem;
            display: inline-block;
            transition: background-color 0.3s ease;
        }

        a:hover {
            background-color: #666;
        }

        .icon {
            font-size: 4rem;
            color: #ff4f81;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>

    <div class="logout-box">
        <div class="icon">
            <i class="fas fa-sign-out-alt"></i>
        </div>
        <h2>You have been logged out</h2>
        <a href="${pageContext.request.contextPath}/login.jsp"><i class="fas fa-sign-in-alt"></i> Login Again</a>
    </div>

</body>
</html>


