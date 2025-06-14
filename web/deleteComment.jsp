<%-- 
    Document   : deleteComment
    Created on : 12 Jun 2025, 6:03:07 pm
    Author     : U S E R
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.CommentDAO, model.Comment" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    int commentId = Integer.parseInt(request.getParameter("comment_id"));
   
    Integer sessionUserId = (Integer) session.getAttribute("userID");

    CommentDAO dao = new CommentDAO();
    Comment comment = dao.getCommentById(commentId);

    if (comment == null || sessionUserId == null || !sessionUserId.equals(comment.getUserID())) {
%>
    <h3 style="color:red;">Unauthorized access or comment not found.</h3>
    <a href="${pageContext.request.contextPath}/homepage.jsp">Back to Homepage</a>
<%
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Delete Comment</title>
    <style>
        body {
            background-color: #0c0422;
            color: white;
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 3rem;
        }
        .container {
            background-color: #1f1f2f;
            padding: 2rem;
            border-radius: 10px;
            display: inline-block;
        }
        button {
            background-color: #d9534f;
            color: white;
            border: none;
            padding: 10px 20px;
            margin: 0 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #c9302c;
        }
        a {
            color: #ccc;
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Are you sure you want to delete this comment?</h2>
    <p><em>"<%= comment.getCommentText() %>"</em></p>

    <form action="CommentServlet" method="post">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="comment_id" value="<%= comment.getCommentID() %>">
        <input type="hidden" name="review_id" value="<%= comment.getReviewID() %>">
        <button type="submit">Yes, Delete</button>
        <a href="${pageContext.request.contextPath}/viewReviewDetails.jsp?review_id=<%= comment.getReviewID() %>">
            <button type="button">Cancel</button>
        </a>
    </form>
</div>
</body>
</html>
