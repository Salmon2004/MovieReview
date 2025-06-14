/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author U S E R
 */


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection("jdbc:mysql://localhost:3306/cinelux", "root", "admin");
        } catch (Exception e) {
            throw new SQLException("Database connection error", e);
        }
    }

    // Add new comment
    public void addComment(Comment comment) throws SQLException {
        String sql = "INSERT INTO comment (commentText, userID, reviewID, dateCommented) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, comment.getCommentText());
            stmt.setInt(2, comment.getUserID());
            stmt.setInt(3, comment.getReviewID());
            stmt.setDate(4, new java.sql.Date(comment.getDateCommented().getTime()));
            stmt.executeUpdate();
        }
    }

    // Get comments for a specific review
    public List<Comment> getCommentsByReviewId(int reviewId) throws SQLException {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT * FROM comment WHERE reviewID = ? ORDER BY dateCommented ASC";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, reviewId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Comment c = new Comment();
                c.setCommentID(rs.getInt("commentID"));
                c.setCommentText(rs.getString("commentText"));
                c.setUserID(rs.getInt("userID"));
                c.setReviewID(rs.getInt("reviewID"));
                c.setDateCommented(rs.getDate("dateCommented"));
                comments.add(c);
            }
        }
        return comments;
    }

    // Get single comment by ID
    public Comment getCommentById(int commentId) throws SQLException {
        String sql = "SELECT * FROM comment WHERE commentID = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, commentId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Comment c = new Comment();
                c.setCommentID(rs.getInt("commentID"));
                c.setCommentText(rs.getString("commentText"));
                c.setUserID(rs.getInt("userID"));
                c.setReviewID(rs.getInt("reviewID"));
                c.setDateCommented(rs.getDate("dateCommented"));
                return c;
            }
        }
        return null;
    }

    // Update comment (only by owner)
    public void updateComment(Comment comment) throws SQLException {
        String sql = "UPDATE comment SET commentText = ? WHERE commentID = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, comment.getCommentText());
            stmt.setInt(2, comment.getCommentID());
            stmt.executeUpdate();
        }
    }

    // Delete comment (only by owner)
 public void deleteComment(int commentId) {
    try (Connection conn = getConnection()) {

        // 1. Delete reactions first
        String deleteReactions = "DELETE FROM reaction WHERE commentID = ?";
        PreparedStatement ps1 = conn.prepareStatement(deleteReactions);
        ps1.setInt(1, commentId);
        ps1.executeUpdate();

        // 2. Then delete comment
        String deleteComment = "DELETE FROM comment WHERE commentID = ?";
        PreparedStatement ps2 = conn.prepareStatement(deleteComment);
        ps2.setInt(1, commentId);
        ps2.executeUpdate();

    } catch (SQLException e) {
        e.printStackTrace();
    }
}
}
