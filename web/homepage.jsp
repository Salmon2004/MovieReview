<%@ page import="model.ReviewDAO" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String query = request.getParameter("query");
    String genreFilter = request.getParameter("genre");
    String ratingFilter = request.getParameter("rating");

    ReviewDAO dao = new ReviewDAO();
    List<Map<String, String>> moviePosters;
if ((query == null || query.isEmpty()) && (genreFilter == null || genreFilter.isEmpty()) && (ratingFilter == null || ratingFilter.isEmpty())) {
    moviePosters = dao.getAllMoviePosters(); // ✅ Default: show all
} else {
    moviePosters = dao.searchMoviePostersWithFilter(query, genreFilter, ratingFilter); // 🔍 Apply filters if any
}

    List<Map<String, String>> topReviews = dao.getTopReviews();

    String userRole = (session != null) ? (String) session.getAttribute("role") : null;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            margin: 0;
            background-color: #0c0422;
            font-family: Arial, sans-serif;
            color: white;
        }
        .navbar {
            background-color: #16132a;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.6);
        }
        .navbar a, .dropbtn {
            color: white;
            text-decoration: none;
            font-weight: bold;
            font-size: 1rem;
            padding: 8px 16px;
            border: none;
            background: none;
            cursor: pointer;
        }
        .dropbtn i {
            margin-right: 6px;
        }
        .dropdown {
            position: relative;
            display: inline-block;
        }
        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background-color: #2d2c44;
            min-width: 160px;
            border-radius: 6px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.6);
            z-index: 2000;
            margin-top: 8px;
        }
        .dropdown-content a {
            color: #ffa94d;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            font-weight: bold;
        }
        .dropdown-content a:hover {
            background-color: #3c3a58;
            color: white;
        }
        .slider {
            text-align: center;
            margin: 1rem auto;
            width: 80%;
        }
        .slider img {
            width: 100%;
            max-height: 250px;
            object-fit: contain;
            border-radius: 10px;
        }
        .filter-form {
            width: 80%;
            margin: 1rem auto;
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }
        .search-bar, .filter-form select {
            flex: 1;
            padding: 0.7rem;
            border-radius: 10px;
            border: none;
            font-size: 1rem;
            background-color: #1f1f2f;
            color: white;
        }
        .filter-form button {
            background-color: #ffa94d;
            color: #000;
            border: none;
            padding: 0.7rem 1.2rem;
            border-radius: 10px;
            cursor: pointer;
            font-weight: bold;
        }
        .movie-row {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 1.5rem;
            padding: 1rem;
        }
        .movie-card {
            background-color: #1f1f2f;
            padding: 0.6rem;
            width: 160px;
            text-align: center;
            border-radius: 10px;
            transition: transform 0.3s ease;
            text-decoration: none;
            color: white;
        }
        .movie-card:hover {
            transform: scale(1.05);
        }
        .movie-card img {
            width: 100%;
            height: 230px;
            object-fit: cover;
            border-radius: 6px;
        }
        .top-review {
            background-color: #1a1a2b;
            margin: 2rem auto;
            width: 90%;
            border-radius: 10px;
            padding: 1rem;
        }
        .top-review h3 {
            text-align: center;
            margin-bottom: 1rem;
        }
        .review-entry {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.6rem 0;
            border-bottom: 1px solid #333;
        }
        .review-entry:last-child {
            border-bottom: none;
        }
        .review-left {
            flex: 1;
        }
        .review-left strong {
            display: block;
        }
        .review-left small {
            color: #bbb;
        }
        .stars {
            color: gold;
            font-size: 1.1rem;
        }
    </style>
</head>
<body>

<div class="navbar">
    <div>
        <a href="${pageContext.request.contextPath}/homepage.jsp" class="nav-home">🏠 Home</a>
    </div>
    <div class="dropdown">
        <button class="dropbtn"><i class="fas fa-user-circle"></i> Account ▾</button>
        <div class="dropdown-content">
            <a href="${pageContext.request.contextPath}/profile.jsp">👤 Profile</a>
            <% if ("admin".equals(userRole)) { %>
                <a href="${pageContext.request.contextPath}/movieManagement.jsp">🎬 Movie Manage</a>
            <% } %>
            <a href="${pageContext.request.contextPath}/logout.jsp">🚪 Logout</a>
        </div>
    </div>
</div>

<div class="slider">
    <img src="${pageContext.request.contextPath}/images/cinelux.png" alt="Cineluxe Banner"/>
</div>

<form method="get" action="homepage.jsp" class="filter-form">
    <input class="search-bar" type="text" name="query" placeholder="Search movies..." value="<%= (query != null) ? query : "" %>"/>
    <select name="genre">
        <option value="">All Genres</option>
        <option value="Action" <%= "Action".equals(genreFilter) ? "selected" : "" %>>Action</option>
        <option value="Drama" <%= "Drama".equals(genreFilter) ? "selected" : "" %>>Drama</option>
        <option value="Science Fiction" <%= "Science Fiction".equals(genreFilter) ? "selected" : "" %>>Science Fiction</option>
        <option value="Thriller" <%= "Thriller".equals(genreFilter) ? "selected" : "" %>>Thriller</option>
    </select>
    <select name="rating">
        <option value="">All Ratings</option>
        <option value="9" <%= "9".equals(ratingFilter) ? "selected" : "" %>>9+</option>
        <option value="8.5" <%= "8.5".equals(ratingFilter) ? "selected" : "" %>>8.5+</option>
        <option value="8" <%= "8".equals(ratingFilter) ? "selected" : "" %>>8+</option>
    </select>
    <button type="submit">Filter</button>
</form>

<div class="movie-row">
<% if (moviePosters.isEmpty()) { %>
    <p style="color: #ffa94d; text-align:center; font-size: 1.2rem; margin-top: 2rem;">
        🚫 No movies found matching your search/filter criteria.
    </p>
<% } else {
    for (Map<String, String> movie : moviePosters) {
        String movieId = movie.get("movieID");
        String title = movie.get("title");
        String image = movie.get("imageFile");

        if (movieId != null && !movieId.trim().isEmpty() && !"null".equalsIgnoreCase(movieId)) {
%>
        <a href="viewReviews.jsp?movie_id=<%= movieId %>" class="movie-card">
            <img src="images/<%= image %>" alt="Movie Poster"/>
            <strong><%= title %></strong>
        </a>
<%      }
    }
} %>
</div>


<div class="top-review">
    <h3>Top Review</h3>
    <% for (Map<String, String> review : topReviews) { %>
        <div class="review-entry">
            <div class="review-left">
                <strong>
                    <a href="${pageContext.request.contextPath}/viewReviewDetails.jsp?review_id=<%= review.get("reviewID") %>" style="color:white; text-decoration:none;">
                        <%= review.get("movieTitle") %>
                    </a>
                </strong>
                <small>by <%= review.get("username") %></small>
            </div>
            <div class="stars">
                <%
                    float rating = Float.parseFloat(review.get("rating"));
                    int starCount = (int) rating;
                    for (int i = 0; i < starCount; i++) { %>
                        &#9733;
                <% } %>
            </div>
        </div>
    <% } %>
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
