<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.ReviewDAO, model.Review" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    Integer sessionUserId = (session != null) ? (Integer) session.getAttribute("userID") : null;

    int reviewId = Integer.parseInt(request.getParameter("review_id"));
    ReviewDAO dao = new ReviewDAO();
    Review review = dao.getReviewById(reviewId);

    if (sessionUserId == null || sessionUserId != review.getUserId()) {
%>
    <h2 style="color:red; text-align:center; margin-top:2rem">Unauthorized access.</h2>
    <p style="text-align:center"><a href="${pageContext.request.contextPath}/homepage.jsp" style="color: #ccc; text-decoration: underline">Return to homepage</a></p>
<%
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Review</title>
    <style>
        body {
            background-color: #0c0422;
            color: white;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .review-box {
            background-color: #1f1f2f;
            padding: 2rem;
            border-radius: 12px;
            width: 400px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.4);
        }

        h2 {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            margin: 0.5rem 0 0.3rem;
            font-weight: bold;
        }

        input[type="number"],
        textarea {
            width: 100%;
            padding: 0.6rem;
            border-radius: 6px;
            border: none;
            margin-bottom: 1rem;
            font-size: 1rem;
        }

        button {
            width: 100%;
            padding: 0.7rem;
            background-color: #6a0dad;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
        }

        button:hover {
            background-color: #4a0372;
        }
    </style>
</head>
<body>
<div class="review-box">
    <h2>Edit Your Review</h2>
    <form action="ReviewServlet" method="post">
        <input type="hidden" name="action" value="update"/>
        <input type="hidden" name="review_id" value="<%= review.getReviewId() %>"/>

        <label for="rating">Rating (0.0 - 10.0):</label>
        <input type="number" id="rating" name="rating" step="0.1" min="0.0" max="10.0" value="<%= review.getRating() %>" required>

        <label for="review_text">Review:</label>
        <textarea id="review_text" name="review_text" rows="5" required><%= review.getReviewText() %></textarea>

        <button type="submit">Update Review</button>
    </form>
</div>
</body>
</html>
