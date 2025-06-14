<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ReviewDAO, model.CommentDAO, model.Review, model.Comment, model.ReactionDAO" %>
<%@ page import="java.util.List" %>

<%
    String reviewIdStr = request.getParameter("review_id");
    if (reviewIdStr == null || reviewIdStr.isEmpty()) {
%>
    <h3 style="color:red;">Error: No review selected.</h3>
    <a href="${pageContext.request.contextPath}/homepage.jsp">Back to Homepage</a>
<%
        return;
    }

    int reviewId = Integer.parseInt(reviewIdStr);
    Integer sessionUserId = (session != null) ? (Integer) session.getAttribute("userID") : null;

    ReviewDAO reviewDAO = new ReviewDAO();
    CommentDAO commentDAO = new CommentDAO();
    ReactionDAO reactionDAO = new ReactionDAO();
    Review review = reviewDAO.getReviewById(reviewId);
    List<Comment> comments = commentDAO.getCommentsByReviewId(reviewId);
%>

<!DOCTYPE html>
<html>
<head>
     <link rel="stylesheet" href="${pageContext.request.contextPath}/https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <meta charset="UTF-8">
    <title>Review Details</title>
    <style>
    body {
        background-color: #0c0422;
        color: white;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        margin: 0;
        padding: 0;
    }

    .navbar {
        background-color: #16132a;
        padding: 1rem 2rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
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

    .dropdown:hover .dropdown-content {
        display: block;
    }

    .container {
        padding: 2rem;
    }

    .review-box {
        background-color: #1f1f2f;
        padding: 2rem;
        border-radius: 12px;
        margin-bottom: 2rem;
        box-shadow: 0 0 10px rgba(0,0,0,0.4);
    }

    .review-box h2 {
        margin-bottom: 1rem;
        color: #f7c873;
    }

    .comments-section {
        margin-top: 2rem;
    }

    .comment {
        background-color: #2a2a3d;
        padding: 1rem;
        margin-bottom: 1.2rem;
        border-radius: 10px;
        box-shadow: 0 0 6px rgba(0,0,0,0.3);
        transition: transform 0.2s ease;
    }

    .comment:hover {
        transform: scale(1.01);
    }

    .comment small {
        color: #bbb;
    }

    .reaction {
        margin-top: 10px;
    }

    .reaction form {
        display: inline-block;
        margin-right: 10px;
    }

    .reaction button {
        background-color: #33374d;
        color: #ffc107;
        padding: 6px 12px;
        border: none;
        border-radius: 6px;
        font-weight: bold;
        cursor: pointer;
    }

    .reaction button:hover {
        background-color: #50536b;
    }

    .comment-actions {
        margin-top: 10px;
    }

    .comment-actions a,
    .comment-actions button {
        background-color: #444;
        color: white;
        border: none;
        padding: 6px 12px;
        margin-right: 8px;
        border-radius: 6px;
        text-decoration: none;
        font-weight: bold;
    }

    .comment-actions a:hover,
    .comment-actions button:hover {
        background-color: #666;
    }

    textarea {
        width: 100%;
        padding: 12px;
        border-radius: 8px;
        border: none;
        background-color: #1f1f2f;
        color: white;
        resize: vertical;
        font-size: 1rem;
    }

    button[type="submit"] {
        background-color: #5a3eff;
        color: white;
        font-weight: bold;
        padding: 10px 18px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        margin-top: 10px;
    }

    button[type="submit"]:hover {
        background-color: #7c5eff;
    }

    h3, h4 {
        color: #ffcc70;
    }
    
</style>

<body>
<div class="navbar">
    <div>
        <a href="${pageContext.request.contextPath}/homepage.jsp">🏠 Home</a>
    </div>
    <div class="dropdown">
        <button class="dropbtn"><i class="fas fa-user-circle"></i> Account ▾</button>
        <div class="dropdown-content">
            <a href="${pageContext.request.contextPath}/profile.jsp">👤 Profile</a>
            <% if ("admin".equals(session.getAttribute("role"))) { %>
                <a href="${pageContext.request.contextPath}/movieManagement.jsp">🎬 Movie Manage</a>
            <% } %>
            <a href="${pageContext.request.contextPath}/logout.jsp">🚪 Logout</a>
        </div>
    </div>
</div>

<div class="container">
    <div class="review-box">
        <h2>Review for: <%= reviewDAO.getMovieTitleById(review.getMovieId()) %></h2>
        <p><strong>Rating:</strong> <%= review.getRating() %></p>
        <p><strong>Review:</strong> <%= review.getReviewText() %></p>
        <p><strong>Posted on:</strong> <%= review.getDatePosted() %></p>
    </div>

    <div class="comments-section">
        <h3>Comments</h3>

        <% if (comments.isEmpty()) { %>
            <p>No comments yet. Be the first to comment!</p>
        <% } else {
            for (Comment comment : comments) {
                int likes = reactionDAO.getLikeCount(comment.getCommentID());
                int dislikes = reactionDAO.getDislikeCount(comment.getCommentID());
        %>
            <div class="comment">
                <p><%= comment.getCommentText() %></p>
                <small>By user ID: <%= comment.getUserID() %> on <%= comment.getDateCommented() %></small>

                <div class="reaction">
                    <form action="ReactionServlet" method="post">
                        <input type="hidden" name="action" value="like">
                        <input type="hidden" name="comment_id" value="<%= comment.getCommentID() %>">
                        <input type="hidden" name="review_id" value="<%= reviewId %>">
                        <button type="submit">👍 Like (<%= likes %>)</button>
                    </form>
                    <form action="ReactionServlet" method="post">
                        <input type="hidden" name="action" value="dislike">
                        <input type="hidden" name="comment_id" value="<%= comment.getCommentID() %>">
                        <input type="hidden" name="review_id" value="<%= reviewId %>">
                        <button type="submit">👎 Dislike (<%= dislikes %>)</button>
                    </form>
                </div>

                <% if (sessionUserId != null && sessionUserId.equals(comment.getUserID())) { %>
                    <div class="comment-actions">
                        <a href="${pageContext.request.contextPath}/editComment.jsp?comment_id=<%= comment.getCommentID() %>">✏️ Edit</a>
                        <form action="CommentServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this comment?');">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="comment_id" value="<%= comment.getCommentID() %>">
                            <input type="hidden" name="review_id" value="<%= reviewId %>">
                            <button type="submit">🗑️ Delete</button>
                        </form>
                    </div>
                <% } %>
            </div>
        <%  } } %>

        <h4>Add a Comment</h4>
        <form action="CommentServlet" method="post">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="review_id" value="<%= reviewId %>">
            <textarea name="commentText" rows="3" placeholder="Write your comment here... 😊" required></textarea><br>
            <button type="submit">➕ Post Comment</button>
        </form>
    </div>
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
        }, 300); // 300ms delay before it disappears
    });
</script>

</body>

</html>
