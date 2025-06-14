<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Integer userId = (Integer) session.getAttribute("userID");
    String username = "Guest";
    String email = "-";
    String profileInfo = "-";

    if (userId != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cinelux", "root", "admin");
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM User_ WHERE userID = ?");
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                username = rs.getString("username");
                email = rs.getString("email");
                profileInfo = rs.getString("profileInfo");
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        response.sendRedirect("${pageContext.request.contextPath}/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            background-color: #0c0422;
            color: white;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .navbar {
            background-color: #16132a;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 6px rgba(0,0,0,0.5);
        }

        .navbar img {
            height: 36px;
            margin-right: 12px;
        }

        .navbar a, .dropbtn {
            color: white;
            text-decoration: none;
            font-weight: bold;
            font-size: 1rem;
            padding: 8px 16px;
            border: none;
            background: none;
            cursor: pointer;
        }

        .dropdown {
            position: relative;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background-color: #2d2c44;
            min-width: 160px;
            border-radius: 6px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.6);
            z-index: 1000;
        }

        .dropdown-content a {
            color: #ffa94d;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            font-weight: bold;
        }

        .dropdown-content a:hover {
            background-color: #3c3a58;
            color: white;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .profile-container {
            background-color: #1f1f2f;
            padding: 2rem;
            border-radius: 10px;
            width: 400px;
            margin: 3rem auto;
            box-shadow: 0 0 10px rgba(255,255,255,0.1);
        }

        .profile-container h2 {
            text-align: center;
            margin-bottom: 1rem;
        }

        .profile-icon {
            text-align: center;
            margin-bottom: 1rem;
        }

        .profile-icon i {
            font-size: 2.8rem;
            color: #ffcc70;
        }

        .profile-item {
            margin-bottom: 1.5rem;
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 0.3rem;
        }

        input, textarea {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: #2a2a3d;
            color: white;
        }

        button {
            background-color: #ffcc70;
            border: none;
            padding: 10px 18px;
            border-radius: 6px;
            font-weight: bold;
            cursor: pointer;
            width: 100%;
        }

        button:disabled {
            background-color: #777;
            cursor: not-allowed;
        }


    </style>
    <script>
        let editMode = false;

        function toggleEdit(button) {
            const fields = document.querySelectorAll('.profile-container input, .profile-container textarea');
            if (!editMode) {
                fields.forEach(f => f.disabled = false);
                button.textContent = "💾 Confirm Update";
                editMode = true;
            } else {
                const confirmed = confirm("Are you sure you want to update your profile?");
                if (confirmed) {
                    document.getElementById("profileForm").submit();
                }
            }
        }
    </script>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div style="display: flex; align-items: center;">

         <a href="homepage.jsp" class="nav-home">🏠 Home</a>
    </div>
    <div class="dropdown">
        <button class="dropbtn"><i class="fas fa-user-circle"></i> Account ▾</button>
        <div class="dropdown-content">
            <a href="${pageContext.request.contextPath}/profile.jsp">👤 Profile</a>
            <% if ("admin".equals(session.getAttribute("role"))) { %>
                <a href="${pageContext.request.contextPath}/movieManagement.jsp">🎬 Movie Manage</a>
            <% } %>
            <a href="${pageContext.request.contextPath}/logout.jsp">🚪 Logout</a>
        </div>
    </div>
</div>

<!-- Profile Form -->
<div class="profile-container">
    <h2>My Profile</h2>
    <div class="profile-icon">
        <i class="fas fa-id-badge"></i>
    </div>

    <form action="UpdateProfileServlet" method="post" id="profileForm">
        <div class="profile-item">
            <label>Username:</label>
            <input type="text" name="username" value="<%= username %>" disabled>
        </div>
        <div class="profile-item">
            <label>Email:</label>
            <input type="email" name="email" value="<%= email %>" disabled>
        </div>
        <div class="profile-item">
            <label>Profile Info:</label>
            <textarea name="profileInfo" rows="3" disabled><%= profileInfo %></textarea>
        </div>
        <button type="button" onclick="toggleEdit(this)">✏️ Update Profile</button>
    </form>
</div>

</body>
</html>
