<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            border: 2px solid #001f3f;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top: 80px;
            max-width: 500px;
        }
        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #001f3f;
        }
        .form-label {
            font-weight: bold;
            color: #001f3f;
        }
        .btn-primary {
            background-color: #001f3f;
            border: none;
        }
        .btn-primary:hover {
            background-color: #001737;
        }
        .btn-link {
            display: block;
            text-align: center;
            margin-top: 15px;
            color: #001f3f;
        }
        .error-message {
            color: red;
            font-size: 0.9rem;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Register</h2>
    <form action="RegisterServlet" method="post">
        <div class="mb-3">
            <label for="name" class="form-label">Enter your Full Names</label>
            <input type="text" class="form-control" id="name" name="name" required>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" required>
            <% if (request.getParameter("error") != null && request.getParameter("error").equals("EmailExists")) { %>
            <div class="error-message">Email already exists. Please use a different email.</div>
            <% } %>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" required>
            <div class="form-check mt-2">
                <input type="checkbox" class="form-check-input" id="showPassword" onclick="togglePasswordVisibility()">
                <label class="form-check-label" for="showPassword">Show Password</label>
            </div>
        </div>

        <div class="mb-3">
            <label for="role" class="form-label">Role</label>
            <select class="form-control" id="role" name="role" required>
                <option value="STUDENT">Student</option>
                <option value="INSTRUCTOR">Instructor</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary w-100">Register</button>
        <a href="login.jsp" class="btn btn-link">Already have an account? Login</a>
    </form>
</div>

<script>
    function togglePasswordVisibility() {
        var passwordField = document.getElementById("password");
        passwordField.type = (passwordField.type === "password") ? "text" : "password";
    }
</script>
</body>
</html>
