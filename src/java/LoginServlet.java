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

public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("errorMessage", "Email and password are required.");
            request.getRequestDispatcher(request.getContextPath()+"login.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DBUtil.getConnection()) {
            String query = "SELECT userID, password, role FROM User_ WHERE LOWER(email) = LOWER(?)";
            try (PreparedStatement ps = conn.prepareStatement(query)) {
                ps.setString(1, email);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    String storedPwd = rs.getString("password");
                    int userId = rs.getInt("userID");
                    String role = rs.getString("role"); // ✅ Ensure this column exists

                    if (password.equals(storedPwd)) {
                        HttpSession session = request.getSession();
                        session.setAttribute("email", email);
                        session.setAttribute("userID", userId);
                        session.setAttribute("role", role); // ✅ Store role
                        session.setAttribute("loginAttempts", 0);

                        response.sendRedirect(request.getContextPath()+"/welcome.jsp");
                        return;
                    }
                }

                // Login failed
                HttpSession session = request.getSession(false);
                if (session == null) session = request.getSession();

                Integer attempts = (Integer) session.getAttribute("loginAttempts");
                if (attempts == null) attempts = 1;
                else attempts++;

                session.setAttribute("loginAttempts", attempts);

                if (attempts >= 3) {
                    session.setAttribute("loginAttempts", 0);
                    response.sendRedirect(request.getContextPath()+"forgotPassword.jsp");
                    return;
                }

                request.setAttribute("errorMessage", "Invalid email or password.");
                request.getRequestDispatcher(request.getContextPath()+"login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher(request.getContextPath()+"login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles user login with email, password, and sets role in session.";
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><head><title>LoginServlet</title></head><body>");
            out.println("<h1>Login Servlet reached at " + request.getContextPath() + "</h1>");
            out.println("</body></html>");
        }
    }
}