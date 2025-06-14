<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.ReviewDAO" %>
<%
    String userRole = (session != null) ? (String) session.getAttribute("role") : null;
    if (userRole == null || !"admin".equals(userRole)) {
%>
    <h2 style="color:red;">Access denied. Admin only.</h2>
    <a href="${pageContext.request.contextPath}/homepage.jsp">Return to homepage</a>
<%
        return;
    }

    ReviewDAO dao = new ReviewDAO();
    List<Map<String, String>> movies = dao.getAllMoviePosters();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Movies</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            background-color: #0c0422;
            color: white;
            font-family: Arial, sans-serif;
            margin: 0;
        }
        .navbar {
            background-color: #16132a;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
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
        .dropbtn i { margin-right: 6px; }
        .dropdown { position: relative; display: inline-block; }
        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background-color: #2d2c44;
            min-width: 160px;
            border-radius: 6px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.6);
            z-index: 2000;
            margin-top: 8px;
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
        .dropdown:hover .dropdown-content { display: block; }
        h2 { padding: 2rem 2rem 0.5rem; }
        .add-movie-button {
            text-align: right;
            padding: 0 2rem 1rem;
        }
        .add-movie-button a {
            background-color: #51cf66;
            color: #0c0422;
            padding: 10px 16px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }
        .add-movie-button a:hover {
            background-color: #38b000;
            color: white;
        }
        .controls {
            display: flex;
            justify-content: space-between;
            padding: 0 2rem 1rem;
        }
        .controls input {
            padding: 8px;
            width: 200px;
            border-radius: 5px;
            border: none;
        }
        table {
            width: 96%;
            margin: auto;
            border-collapse: collapse;
            background-color: #1f1f2f;
            color: white;
            border-radius: 10px;
            overflow: hidden;
        }
        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #333;
        }
        th {
            background-color: #2c2c40;
            cursor: pointer;
        }
        tbody tr:hover {
            background-color: #2c2c40;
            transition: background-color 0.2s ease-in-out;
        }
        img {
            max-height: 80px;
            border-radius: 5px;
            transition: transform 0.3s ease;
        }
        img:hover { transform: scale(1.1); }
        .actions a {
            padding: 6px 14px;
            border-radius: 5px;
            font-weight: bold;
            text-decoration: none;
            margin-right: 8px;
        }
        .actions a:first-child { background-color: #4dabf7; color: white; }
        .actions a:last-child { background-color: #f03e3e; color: white; }
        .actions a:hover { opacity: 0.85; }
        .pagination {
            text-align: center;
            padding: 1rem;
        }
        .pagination a {
            color: white;
            padding: 8px 12px;
            margin: 0 4px;
            text-decoration: none;
            background-color: #444;
            border-radius: 5px;
        }
        .pagination a:hover {
            background-color: #666;
        }
    </style>
</head>
<body>
<div class="navbar">
    <div><a href="${pageContext.request.contextPath}/homepage.jsp">🏠 Home</a></div>
    <div class="dropdown">
        <button class="dropbtn"><i class="fas fa-user-circle"></i> Account ▾</button>
        <div class="dropdown-content">
            <a href="${pageContext.request.contextPath}/profile.jsp">👤 Profile</a>
            <a href="${pageContext.request.contextPath}/movieManagement.jsp">🎬 Movie Manage</a>
            <a href="${pageContext.request.contextPath}/logout.jsp">🚪 Logout</a>
        </div>
    </div>
</div>

<h2>Movie Management</h2>
<div class="controls">
    <input type="text" id="searchInput" placeholder="Search movie title..." onkeyup="filterTable()">
    <div class="add-movie-button">
        <a href="${pageContext.request.contextPath}/addMovie.jsp">➕ Add Movie</a>
    </div>
</div>

<table id="movieTable">
    <thead>
        <tr>
            <th onclick="sortTable(0)">ID 🔽</th>
<th>Poster</th>
<th onclick="sortTable(2)">Title 🔽</th>

            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
    <% for (Map<String, String> movie : movies) { %>
        <tr>
            <td><%= movie.get("movieID") %></td>
            <td><img src="images/<%= movie.get("imageFile") %>" alt="Poster"></td>
            <td><%= movie.get("title") %></td>
            <td class="actions">
                <a href="${pageContext.request.contextPath}/editMovie.jsp?movie_id=<%= movie.get("movieID") %>">Edit</a>
                <a href="${pageContext.request.contextPath}/deleteMovie.jsp?movie_id=<%= movie.get("movieID") %>"
                   onclick="return confirm('Are you sure you want to delete this movie?')">Delete</a>
            </td>
        </tr>
    <% } %>
    </tbody>
</table>

<div class="pagination" id="pagination"></div>

<script>
function filterTable() {
    const input = document.getElementById("searchInput").value.toLowerCase();
    const rows = document.querySelectorAll("#movieTable tbody tr");
    rows.forEach(row => {
        const title = row.cells[2].textContent.toLowerCase();
        row.style.display = title.includes(input) ? "" : "none";
    });
}

function sortTable(colIndex) {
    const table = document.getElementById("movieTable");
    const rows = Array.from(table.rows).slice(1);
    const sorted = rows.sort((a, b) => a.cells[colIndex].innerText.localeCompare(b.cells[colIndex].innerText));
    sorted.forEach(row => table.tBodies[0].appendChild(row));
}

   
    const dropdown = document.querySelector(".dropdown");
    let timer;

    dropdown.addEventListener("mouseenter", () => {
        clearTimeout(timer);
        dropdown.querySelector(".dropdown-content").style.display = "block";
    });

    dropdown.addEventListener("mouseleave", () => {
        timer = setTimeout(() => {
            dropdown.querySelector(".dropdown-content").style.display = "none";
        }, 300); // 300ms delay before it disappears
    });

</script>
<script>
let sortDirections = {}; // to track sort direction per column

function sortTable(colIndex) {
    const table = document.getElementById("movieTable");
    const tbody = table.tBodies[0];
    const rows = Array.from(tbody.rows);

    // Determine current sort direction
    let direction = sortDirections[colIndex] === "asc" ? "desc" : "asc";
    sortDirections = {}; // reset all others
    sortDirections[colIndex] = direction;

    // Perform sorting
    rows.sort((a, b) => {
        let valA = a.cells[colIndex].textContent.trim();
        let valB = b.cells[colIndex].textContent.trim();

        // Numeric sort for ID
        if (colIndex === 0) {
            valA = parseInt(valA);
            valB = parseInt(valB);
        }

        if (direction === "asc") {
            return valA > valB ? 1 : valA < valB ? -1 : 0;
        } else {
            return valA < valB ? 1 : valA > valB ? -1 : 0;
        }
    });

    // Re-append sorted rows
    rows.forEach(row => tbody.appendChild(row));

    // Update headers with arrow indicators
    const headers = table.querySelectorAll("th");
    headers.forEach((th, index) => {
        if (index === colIndex) {
            th.innerHTML = th.textContent.trim().replace(/ 🔽| 🔼/g, "") + (direction === "asc" ? " 🔼" : " 🔽");
        } else {
            th.innerHTML = th.textContent.trim().replace(/ 🔽| 🔼/g, "");
        }
    });
}
</script>

</body>
</html>
