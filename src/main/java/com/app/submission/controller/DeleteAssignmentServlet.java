package com.app.submission.controller;

import com.app.submission.model.Role;
import com.app.submission.dao.AssignmentDAO;
import com.app.submission.model.Assignment;
import com.app.submission.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/DeleteAssignmentServlet")
public class DeleteAssignmentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User instructor = (User) session.getAttribute("user");

        if (instructor == null || instructor.getRole() != Role.INSTRUCTOR) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int assignmentId = Integer.parseInt(request.getParameter("assignmentId"));
            AssignmentDAO assignmentDAO = new AssignmentDAO();
            Assignment assignment = assignmentDAO.getAssignmentById((long) assignmentId);

            // Check if the assignment exists and belongs to the logged-in instructor
            if (assignment != null && assignment.getCreatedBy().getId() == instructor.getId()) {
                assignmentDAO.deleteAssignment(assignment);
            }

            response.sendRedirect("instructorDashboard.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
