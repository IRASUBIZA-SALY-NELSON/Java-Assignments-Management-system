<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Online Submission System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- Bootstrap Icons for the show password toggle -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #001f3f;
            --secondary-color: #001737;
            --light-bg: #f8f9fa;
        }
        body {
            background: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .login-card {
            width: 350px;
            border: none;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .login-card .card-header {
            background-color: var(--primary-color);
            color: #fff;
            text-align: center;
            font-size: 1.5rem;
            font-weight: bold;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
            padding: 15px;
        }
        .login-card .card-body {
            padding: 20px;
        }
        .btn-primary {
            background-color: var(--primary-color);
            border: none;
        }
        .btn-primary:hover {
            background-color: var(--secondary-color);
        }
        .input-group-text {
            background-color: var(--primary-color);
            border: none;
            cursor: pointer;
            color: #fff;
        }
        .additional-links {
            margin-top: 15px;
            font-size: 0.9rem;
            text-align: center;
        }
        .additional-links a {
            color: var(--primary-color);
            text-decoration: none;
        }
        .additional-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center vh-100">
<div class="card login-card">
    <div class="card-header">
        Sign In
    </div>
    <div class="card-body">
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>
        <form action="login" method="post">
            <div class="mb-3">
                <label for="email" class="form-label">Email Address</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="example@domain.com" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <div class="input-group">
                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
                    <span class="input-group-text" onclick="togglePasswordVisibility()">
              <i id="toggleIcon" class="bi bi-eye"></i>
            </span>
                </div>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>
        <div class="additional-links">
            <p><a href="forgotPassword.jsp">Forgot Password?</a></p>
            <p>Don't have an account? <a href="register.jsp">Register here</a></p>
        </div>
    </div>
</div>

<script>
    function togglePasswordVisibility() {
        var passwordInput = document.getElementById('password');
        var toggleIcon = document.getElementById('toggleIcon');
        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            toggleIcon.classList.remove("bi-eye");
            toggleIcon.classList.add("bi-eye-slash");
        } else {
            passwordInput.type = "password";
            toggleIcon.classList.remove("bi-eye-slash");
            toggleIcon.classList.add("bi-eye");
        }
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
