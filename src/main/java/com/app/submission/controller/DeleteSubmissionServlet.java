package com.app.submission.controller;

import com.app.submission.model.Role;
import com.app.submission.dao.SubmissionDAO;
import com.app.submission.model.Submission;
import com.app.submission.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;

@WebServlet("/DeleteSubmissionServlet")
public class DeleteSubmissionServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRole() != Role.STUDENT) {
            response.sendRedirect("login.jsp");
            return;
        }

        Long submissionId = Long.parseLong(request.getParameter("submissionId"));
        SubmissionDAO submissionDAO = new SubmissionDAO();
        Submission submission = submissionDAO.getSubmissionById(submissionId);

        if (submission != null && submission.getStudent().getId().equals(user.getId())) {
            File file = new File(getServletContext().getRealPath("") + File.separator + submission.getFilePath());
            if (file.exists()) file.delete();
            submissionDAO.deleteSubmission(submissionId);
        }

        response.sendRedirect("studentDashboard.jsp");
    }
}
