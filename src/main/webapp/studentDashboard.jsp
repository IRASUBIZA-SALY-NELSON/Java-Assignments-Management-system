<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, com.app.submission.model.Assignment, com.app.submission.model.Submission, com.app.submission.dao.AssignmentDAO, com.app.submission.dao.SubmissionDAO, com.app.submission.model.User" %>
<%@ page import="com.app.submission.model.Role" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || user.getRole() != Role.STUDENT) {
        response.sendRedirect("login.jsp");
        return;
    }

    AssignmentDAO assignmentDAO = new AssignmentDAO();
    SubmissionDAO submissionDAO = new SubmissionDAO();
    List<Assignment> assignments = assignmentDAO.getAllAssignments();

    int totalAssignments = assignments.size();
    int submittedCount = 0;
    for (Assignment assignment : assignments) {
        Submission submission = submissionDAO.getSubmissionByStudentAndAssignment(user.getId(), assignment.getId());
        if (submission != null) {
            submittedCount++;
        }
    }
    int pendingCount = totalAssignments - submittedCount;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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
        .dashboard-container {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-top: 50px;
            margin-bottom: 50px;
        }
        h2, h3 {
            color: var(--primary-color);
        }
        .summary-card {
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        .summary-card:hover {
            transform: translateY(-3px);
        }
        .summary-card .card-body {
            text-align: center;
        }
        .table thead {
            background-color: var(--primary-color);
            color: #ffffff;
        }
        .btn-primary, .btn-success {
            background-color: var(--primary-color);
            border: none;
        }
        .btn-primary:hover, .btn-success:hover {
            background-color: var(--secondary-color);
        }
        .btn-danger {
            background-color: #dc3545;
            border: none;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
        /* Search Bar */
        #assignmentSearch {
            max-width: 300px;
            margin-bottom: 20px;
        }
        /* Assignment Title as clickable link */
        .assignment-title {
            color: var(--primary-color);
            cursor: pointer;
            text-decoration: underline;
        }
        .assignment-title:hover {
            color: var(--secondary-color);
        }
    </style>
</head>
<body>
<div class="container dashboard-container">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2>Student Dashboard</h2>
            <p>Welcome, <strong><%= user.getName() %></strong>!</p>
        </div>
        <div>
            <a href="logout" class="btn btn-danger">Logout</a>
        </div>
    </div>

    <!-- Summary Cards -->
    <div class="row mb-4">
        <div class="col-md-4 mb-3">
            <div class="card summary-card">
                <div class="card-body">
                    <h5 class="card-title">Total Assignments</h5>
                    <p class="card-text fs-4"><%= totalAssignments %></p>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card summary-card">
                <div class="card-body">
                    <h5 class="card-title">Submitted</h5>
                    <p class="card-text fs-4 text-success"><%= submittedCount %></p>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3">
            <div class="card summary-card">
                <div class="card-body">
                    <h5 class="card-title">Pending</h5>
                    <p class="card-text fs-4 text-danger"><%= pendingCount %></p>
                </div>
            </div>
        </div>
    </div>

    <!-- Search Bar -->
    <div class="d-flex justify-content-end">
        <input type="text" id="assignmentSearch" class="form-control" placeholder="Search assignments...">
    </div>

    <!-- Assignment Table -->
    <h3 class="mt-4">Available Assignments</h3>
    <table class="table table-bordered" id="assignmentsTable">
        <thead>
        <tr>
            <th>Title</th>
            <th>Deadline</th>
            <th>Submission Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% for (Assignment assignment : assignments) {
            Submission submission = submissionDAO.getSubmissionByStudentAndAssignment(user.getId(), assignment.getId());
            String description = (assignment.getDescription() != null && !assignment.getDescription().trim().isEmpty())
                    ? assignment.getDescription() : "No description provided.";
        %>
        <tr>
            <td>
                <a href="#" class="assignment-title" data-bs-toggle="modal"
                   data-bs-target="#assignmentModal"
                   data-title="<%= assignment.getTitle() %>"
                   data-deadline="<%= assignment.getDeadline() %>"
                   data-description="<%= description %>">
                    <%= assignment.getTitle() %>
                </a>
            </td>
            <td><%= assignment.getDeadline() %></td>
            <td>
                <% if (submission != null) { %>
                <span class="text-success">✅ Submitted</span> (<a href="<%= submission.getFilePath() %>" target="_blank">View</a>)
                <% } else { %>
                <span class="text-danger">❌ Not Submitted</span>
                <% } %>
            </td>
            <td>
                <form action="UploadSubmissionServlet" method="post" enctype="multipart/form-data" class="d-inline">
                    <input type="hidden" name="assignmentId" value="<%= assignment.getId() %>">
                    <input type="file" name="file" class="form-control form-control-sm d-inline-block" style="width: 150px;" required data-bs-toggle="tooltip" title="Select file to upload">
                    <button type="submit" class="btn btn-success btn-sm mt-1" data-bs-toggle="tooltip" title="Upload Submission">Upload</button>
                </form>
                <% if (submission != null) { %>
                <a href="DeleteSubmissionServlet?submissionId=<%= submission.getId() %>" class="btn btn-danger btn-sm" data-bs-toggle="tooltip" title="Delete Submission" onclick="return confirm('Are you sure?')">Delete</a>
                <% } %>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

<!-- Assignment Details Modal -->
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

<!-- Bootstrap JS and interactive scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Initialize tooltips
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.forEach(function (tooltipTriggerEl) {
        new bootstrap.Tooltip(tooltipTriggerEl);
    });

    // Filter assignments as you type in the search bar
    document.getElementById('assignmentSearch').addEventListener('keyup', function() {
        var filter = this.value.toUpperCase();
        var rows = document.getElementById('assignmentsTable').getElementsByTagName('tr');
        for (var i = 1; i < rows.length; i++) { // start at 1 to skip header row
            var titleCol = rows[i].getElementsByTagName('td')[0];
            if (titleCol) {
                var txtValue = titleCol.textContent || titleCol.innerText;
                rows[i].style.display = txtValue.toUpperCase().indexOf(filter) > -1 ? "" : "none";
            }
        }
    });

    // Set up modal to display assignment details dynamically
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
</script>
</body>
</html>
