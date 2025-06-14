<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome</title>
    <meta http-equiv="refresh" content="3; URL=homepage.jsp">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #0c0422;
            color: #ffcc70;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
        }

        .welcome-container {
            text-align: center;
            padding: 3rem;
            background: #1a1333;
            border-radius: 15px;
            box-shadow: 0 0 25px rgba(255, 204, 112, 0.2);
            animation: fadeInScale 1s ease forwards;
            opacity: 0;
            transform: scale(0.95);
        }

        .welcome-container h1 {
            font-size: 2rem;
            margin-bottom: 1rem;
            color: #ffffff;
        }

        .welcome-container p {
            font-size: 1rem;
            color: #cccccc;
        }

        @keyframes fadeInScale {
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #ffcc70;
            animation: bounce 1.5s infinite ease-in-out;
        }

        @keyframes bounce {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-10px);
            }
        }
    </style>
</head>
<body>
<div class="welcome-container">
    <div class="icon">
        <i class="fas fa-film"></i>
    </div>
    <h1>Welcome, <%= email %>!</h1>
    <p>Redirecting to CineLuxe homepage...</p>
</div>
</body>
</html>
