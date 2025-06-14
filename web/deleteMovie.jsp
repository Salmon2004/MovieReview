<%-- 
    Document   : deleteMovie
    Created on : 12 Jun 2025, 4:02:22 pm
    Author     : U S E R
--%>

<%@ page import="model.MovieDAO" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String idStr = request.getParameter("movie_id");

    if (idStr == null || idStr.isEmpty()) {
%>
        <p style="color:red;">Missing movie ID.</p>
        <a href="${pageContext.request.contextPath}/movieManagement.jsp">Back to Management</a>
<%
    } else {
        try {
            int movieId = Integer.parseInt(idStr);
            MovieDAO dao = new MovieDAO();
            dao.deleteMovie(movieId);
            response.sendRedirect("${pageContext.request.contextPath}/movieManagement.jsp");
        } catch (NumberFormatException e) {
%>
            <p style="color:red;">Invalid movie ID format.</p>
            <a href="${pageContext.request.contextPath}/movieManagement.jsp">Back to Management</a>
<%
        } catch (SQLException e) {
            e.printStackTrace();
%>
            <p style="color:red;">Database error: <%= e.getMessage() %></p>
            <a href="${pageContext.request.contextPath}/movieManagement.jsp">Back to Management</a>
<%
        }
    }
%>

