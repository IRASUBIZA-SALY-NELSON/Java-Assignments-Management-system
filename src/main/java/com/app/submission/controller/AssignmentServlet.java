package com.app.submission.controller;

import com.app.submission.model.Role;
import com.app.submission.dao.AssignmentDAO;
import com.app.submission.model.Assignment;
import com.app.submission.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/createAssignment")
public class AssignmentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRole() != Role.INSTRUCTOR) {
            response.sendRedirect("login.jsp");
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String deadline = request.getParameter("deadline");

        Assignment assignment = new Assignment();
        assignment.setTitle(title);
        assignment.setDescription(description);
        assignment.setDeadline(LocalDate.parse(deadline));
        assignment.setInstructor(user);
        assignment.setCreatedBy(user);

        AssignmentDAO assignmentDAO = new AssignmentDAO();
        assignmentDAO.saveAssignment(assignment);

        response.sendRedirect("instructorDashboard.jsp");
    }
}
