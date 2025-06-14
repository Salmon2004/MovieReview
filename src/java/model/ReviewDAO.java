    package model;


    import java.sql.*;
    import java.util.*;

    public class ReviewDAO {

        private Connection getConnection() throws SQLException {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                return DriverManager.getConnection("jdbc:mysql://localhost:3306/cinelux", "root", "admin");
            } catch (Exception e) {
                throw new SQLException("Database connection error", e);
            }
        }

        public void insertReview(Review review) throws SQLException {
            String sql = "INSERT INTO Review (reviewText, rating, datePosted, userID, movieID) VALUES (?, ?, NOW(), ?, ?)";
            try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, review.getReviewText());
                stmt.setFloat(2, review.getRating());
                stmt.setInt(3, review.getUserId());
                stmt.setInt(4, review.getMovieId());
                stmt.executeUpdate();
            }
        }

        public List<Review> getReviewsByMovieId(int movieId) throws SQLException {
            List<Review> reviews = new ArrayList<>();
            String sql = "SELECT * FROM Review WHERE movieID = ?";
            try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, movieId);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Review r = new Review();
                    r.setReviewId(rs.getInt("reviewID"));
                    r.setUserId(rs.getInt("userID"));
                    r.setMovieId(rs.getInt("movieID"));
                    r.setReviewText(rs.getString("reviewText"));
                    r.setRating(rs.getFloat("rating"));
                    r.setDatePosted(rs.getDate("datePosted"));
                    reviews.add(r);
                }
            }
            return reviews;
        }

        public Review getReviewById(int reviewId) throws SQLException {
            String sql = "SELECT * FROM Review WHERE reviewID = ?";
            try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, reviewId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    Review r = new Review();
                    r.setReviewId(rs.getInt("reviewID"));
                    r.setUserId(rs.getInt("userID"));
                    r.setMovieId(rs.getInt("movieID"));
                    r.setReviewText(rs.getString("reviewText"));
                    r.setRating(rs.getFloat("rating"));
                    r.setDatePosted(rs.getDate("datePosted"));
                    return r;
                }
            }
            return null;
        }

        public void updateReview(Review review) throws SQLException {
            String sql = "UPDATE Review SET reviewText = ?, rating = ? WHERE reviewID = ?";
            try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, review.getReviewText());
                stmt.setFloat(2, review.getRating());
                stmt.setInt(3, review.getReviewId());
                stmt.executeUpdate();
            }
        }

        public void deleteReview(int reviewId) throws SQLException {
            String sql = "DELETE FROM Review WHERE reviewID = ?";
            try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, reviewId);
                stmt.executeUpdate();
            }
        }

        public String getMovieTitleById(int movieId) throws SQLException {
            String sql = "SELECT title FROM Movie WHERE movieID = ?";
            try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, movieId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    return rs.getString("title");
                }
            }
            return "Unknown Movie";
        }

        public String getUsernameById(int userId) throws SQLException {
            String sql = "SELECT username FROM User_ WHERE userID = ?";
            try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, userId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    return rs.getString("username");
                }
            }
            return "Unknown User";
        }

        public List<String[]> getAllMovies() throws SQLException {
            List<String[]> movies = new ArrayList<>();
            String sql = "SELECT movieID, title FROM Movie";
            try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    movies.add(new String[] {
                        String.valueOf(rs.getInt("movieID")),
                        rs.getString("title")
                    });
                }
            }
            return movies;
        }

      public List<Map<String, String>> getTopReviews() {
    List<Map<String, String>> reviews = new ArrayList<>();
    try (Connection conn = getConnection()) {
        String sql = "SELECT r.reviewID, r.rating, r.reviewText, u.username, m.title " +
                     "FROM Review r " +
                     "JOIN User_ u ON r.userID = u.userID " +
                     "JOIN Movie m ON r.movieID = m.movieID " +
                     "ORDER BY r.rating DESC LIMIT 5";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Map<String, String> map = new HashMap<>();
            map.put("reviewID", String.valueOf(rs.getInt("reviewID")));
            map.put("rating", rs.getString("rating"));
            map.put("reviewText", rs.getString("reviewText"));
            map.put("username", rs.getString("username"));
            map.put("movieTitle", rs.getString("title"));
            reviews.add(map);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return reviews;
}


      public List<Map<String, String>> getAllMoviePosters() throws SQLException {
        List<Map<String, String>> movies = new ArrayList<>();
        String sql = "SELECT movieID, title, imageFile FROM Movie";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
               Map<String, String> movie = new HashMap<>();
                movie.put("movieID", String.valueOf(rs.getInt("movieID"))); // IMPORTANT
                movie.put("title", rs.getString("title"));
                movie.put("imageFile", rs.getString("imageFile"));

                movies.add(movie);
            }
        }
        return movies;
    }

    public List<Map<String, String>> searchMoviePosters(String query) {
    List<Map<String, String>> posters = new ArrayList<>();
    String sql = "SELECT movieID, title, imageFile FROM Movie WHERE title LIKE ?";
    try (Connection conn = getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setString(1, "%" + query + "%");
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Map<String, String> movie = new HashMap<>();
            movie.put("movieID", String.valueOf(rs.getInt("movieID")));
            movie.put("title", rs.getString("title"));
            movie.put("imageFile", rs.getString("imageFile"));
            posters.add(movie);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return posters;
}

        
    public String getMoviePosterFileById(int movieId) throws SQLException {
    String sql = "SELECT imageFile FROM Movie WHERE movieID = ?";
    try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, movieId);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getString("imageFile");
        }
    }
    return "default.jpg"; // fallback image
}

public Movie getMovieById(int movieId) throws SQLException {
    String sql = "SELECT * FROM Movie WHERE movieID = ?";
    try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, movieId);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            Movie movie = new Movie();
            movie.setMovieId(rs.getInt("movieID"));
            movie.setTitle(rs.getString("title"));
            movie.setGenre(rs.getString("genre"));
         movie.setReleaseDate(rs.getDate("releaseDate"));   // ✅ correct
            movie.setDescription(rs.getString("description"));
            movie.setDirector(rs.getString("director"));
            movie.setCast(rs.getString("cast"));
          movie.setReleaseDate(rs.getDate("releaseDate"));

            movie.setImageFile(rs.getString("imageFile"));
            return movie;
        }
    }
    return null;
}

public float getAverageRatingForMovie(int movieId) throws SQLException {
    String sql = "SELECT AVG(rating) AS avgRating FROM Review WHERE movieID = ?";
    try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, movieId);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getFloat("avgRating");
        }
    }
    return 0;
}
public List<Map<String, String>> searchMoviePostersWithFilter(String query, String genre, String rating) {
    List<Map<String, String>> movies = new ArrayList<>();

    String sql = "SELECT movieID, title, imageFile FROM movie " +
                 "WHERE title LIKE ? " +
                 "AND (? = '' OR genre = ?) " +
                 "AND (? = '' OR rating >= ?)";

    try (Connection conn = getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, "%" + query + "%");  // search term
        stmt.setString(2, genre);              // genre filter
        stmt.setString(3, genre);              // genre comparison
        stmt.setString(4, rating);             // rating filter
        stmt.setFloat(5, (rating != null && !rating.isEmpty()) ? Float.parseFloat(rating) : 0.0f);


        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            Map<String, String> movie = new HashMap<>();
            movie.put("movieID", String.valueOf(rs.getInt("movieID")));
            movie.put("title", rs.getString("title"));
            movie.put("imageFile", rs.getString("imageFile"));
            movies.add(movie);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return movies;
}

    }
