<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.app.submission.dao.SubmissionDAO, com.app.submission.dao.AssignmentDAO, com.app.submission.model.Submission, com.app.submission.model.Assignment, java.util.List" %>
<%@ page import="com.app.submission.model.User" %>
<%@ page import="com.app.submission.model.Role" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || user.getRole() != Role.INSTRUCTOR) {
        response.sendRedirect("login.jsp");
    }

    String assignmentId = request.getParameter("assignmentId");
    AssignmentDAO assignmentDAO = new AssignmentDAO();
    SubmissionDAO submissionDAO = new SubmissionDAO();

    Assignment assignment = assignmentDAO.getAssignmentById(Long.parseLong(assignmentId));
    List<Submission> submissions = submissionDAO.getSubmissionsByAssignment(Long.parseLong(assignmentId));
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Submissions - <%= assignment.getTitle() %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free/css/all.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        h2 {
            color: #007bff;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .badge {
            font-size: 1rem;
            padding: 10px;
        }
        .table-hover tbody tr:hover {
            background-color: #f1f1f1;
        }
        .pagination .page-item.active .page-link {
            background-color: #007bff;
            border-color: #007bff;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2>Submissions for: <%= assignment.getTitle() %></h2>

    <!-- Tooltips Section -->
    <div class="alert alert-info">
        <i class="fas fa-info-circle"></i> Below are the submissions for the assignment. You can see the status of each submission as either on time or late. You may download the submitted files by clicking the 'Download' button.
    </div>

    <table class="table table-bordered table-hover">
        <thead>
        <tr>
            <th>Student</th>
            <th>Submitted At</th>
            <th>Status</th>
            <th>File</th>
        </tr>
        </thead>
        <tbody>
        <% for (Submission submission : submissions) { %>
        <tr>
            <td><%= submission.getStudent().getName() %></td>
            <td><%= submission.getSubmittedAt() %></td>
            <td>
                <% if (submission.getSubmittedAt().isBefore(assignment.getDeadline().atStartOfDay())) { %>
                <span class="badge bg-success">On Time</span>
                <% } else { %>
                <span class="badge bg-danger">Late</span>
                <% } %>
            </td>
            <td>
                <a href="<%= submission.getFilePath() %>" download class="btn btn-outline-primary btn-sm">
                    <i class="fas fa-download"></i> Download
                </a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <!-- Pagination Section (For large lists of submissions) -->
    <nav>
        <ul class="pagination justify-content-center">
            <li class="page-item"><a class="page-link" href="#">Previous</a></li>
            <li class="page-item active"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item"><a class="page-link" href="#">Next</a></li>
        </ul>
    </nav>

    <div class="mt-3">
        <a href="instructorDashboard.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
    </div>
</div>

<!-- Bootstrap JS and Popper.js for Tooltips and Popovers -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
