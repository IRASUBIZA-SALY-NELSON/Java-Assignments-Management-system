<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.app.submission.model.Assignment, com.app.submission.dao.AssignmentDAO, com.app.submission.model.User" %>
<%@ page import="com.app.submission.model.Role" %>
<%
  User user = (User) session.getAttribute("user");
  if (user == null || user.getRole() != Role.INSTRUCTOR) {
    response.sendRedirect("login.jsp");
    return;
  }

  int assignmentId = Integer.parseInt(request.getParameter("assignmentId"));
  AssignmentDAO assignmentDAO = new AssignmentDAO();
  Assignment assignment = assignmentDAO.getAssignmentById((long) assignmentId);

  if (assignment == null) {
    response.sendRedirect("instructorDashboard.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit Assignment</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    body {
      background-color: #f8f9fa;
    }
    .container {
      background-color: white;
      border-radius: 8px;
      padding: 30px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    h2 {
      color: #007bff;
      margin-bottom: 20px;
    }
    .btn {
      font-size: 16px;
    }
    .form-control {
      border-radius: 8px;
      box-shadow: inset 0 1px 3px rgba(0,0,0,.12), 0 0 8px rgba(0,0,0,.1);
    }
    .btn-success {
      background-color: #28a745;
      border-color: #28a745;
    }
    .btn-secondary {
      background-color: #6c757d;
      border-color: #6c757d;
    }
    .btn-secondary:hover {
      background-color: #5a6268;
      border-color: #545b62;
    }
    .form-label {
      font-weight: bold;
    }
  </style>
</head>
<body>
<div class="container mt-5">
  <h2>Edit Assignment</h2>
  <form action="UpdateAssignmentServlet" method="post">
    <input type="hidden" name="assignmentId" value="<%= assignment.getId() %>">

    <!-- Title Field -->
    <div class="mb-3">
      <label class="form-label">Title</label>
      <input type="text" name="title" class="form-control" value="<%= assignment.getTitle() %>" required>
    </div>

    <!-- Deadline Field -->
    <div class="mb-3">
      <label class="form-label">Deadline</label>
      <input type="datetime-local" name="deadline" class="form-control" value="<%= assignment.getDeadline() %>" required>
    </div>

    <!-- Action Buttons -->
    <button type="submit" class="btn btn-success">
      <i class="fas fa-save"></i> Update Assignment
    </button>
    <a href="instructorDashboard.jsp" class="btn btn-secondary">
      <i class="fas fa-arrow-left"></i> Cancel
    </a>
  </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
