/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
/**
 *
 * @author U S E R
 */

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {

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
            out.println("<title>Servlet RegistrationServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegistrationServlet at " + request.getContextPath() + "</h1>");
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
     String username = request.getParameter("username");
String email = request.getParameter("email");
String password = request.getParameter("password");

if(username == null || email == null || password == null ||
   username.isEmpty() || email.isEmpty() || password.isEmpty()) {
    request.setAttribute("errorMessage", "All fields are required.");
    request.getRequestDispatcher(request.getContextPath()+"signup.jsp").forward(request, response);
    return;
}

try (Connection conn = DBUtil.getConnection()) {
    String checkQuery = "SELECT userID FROM User_ WHERE email = ?";
    try (PreparedStatement ps = conn.prepareStatement(checkQuery)) {
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if(rs.next()) {
            request.setAttribute("errorMessage", "Email already taken. Choose another.");
            request.getRequestDispatcher(request.getContextPath()+"signup.jsp").forward(request, response);
            return;
        }
    }

    String insertQuery = "INSERT INTO User_ (username, email, password, dateJoined, role) VALUES (?, ?, ?, CURDATE(), 'member')";
    try (PreparedStatement ps = conn.prepareStatement(insertQuery)) {
        ps.setString(1, username);
        ps.setString(2, email);
        ps.setString(3, password);
        int inserted = ps.executeUpdate();

        if(inserted > 0) {
            request.setAttribute("successMessage", "Registration successful! You can now log in.");
        } else {
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
        }
        request.getRequestDispatcher(request.getContextPath()+"signup.jsp").forward(request, response);
    }

} catch (SQLException e) {
    e.printStackTrace();
    request.setAttribute("errorMessage", "Database error: " + e.getMessage());
    request.getRequestDispatcher(request.getContextPath()+"signup.jsp").forward(request, response);
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
