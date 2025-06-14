<%-- 
    Document   : editMovie
    Created on : 12 Jun 2025, 3:03:20 pm
    Author     : U S E R
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, model.ReviewDAO" %>
<%
    String movieIdStr = request.getParameter("movie_id");
    if (movieIdStr == null || movieIdStr.isEmpty()) {
%>
    <h2 style="color:red;">Error: Missing movie ID.</h2>
    <a href="${pageContext.request.contextPath}/movieManagement.jsp">Back</a>
<%
        return;
    }
    int movieId = Integer.parseInt(movieIdStr);
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String title = "", genre = "", description = "", director = "", cast = "", imageFile = "";
    Date releaseDate = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinelux", "root", "admin");
        stmt = conn.prepareStatement("SELECT * FROM Movie WHERE movieID = ?");
        stmt.setInt(1, movieId);
        rs = stmt.executeQuery();
        if (rs.next()) {
            title = rs.getString("title");
            genre = rs.getString("genre");
            description = rs.getString("description");
            director = rs.getString("director");
            cast = rs.getString("cast");
            releaseDate = rs.getDate("releaseDate");
            imageFile = rs.getString("imageFile");
        } else {
%>
    <h2 style="color:red;">Movie not found.</h2>
    <a href="${pageContext.request.contextPath}/movieManagement.jsp">Back</a>
<%
            return;
        }
    } catch (Exception e) {
        out.println("<p style='color:red;'>" + e.getMessage() + "</p>");
        return;
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Movie</title>
    <style>
        body {
            background-color: #0c0422;
            color: white;
            font-family: Arial, sans-serif;
            padding: 2rem;
        }
        form {
            background-color: #1f1f2f;
            padding: 2rem;
            border-radius: 10px;
            width: 600px;
            margin: auto;
        }
        label {
            display: block;
            margin-top: 1rem;
        }
        input, textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border-radius: 5px;
            border: none;
        }
        button {
            margin-top: 1.5rem;
            background-color: #444;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #666;
        }
    </style>
</head>
<body>
    <h2 style="text-align:center;">Edit Movie</h2>
    <form action="MovieServlet" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="movie_id" value="<%= movieId %>">

        <label>Title:</label>
        <input type="text" name="title" value="<%= title %>" required>

        <label>Genre:</label>
        <input type="text" name="genre" value="<%= genre %>" required>

        <label>Release Date:</label>
        <input type="date" name="releaseDate" value="<%= releaseDate %>" required>

        <label>Description:</label>
        <textarea name="description" rows="4" required><%= description %></textarea>

        <label>Director:</label>
        <input type="text" name="director" value="<%= director %>" required>

        <label>Cast:</label>
        <input type="text" name="cast" value="<%= cast %>" required>

        <label>Image Filename:</label>
        <input type="text" name="imageFile" value="<%= imageFile %>" required>

        <button type="submit">Update Movie</button>
    </form>
</body>
</html>
