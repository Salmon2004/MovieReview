

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import model.MovieDAO;
import model.Movie;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 * @author U S E R
 */
public class MovieServlet extends HttpServlet {

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
            out.println("<title>Servlet MovieServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MovieServlet at " + request.getContextPath() + "</h1>");
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
        MovieDAO dao = new MovieDAO();

        try {
            if ("update".equals(action)) {
                 int movieId = Integer.parseInt(request.getParameter("movie_id")); // ✅

                String title = request.getParameter("title");
                String genre = request.getParameter("genre");
                String releaseDateStr = request.getParameter("releaseDate");
                java.sql.Date releaseDate = java.sql.Date.valueOf(releaseDateStr);
                String description = request.getParameter("description");
                String director = request.getParameter("director");
                String cast = request.getParameter("cast");
                String imageFile = request.getParameter("imageFile");

                Movie movie = new Movie();
                movie.setMovieId(movieId);
                movie.setTitle(title);
                movie.setGenre(genre);
                movie.setReleaseDate(releaseDate);
                movie.setDescription(description);
                movie.setDirector(director);
                movie.setCast(cast);
                movie.setImageFile(imageFile);

                dao.updateMovie(movie);

                response.sendRedirect(request.getContextPath()+"movieManagement.jsp");

            } else if ("delete".equals(action)) {
                int movieId = Integer.parseInt(request.getParameter("movieID"));
                dao.deleteMovie(movieId);
                response.sendRedirect(request.getContextPath()+"movieManagement.jsp");

            }else if ("add".equals(action)) {
    String title = request.getParameter("title");
    String genre = request.getParameter("genre");
    String releaseDateStr = request.getParameter("releaseDate");
    java.sql.Date releaseDate = java.sql.Date.valueOf(releaseDateStr);
    String director = request.getParameter("director");
    String cast = request.getParameter("cast");
    
    String imageFile = request.getParameter("imageFile");
    String description = request.getParameter("description");

    Movie movie = new Movie();
    movie.setTitle(title);
    movie.setGenre(genre);
    movie.setReleaseDate(releaseDate);
    movie.setDirector(director);
    movie.setCast(cast);

    movie.setImageFile(imageFile);
    movie.setDescription(description);

    dao.insertMovie(movie);
    response.sendRedirect(request.getContextPath()+"movieManagement.jsp");
}
 else {
                response.getWriter().println("Unknown action: " + action);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error processing movie: " + e.getMessage());
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
