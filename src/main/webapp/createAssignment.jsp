<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.app.submission.model.User" %>
<%@ page import="com.app.submission.model.Role" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || user.getRole() != Role.INSTRUCTOR) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Assignment</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f4f6f9;
            color: #333;
        }

        .container {
            animation: fadeIn 1s ease-out;
        }

        h2 {
            font-size: 2.5rem;
            font-weight: 600;
            margin-bottom: 20px;
            color: #007bff;
            text-align: center;
        }

        .form-control {
            border-radius: 10px;
            transition: border 0.3s ease;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }

        button {
            background-color: #007bff;
            color: white;
            border-radius: 50px;
            padding: 12px 30px;
            border: none;
            transition: all 0.3s ease;
        }

        button:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }

        /* Animation for form input */
        .form-control, button {
            opacity: 0;
            animation: fadeInUp 1s ease-in-out forwards;
        }

        .form-control:nth-child(1) {
            animation-delay: 0.5s;
        }

        .form-control:nth-child(2) {
            animation-delay: 1s;
        }

        .form-control:nth-child(3) {
            animation-delay: 1.5s;
        }

        button {
            animation-delay: 2s;
        }

        /* Simple fade-in effect */
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2>Create Assignment</h2>
    <form action="createAssignment" method="post">
        <div class="mb-3">
            <label for="title">Title:</label>
            <input type="text" id="title" class="form-control" name="title" required>
        </div>
        <div class="mb-3">
            <label for="description">Description:</label>
            <textarea id="description" class="form-control" name="description" required></textarea>
        </div>
        <div class="mb-3">
            <label for="deadline">Deadline:</label>
            <input type="date" id="deadline" class="form-control" name="deadline" required>
        </div>
        <button type="submit" class="btn btn-primary">Create</button>
    </form>
</div>

<!-- Bootstrap JS and Popper.js for interactive components -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

</body>
</html>
