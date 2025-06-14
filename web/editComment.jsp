    <%-- 
        Document   : editComment
        Created on : 12 Jun 2025, 5:59:14 pm
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
        <meta charset="UTF-8">
        <title>Edit Comment</title>
        <style>
            body {
                background-color: #0c0422;
                color: white;
                font-family: Arial, sans-serif;
                padding: 2rem;
            }
            .form-box {
                background-color: #1f1f2f;
                padding: 2rem;
                border-radius: 10px;
                width: 500px;
                margin: auto;
            }
            textarea {
                width: 100%;
                height: 120px;
                padding: 10px;
                font-size: 1rem;
                border-radius: 8px;
                border: none;
            }
            button {
                margin-top: 1rem;
                padding: 10px 20px;
                background-color: #ffa94d;
                border: none;
                border-radius: 6px;
                font-weight: bold;
                cursor: pointer;
            }
            button:hover {
                background-color: #ff8c1a;
            }
        </style>
    </head>
    <body>

    <div class="form-box">
        <h2>Edit Your Comment</h2>
       <form action="CommentServlet" method="post">
        <input type="hidden" name="action" value="edit">
        <input type="hidden" name="comment_id" value="<%= comment.getCommentID() %>">

        <label for="commentText">Edit your comment:</label><br>
        <textarea name="commentText" rows="4" required><%= comment.getCommentText() %></textarea><br>

        <button type="submit">Update Comment</button>
    </form>

    </div>

    </body>
    </html>
