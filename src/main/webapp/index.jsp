<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Online Submission System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    <style>
        :root {
            --primary-color: #001f3f;
            --secondary-color: #001737;
            --light-bg: #f8f9fa;
        }
        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: var(--primary-color);
            line-height: 1.6;
        }
        .navbar {
            background-color: var(--primary-color);
        }
        .navbar-brand, .nav-link {
            color: #fff !important;
        }
        .nav-link:hover {
            color: var(--secondary-color) !important;
        }
        .hero {
            background: linear-gradient(rgba(0, 31, 63, 0.8), rgba(0, 31, 63, 0.8)),
            url('https://source.unsplash.com/1600x900/?education,technology');
            background-size: cover;
            background-position: center;
            color: #fff;
            padding: 100px 20px;
            text-align: center;
        }
        .feature-card {
            border: none;
            border-radius: 8px;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }
        .cta {
            background-color: var(--light-bg);
            padding: 60px 20px;
            text-align: center;
        }
        footer {
            background-color: var(--primary-color);
            color: #fff;
            padding: 20px 0;
            text-align: center;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="#">Online Submission System</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon" style="filter: invert(1);"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="register.jsp">Register</a></li>
                <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
            </ul>
        </div>
    </div>
</nav>
<section class="hero">
    <div class="container">
        <h1>Welcome to the Online Submission System</h1>
        <p>Submit, review, and manage assignments online with ease.</p>
        <div class="mt-4">
            <a href="register.jsp" class="btn btn-light btn-lg me-2">Get Started</a>
            <a href="login.jsp" class="btn btn-outline-light btn-lg">Login</a>
        </div>
    </div>
</section>
<section class="py-5">
    <div class="container">
        <div class="row text-center">
            <div class="col-md-4 mb-4">
                <div class="card feature-card">
                    <div class="card-body">
                        <h5 class="card-title">Seamless Submission</h5>
                        <p>Upload assignments effortlessly and track progress.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card feature-card">
                    <div class="card-body">
                        <h5 class="card-title">Instant Feedback</h5>
                        <p>Get evaluations and suggestions in real-time.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card feature-card">
                    <div class="card-body">
                        <h5 class="card-title">Secure & Reliable</h5>
                        <p>Your data is protected with our security measures.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="py-5">
    <div class="container">
        <h2 class="text-center mb-4">More Features</h2>
        <div class="row text-center">
            <div class="col-md-3 mb-4">
                <div class="card feature-card">
                    <div class="card-body">
                        <h5 class="card-title">Automated Grading</h5>
                        <p>Speed up assessment with AI-driven grading.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-4">
                <div class="card feature-card">
                    <div class="card-body">
                        <h5 class="card-title">Collaboration Tools</h5>
                        <p>Work with peers using built-in discussion forums.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-4">
                <div class="card feature-card">
                    <div class="card-body">
                        <h5 class="card-title">Plagiarism Checker</h5>
                        <p>Ensure originality with advanced detection tools.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-4">
                <div class="card feature-card">
                    <div class="card-body">
                        <h5 class="card-title">Mobile-Friendly</h5>
                        <p>Submit assignments from any device, anytime.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="cta">
    <div class="container">
        <h2>Join Us Today</h2>
        <p>Experience the future of assignment submission.</p>
        <a href="register.jsp" class="btn btn-primary btn-lg">Sign Up Now</a>
    </div>
</section>
<footer>
    <div class="container">
        <p>&copy; 2025 Online Submission System. All Rights Reserved.</p>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
