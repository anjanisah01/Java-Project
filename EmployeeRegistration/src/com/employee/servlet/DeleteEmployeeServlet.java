package com.employee.servlet;

import com.employee.dao.EmployeeDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * DeleteEmployeeServlet
 * ─────────────────────
 * Deletes an employee by ID, then redirects back to /listEmployees.
 *
 *  URL pattern : /deleteEmployee
 *  GET         : reads ?id=N → calls DAO.deleteEmployee(N) → redirects
 *
 * Connected classes:
 *   EmployeeDAO       ← calls deleteEmployee(int id)
 *   ListEmployeeServlet / list.jsp ← redirected to after deletion
 */
@WebServlet("/deleteEmployee")
public class DeleteEmployeeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private EmployeeDAO dao;

    @Override
    public void init() {
        dao = new EmployeeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                dao.deleteEmployee(id);
            } catch (NumberFormatException e) {
                // Invalid id — ignore and redirect
            }
        }
        // Always redirect back to the employee list
        res.sendRedirect(req.getContextPath() + "/listEmployees");
    }
}
