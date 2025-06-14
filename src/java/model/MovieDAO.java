/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MovieDAO {

    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection("jdbc:mysql://localhost:3306/cinelux", "root", "admin");
        } catch (Exception e) {
            throw new SQLException("Database connection error", e);
        }
    }

    public List<Movie> getAllMovies() throws SQLException {
        List<Movie> movies = new ArrayList<>();
        String sql = "SELECT * FROM Movie";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Movie m = new Movie();
                m.setMovieId(rs.getInt("movieID"));
                m.setTitle(rs.getString("title"));
                m.setGenre(rs.getString("genre"));
                m.setReleaseDate(rs.getDate("releaseDate"));
                m.setDirector(rs.getString("director"));
                m.setImageFile(rs.getString("imageFile"));
                movies.add(m);
            }
        }
        return movies;
    }

    public Movie getMovieById(int movieId) throws SQLException {
        String sql = "SELECT * FROM Movie WHERE movieID = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, movieId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Movie m = new Movie();
                m.setMovieId(rs.getInt("movieID"));
                m.setTitle(rs.getString("title"));
                m.setGenre(rs.getString("genre"));
                m.setReleaseDate(rs.getDate("releaseDate"));
                m.setDirector(rs.getString("director"));
                m.setImageFile(rs.getString("imageFile"));
                return m;
            }
        }
        return null;
    }

    public void updateMovie(Movie movie) throws SQLException {
        String sql = "UPDATE Movie SET title = ?, genre = ?, releaseDate = ?, director = ?, imageFile = ? WHERE movieID = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, movie.getTitle());
            stmt.setString(2, movie.getGenre());
            stmt.setDate(3, movie.getReleaseDate());
            stmt.setString(4, movie.getDirector());
            stmt.setString(5, movie.getImageFile());
            stmt.setInt(6, movie.getMovieId());
            stmt.executeUpdate();
        }
    }

    public void deleteMovie(int movieId) throws SQLException {
        String sql = "DELETE FROM Movie WHERE movieID = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, movieId);
            stmt.executeUpdate();
        }
    }
    public void insertMovie(Movie movie) throws SQLException {
    String sql = "INSERT INTO Movie (title, genre, releaseDate, director, cast, rating, imageFile, description) " +
                 "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, movie.getTitle());
        stmt.setString(2, movie.getGenre());
        stmt.setDate(3, movie.getReleaseDate());
        stmt.setString(4, movie.getDirector());
        stmt.setString(5, movie.getCast());
        stmt.setFloat(6, movie.getRating());
        stmt.setString(7, movie.getImageFile());
        stmt.setString(8, movie.getDescription());
        stmt.executeUpdate();
    }
}

}
