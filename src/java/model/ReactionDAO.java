/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.*;

/**
 * ReactionDAO handles like/dislike reactions for comments.
 */
public class ReactionDAO {

    // Database connection method
    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection("jdbc:mysql://localhost:3306/cinelux", "root", "admin");
        } catch (ClassNotFoundException | SQLException e) {
            throw new SQLException("Database connection error", e);
        }
    }

    // Handles a "like" action
    public void likeComment(int userId, int commentId) throws SQLException {
        updateReaction(userId, commentId, true);
    }

    // Handles a "dislike" action
    public void dislikeComment(int userId, int commentId) throws SQLException {
        updateReaction(userId, commentId, false);
    }

    // Internal method: inserts or updates a reaction
    private void updateReaction(int userId, int commentId, boolean isLike) throws SQLException {
        String checkQuery = "SELECT * FROM Reaction WHERE userID = ? AND commentID = ?";
        String updateQuery = "UPDATE Reaction SET isLike = ? WHERE userID = ? AND commentID = ?";
        String insertQuery = "INSERT INTO Reaction (userID, commentID, isLike) VALUES (?, ?, ?)";

        try (Connection conn = getConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {

            checkStmt.setInt(1, userId);
            checkStmt.setInt(2, commentId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                    updateStmt.setBoolean(1, isLike);
                    updateStmt.setInt(2, userId);
                    updateStmt.setInt(3, commentId);
                    updateStmt.executeUpdate();
                }
            } else {
                try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
                    insertStmt.setInt(1, userId);
                    insertStmt.setInt(2, commentId);
                    insertStmt.setBoolean(3, isLike);
                    insertStmt.executeUpdate();
                }
            }
        }
    }

    // Count total likes for a comment
    public int getLikeCount(int commentId) throws SQLException {
        return getReactionCount(commentId, true);
    }

    // Count total dislikes for a comment
    public int getDislikeCount(int commentId) throws SQLException {
        return getReactionCount(commentId, false);
    }

    // Internal method to count reactions
    private int getReactionCount(int commentId, boolean isLike) throws SQLException {
        String countQuery = "SELECT COUNT(*) FROM Reaction WHERE commentID = ? AND isLike = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(countQuery)) {

            stmt.setInt(1, commentId);
            stmt.setBoolean(2, isLike);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        }
    }
}
