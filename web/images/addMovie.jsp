<%-- 
    Document   : addMovie
    Created on : 12 Jun 2025, 3:22:05 pm
    Author     : U S E R
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Movie</title>
</head>
<body>
    <h2>Add Movie</h2>
    <form action="MovieServlet" method="post">
        <input type="hidden" name="action" value="add">
        Title: <input type="text" name="title" required><br>
        Genre: <input type="text" name="genre" required><br>
        Release Date: <input type="date" name="releaseDate" required><br>
        Director: <input type="text" name="director" required><br>
        Cast: <input type="text" name="cast"><br>
        Rating: <input type="number" name="rating" step="0.1" min="0" max="10"><br>
        Image File Name: <input type="text" name="imageFile"><br>
        Description: <textarea name="description" rows="4" cols="50"></textarea><br>
        <button type="submit">Add Movie</button>
    </form>
    <a href="movieManagement.jsp">Cancel</a>
</body>
</html>

