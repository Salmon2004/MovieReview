/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.Review;
import model.ReviewDAO;

/**
 *
 * @author U S E R
 */
public class ReviewServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ReviewServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReviewServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        // Instantiate DAO to interact with database
        ReviewDAO dao = new ReviewDAO();

        try {
            switch (action) {
                case "add":
                    // Handle addition of a new review
                    Review newReview = new Review();
                    newReview.setUserId(Integer.parseInt(request.getParameter("user_id")));
                    newReview.setMovieId(Integer.parseInt(request.getParameter("movie_id")));
                    newReview.setReviewText(request.getParameter("review_text"));
                    newReview.setRating(Float.parseFloat(request.getParameter("rating")));

                    // Save to database
                    dao.insertReview(newReview);

                    // Redirect back to list of reviews for this movie
                    response.sendRedirect("viewReviews.jsp?movie_id=" + newReview.getMovieId());
                    break;

                case "update":
                    // Handle updating an existing review
                    Review updatedReview = new Review();
                    updatedReview.setReviewId(Integer.parseInt(request.getParameter("review_id")));
                    updatedReview.setReviewText(request.getParameter("review_text"));
                    updatedReview.setRating(Float.parseFloat(request.getParameter("rating")));

                    // Apply update in the database
                    dao.updateReview(updatedReview);

                    // Redirect to view updated review details
                    response.sendRedirect(request.getContextPath()+"viewReviewDetails.jsp?review_id=" + updatedReview.getReviewId());
                    break;

                case "delete":
                    // Handle deletion of a review
                    int reviewId = Integer.parseInt(request.getParameter("review_id"));
                    String movieIdStr = request.getParameter("movie_id");

                    // Delete review from database
                    dao.deleteReview(reviewId);

                    // Redirect back to the movie's review list if movie ID is known
                    if (movieIdStr != null) {
                        response.sendRedirect(request.getContextPath()+"viewReviews.jsp?movie_id=" + movieIdStr);
                    } else {
                        response.sendRedirect(request.getContextPath()+"viewReviews.jsp");
                    }
                    break;

                default:
                    // Catch unexpected or invalid actions
                    response.getWriter().println("Unknown action: " + action);
            }

        } catch (Exception e) {
            // Log error and show feedback
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
