/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import model.Comment;
import model.CommentDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
/**
 *
 * @author U S E R
 */
public class CommentServlet extends HttpServlet {

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
            out.println("<title>Servlet CommentServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CommentServlet at " + request.getContextPath() + "</h1>");
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
        doPost(request, response);
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
        CommentDAO dao = new CommentDAO();

        try {
            if ("add".equals(action)) {
                String commentText = request.getParameter("commentText");
                int reviewId = Integer.parseInt(request.getParameter("review_id"));
                HttpSession session = request.getSession();
                Integer userId = (Integer) session.getAttribute("userID");

                Comment comment = new Comment();
                comment.setCommentText(commentText);
                comment.setReviewID(reviewId);
                comment.setUserID(userId);
                comment.setDateCommented(new Date());

                dao.addComment(comment);
                response.sendRedirect(request.getContextPath()+"viewReviewDetails.jsp?review_id=" + reviewId);

            } else if ("edit".equals(action)) {
                int commentId = Integer.parseInt(request.getParameter("comment_id"));
                String updatedText = request.getParameter("commentText");

                Comment comment = dao.getCommentById(commentId);
                comment.setCommentText(updatedText);
                dao.updateComment(comment);

                response.sendRedirect(request.getContextPath()+"viewReviewDetails.jsp?review_id=" + comment.getReviewID());

            } else if ("delete".equals(action)) {
                int commentId = Integer.parseInt(request.getParameter("comment_id"));
                int reviewId = Integer.parseInt(request.getParameter("review_id"));

                dao.deleteComment(commentId);
                response.sendRedirect(request.getContextPath()+"viewReviewDetails.jsp?review_id=" + reviewId);

            } else {
                response.getWriter().println("Invalid action: " + action);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error processing comment: " + e.getMessage());
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
