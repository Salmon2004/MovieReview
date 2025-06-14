<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ReviewDAO, model.Review, model.Movie" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.Map" %>
<%
    String movieIdStr = request.getParameter("movie_id");
    if (movieIdStr == null || movieIdStr.isEmpty()) {
%>
    <h3 style="color:red;">Error: No movie selected.</h3>
    <a href="homepage.jsp">Back to Homepage</a>
<%
        return;
    }

    int movieId = 0;
    try {
        movieId = Integer.parseInt(movieIdStr);
    } catch (NumberFormatException e) {
        out.println("<h3 style='color:red;'>Invalid movie ID format.</h3>");
        return;
    }

    Integer sessionUserId = (session != null) ? (Integer) session.getAttribute("userID") : null;
    String userRole = (session != null) ? (String) session.getAttribute("role") : null;

    ReviewDAO dao = new ReviewDAO();
    List<Review> reviews = dao.getReviewsByMovieId(movieId);
    String movieTitle = dao.getMovieTitleById(movieId);
    String imageFile = dao.getMoviePosterFileById(movieId);
    Movie movie = dao.getMovieById(movieId);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= movieTitle %> - Reviews</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body { background-color: #0c0422; color: white; font-family: Arial, sans-serif; margin: 0; padding: 0; }
        .navbar { background-color: #16132a; padding: 1rem 2rem; display: flex; justify-content: space-between; align-items: center; }
        .navbar a, .dropbtn { color: white; text-decoration: none; font-weight: bold; font-size: 1rem; padding: 8px 16px; }
        .dropbtn { border: none; background: none; cursor: pointer; }
        .dropdown { position: relative; display: inline-block; }
        .dropdown-content { display: none; position: absolute; right: 0; background-color: #2d2c44; min-width: 160px; border-radius: 6px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.6); z-index: 2000; margin-top: 8px; }
        .dropdown-content a { color: #ffa94d; padding: 12px 16px; text-decoration: none; display: block; font-weight: bold; }
        .dropdown-content a:hover { background-color: #3c3a58; color: white; }
        .dropdown:hover .dropdown-content { display: block; }

        .container { padding: 2rem; }
        .movie-info { text-align: center; margin-bottom: 2rem; }
        .movie-info img { max-width: 200px; border-radius: 10px; }
        .movie-info h2 { margin-top: 1rem; font-size: 1.8rem; }
        .movie-meta { margin-top: 1rem; font-size: 1rem; color: #bbb; line-height: 1.6; }
        .review-card { background-color: #1f1f2f; padding: 1.5rem; border-radius: 10px; margin-bottom: 1.5rem; box-shadow: 0 2px 4px rgba(255, 255, 255, 0.1); }
        .review-card .rating-stars { color: gold; font-size: 1.1rem; }
        .review-card .buttons { margin-top: 1rem; }
        .review-card button, .review-card a { color: white; background-color: #444; padding: 6px 12px; text-decoration: none; border: none; border-radius: 5px; margin-right: 0.5rem; cursor: pointer; }
        .review-card button:hover, .review-card a:hover { background-color: #666; }
    </style>
</head>
<body>
<div class="navbar">
    <div>
        <a href="${pageContext.request.contextPath}/homepage.jsp">🏠 Home</a>
    </div>
    <div class="dropdown">
        <button class="dropbtn"><i class="fas fa-user-circle"></i> Account ▼</button>
        <div class="dropdown-content">
            <a href="${pageContext.request.contextPath}/profile.jsp">👤 Profile</a>
            <% if ("admin".equals(userRole)) { %>
                <a href="${pageContext.request.contextPath}/movieManagement.jsp">🎬 Movie Manage</a>
            <% } %>
            <a href="${pageContext.request.contextPath}/logout.jsp">🚪 Logout</a>
        </div>
    </div>
</div>

<div class="container">
   <div class="movie-info" style="display: flex; align-items: center; justify-content: center; gap: 2rem; flex-wrap: wrap;">
    <img src="${pageContext.request.contextPath}/images/<%= imageFile %>" alt="Movie Poster" style="max-width: 220px; border-radius: 10px; box-shadow: 0 0 10px rgba(255,255,255,0.2);"/>

    <div style="max-width: 500px; line-height: 1.8;">
        <h2 style="margin-bottom: 0.5rem;"><%= movieTitle %></h2>
        <p>🎭 <strong>Genre:</strong> <%= dao.getMovieById(movieId).getGenre() %></p>
        <p>🎬 <strong>Director:</strong> <%= dao.getMovieById(movieId).getDirector() %></p>
        <p>👥 <strong>Cast:</strong> <%= dao.getMovieById(movieId).getCast() %></p>
        <p>📅 <strong>Release Date:</strong> <%= dao.getMovieById(movieId).getReleaseDate() %></p>
        <p>📝 <strong>Description:</strong> <%= dao.getMovieById(movieId).getDescription() %></p>
        <a href="${pageContext.request.contextPath}/addReview.jsp?movie_id=<%= movieId %>" style="display: inline-block; margin-top: 1rem; color: #ffd166;">➕ Add Review</a>
    </div>
</div>


    <% if (reviews.isEmpty()) { %>
        <p style="text-align: center; margin-top: 2rem; color: #ffa94d;">🚫 No reviews available for this movie yet.</p>
    <% } else {
        for (Review review : reviews) { %>
            <div class="review-card">
                <p class="rating-stars">
                    <% for (int i = 0; i < (int) review.getRating(); i++) { %>&#9733;<% } %>
                </p>
                <p><strong>⭐ Rating:</strong> <%= review.getRating() %></p>
                <p><strong>💬 Review:</strong> <%= review.getReviewText() %></p>
                <p><strong>📅 Date:</strong> <%= review.getDatePosted() %></p>
                <div class="buttons">
                    <a href="viewReviewDetails.jsp?review_id=<%= review.getReviewId() %>">View</a>
                    <% if (sessionUserId != null && sessionUserId.equals(review.getUserId())) { %>
                        <a href="${pageContext.request.contextPath}/editReview.jsp?review_id=<%= review.getReviewId() %>">Edit</a>
                        <form action="ReviewServlet" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this review?');">
                            <input type="hidden" name="action" value="delete" />
                            <input type="hidden" name="review_id" value="<%= review.getReviewId() %>" />
                            <input type="hidden" name="movie_id" value="<%= movieId %>" />
                            <button type="submit">Delete</button>
                        </form>
                    <% } %>
                </div>
            </div>
    <%  } } %>
</div>

<script>
    const dropdown = document.querySelector(".dropdown");
    let timer;
    dropdown.addEventListener("mouseenter", () => {
        clearTimeout(timer);
        dropdown.querySelector(".dropdown-content").style.display = "block";
    });
    dropdown.addEventListener("mouseleave", () => {
        timer = setTimeout(() => {
            dropdown.querySelector(".dropdown-content").style.display = "none";
        }, 300);
    });
</script>

</body>
</html>
