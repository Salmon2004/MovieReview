<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.ReviewDAO" %>
<%@page import="java.sql.*, java.util.*" %>

<%
    String movieIdParam = request.getParameter("movie_id");
    if (movieIdParam == null || movieIdParam.isEmpty()) {
%>
    <h3 style="color:red;">Error: No movie selected.</h3>
    <a href="homepage.jsp">Back to Homepage</a>
<%
        return;
    }

    int movieId = Integer.parseInt(movieIdParam);

    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinelux", "root", "admin");
    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Movie WHERE movieID = ?");
    stmt.setInt(1, movieId);
    ResultSet rs = stmt.executeQuery();

    String title = "", genre = "", imageFile = "", releaseDate = "", director = "", description = "";
    if (rs.next()) {
        title = rs.getString("title");
        genre = rs.getString("genre");
        imageFile = rs.getString("imageFile");
        releaseDate = rs.getString("releaseDate");
        director = rs.getString("director");
        description = rs.getString("description");
    }
    conn.close();

    Integer userId = (Integer) session.getAttribute("userID");
    if (userId == null) {
        response.sendRedirect("${pageContext.request.contextPath}/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Review - <%= title %></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #0c0422;
            color: white;
            margin: 0;
            padding: 2rem;
        }

        .container {
            display: flex;
            background-color: #1a1a2b;
            border-radius: 10px;
            overflow: hidden;
        }

        .movie-section {
            width: 40%;
        }

        .movie-section img {
            width: 100%;
            height: auto;
            object-fit: cover;
        }

        .details {
            padding: 1rem;
        }

        .form-section {
            width: 60%;
            padding: 2rem;
        }

        h2 {
            margin-top: 0;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin-top: 1rem;
            margin-bottom: 0.2rem;
        }

        input[type="number"],
        textarea {
            padding: 0.6rem;
            border-radius: 6px;
            border: none;
            font-size: 1rem;
        }

        textarea {
            resize: vertical;
        }

        button {
            margin-top: 1.5rem;
            padding: 0.7rem;
            background-color: #6a1b9a;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 1rem;
            cursor: pointer;
        }

        button:hover {
            background-color: #8e24aa;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="movie-section">
        <img src="images/<%= imageFile %>" alt="<%= title %> Poster"/>
        <div class="details">
            <h2><%= title %></h2>
            <p><strong>Genre:</strong> <%= genre %></p>
            <p><strong>Release Date:</strong> <%= releaseDate %></p>
            <p><strong>Director:</strong> <%= director %></p>
            <p><strong>Description:</strong> <%= description %></p>
        </div>
    </div>

    <div class="form-section">
        <h2>Add Your Review</h2>
        <form action="ReviewServlet" method="post">
            <input type="hidden" name="action" value="add" />
            <input type="hidden" name="movie_id" value="<%= movieId %>" />
            <input type="hidden" name="user_id" value="<%= userId %>" />

            <label for="rating">Rating (0.0 - 10.0):</label>
            <input type="number" step="0.1" min="0.0" max="10.0" name="rating" required>

            <label for="review_text">Review:</label>
            <textarea name="review_text" rows="6" required></textarea>

            <button type="submit">Submit Review</button>
        </form>
    </div>
</div>

</body>
</html>
