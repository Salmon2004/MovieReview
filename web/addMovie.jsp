<%-- 
    Document   : addMovie
    Created on : 12 Jun 2025, 3:48:14 pm
    Author     : U S E R
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html> 
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Movie</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            background-color: #0c0422;
            color: white;
            font-family: Arial, sans-serif;
            padding: 2rem;
        }
        h2 {
            margin-bottom: 1.5rem;
        }
        form {
            max-width: 600px;
            margin: auto;
            background-color: #1f1f2f;
            padding: 2rem;
            border-radius: 10px;
        }
        label {
            display: block;
            margin-top: 1rem;
        }
        input, textarea {
            width: 100%;
            padding: 0.6rem;
            margin-top: 0.3rem;
            border-radius: 5px;
            border: none;
            font-size: 1rem;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            font-weight: bold;
            cursor: pointer;
            margin-top: 1.5rem;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        a.back-link {
            display: inline-block;
            margin-top: 1.5rem;
            color: #ffa94d;
            text-decoration: none;
        }
        a.back-link:hover {
            color: white;
        }
    </style>
</head>
<body>
    <h2>➕ Add New Movie</h2>

    <form action="MovieServlet" method="post">
        <input type="hidden" name="action" value="add" />

        <label>Title:</label>
        <input type="text" name="title" required />

        <label>Genre:</label>
        <input type="text" name="genre" required />

        <label>Release Date:</label>
        <input type="date" name="releaseDate" required />

        <label>Director:</label>
        <input type="text" name="director" required />

        <label>Cast:</label>
        <input type="text" name="cast" required />

        <label>Rating (e.g. 8.5):</label>
        <input type="number" step="0.1" name="rating" required />

        <label>Image File (filename only, e.g. inception.jpg):</label>
        <input type="text" name="imageFile" required />

        <label>Description:</label>
        <textarea name="description" rows="4" required></textarea>

        <input type="submit" value="Add Movie" />
    </form>

    <a href="${pageContext.request.contextPath}/movieManagement.jsp" class="back-link">← Back to Movie Management</a>
</body>
</html>

