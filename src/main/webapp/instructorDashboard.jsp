<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, com.app.submission.model.Assignment, com.app.submission.dao.AssignmentDAO, com.app.submission.model.User" %>
<%@ page import="com.app.submission.model.Role" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || user.getRole() != Role.INSTRUCTOR) {
        response.sendRedirect("login.jsp");
        return;
    }

    AssignmentDAO assignmentDAO = new AssignmentDAO();
    List<Assignment> assignments = assignmentDAO.getAssignmentsByInstructor(user);

    int totalAssignments = assignments.size();
    int activeCount = 0;
    int pastCount = 0;
    for (Assignment a : assignments) {
        if (a.getDeadline() != null && a.getDeadline().toString().contains("2025")) {
            activeCount++;
        } else {
            pastCount++;
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instructor Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
        }
        .navbar {
            background-color: var(--primary-color);
        }
        .navbar-brand, .nav-link {
            color: #fff !important;
        }
        .container-dashboard {
            margin-top: 60px;
            margin-bottom: 60px;
        }
        .card {
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .summary-card {
            transition: transform 0.3s;
        }
        .summary-card:hover {
            transform: translateY(-5px);
        }
        .table thead {
            background-color: var(--primary-color);
            color: #fff;
        }
        .btn {
            border-radius: 20px;
        }
        .btn-primary, .btn-info, .btn-warning, .btn-danger {
            transition: background-color 0.3s;
        }
        .btn-primary:hover {
            background-color: var(--secondary-color);
        }
        .assignment-title {
            cursor: pointer;
            text-decoration: underline;
            color: var(--primary-color);
        }
        .assignment-title:hover {
            color: var(--secondary-color);
        }
        #assignmentSearch {
            max-width: 300px;
        }
        .chart-container {
            position: relative;
            margin: auto;
            height: 300px;
            width: 100%;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="#">Instructor Dashboard</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon" style="filter: invert(1);"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="createAssignment.jsp">Create Assignment</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="logout">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container container-dashboard">
    <div class="row mb-4">
        <div class="col-md-8">
            <h2>Welcome, <strong>Instructor  <%= user.getName() %></strong>!</h2>
            <p>Manage your assignments, track student submissions, and review performance.</p>
        </div>
        <div class="col-md-4 text-end">
            <input type="text" id="assignmentSearch" class="form-control" placeholder="Search assignments...">
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-md-4 mb-3">
            <div class="card summary-card">
                <div class="card-body text-center">
                    <h5 class="card-title">Total Assignments</h5>
                    <p class="card-text fs-3"><%= totalAssignments %></p>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card summary-card">
                <div class="card-body text-center">
                    <h5 class="card-title">Active Assignments</h5>
                    <p class="card-text fs-3"><%= activeCount %></p>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card summary-card">
                <div class="card-body text-center">
                    <h5 class="card-title">Past Assignments</h5>
                    <p class="card-text fs-3"><%= pastCount %></p>
                </div>
            </div>
        </div>
    </div>

    <h3 class="mb-3">Your Assignments</h3>
    <div class="table-responsive">
        <table class="table table-bordered" id="assignmentsTable">
            <thead>
            <tr>
                <th>Title</th>
                <th>Deadline</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (Assignment assignment : assignments) { %>
            <tr>
                <td>
                    <a href="#" class="assignment-title" data-bs-toggle="modal"
                       data-bs-target="#assignmentModal"
                       data-title="<%= assignment.getTitle() %>"
                       data-deadline="<%= assignment.getDeadline() %>"
                       data-description="<%= (assignment.getDescription() != null ? assignment.getDescription() : "No description provided.") %>">
                        <%= assignment.getTitle() %>
                    </a>
                </td>
                <td><%= assignment.getDeadline() %></td>
                <td>
                    <a href="viewSubmissions.jsp?assignmentId=<%= assignment.getId() %>" class="btn btn-info btn-sm">View Submissions</a>
                    <a href="editAssignment.jsp?assignmentId=<%= assignment.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                    <a href="DeleteAssignmentServlet?assignmentId=<%= assignment.getId() %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this assignment?')">Delete</a>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <div class="row mb-5">
        <div class="col-md-12">
<%--            <h3 class="mb-3">Submission Statistics</h3>--%>
            <div class="chart-container">
                <canvas id="submissionChart"></canvas>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="assignmentModal" tabindex="-1" aria-labelledby="assignmentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header" style="background-color: var(--primary-color); color: #fff;">
                <h5 class="modal-title" id="assignmentModalLabel">Assignment Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" style="filter: invert(1);"></button>
            </div>
            <div class="modal-body">
                <p><strong>Deadline:</strong> <span id="modalDeadline"></span></p>
                <p id="modalDescription"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    var assignmentModal = document.getElementById('assignmentModal');
    assignmentModal.addEventListener('show.bs.modal', function (event) {
        var link = event.relatedTarget;
        var title = link.getAttribute('data-title');
        var deadline = link.getAttribute('data-deadline');
        var description = link.getAttribute('data-description');

        var modalTitle = assignmentModal.querySelector('.modal-title');
        var modalDeadline = assignmentModal.querySelector('#modalDeadline');
        var modalDescription = assignmentModal.querySelector('#modalDescription');

        modalTitle.textContent = title;
        modalDeadline.textContent = deadline;
        modalDescription.textContent = description;
    });

    document.getElementById('assignmentSearch').addEventListener('keyup', function() {
        var filter = this.value.toUpperCase();
        var rows = document.getElementById('assignmentsTable').getElementsByTagName('tr');
        for (var i = 0; i < rows.length; i++) {
            var titleCell = rows[i].getElementsByTagName('td')[0];
            if (titleCell) {
                var txtValue = titleCell.textContent || titleCell.innerText;
                rows[i].style.display = txtValue.toUpperCase().indexOf(filter) > -1 ? "" : "none";
            }
        }
    });

    var submissionData = {
        labels: [<%
        for (int i = 0; i < assignments.size(); i++) {
            out.print("'" + assignments.get(i).getTitle() + "'");
            if (i < assignments.size() - 1) out.print(", ");
        }
        %>],
        datasets: [{
            label: 'Submissions Count',
            data: [<%
            for (int i = 0; i < assignments.size(); i++) {
                out.print(assignments.get(i).getSubmissions().size());
                if (i < assignments.size() - 1) out.print(", ");
            }
            %>],
            backgroundColor: 'rgba(54, 162, 235, 0.2)',
            borderColor: 'rgba(54, 162, 235, 1)',
            borderWidth: 1
        }]
    };

    var ctx = document.getElementById('submissionChart').getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: submissionData,
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>
</body>
</html>
