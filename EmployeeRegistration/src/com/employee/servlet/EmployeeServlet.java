package com.employee.servlet;

import com.employee.dao.EmployeeDAO;
import com.employee.model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * EmployeeServlet
 * ───────────────
 * Handles employee registration.
 *
 *  URL pattern : /registerEmployee
 *  GET         : Forwards to index.jsp (shows the registration form)
 *  POST        : Validates input → calls DAO → forwards to success.jsp
 *
 * Connected classes:
 *   DBConnection  ← used inside EmployeeDAO
 *   EmployeeDAO   ← does the actual SQL INSERT
 *   Employee      ← the data model passed between layers
 *   index.jsp     ← the View for the form (GET / on error)
 *   success.jsp   ← the View shown after successful registration
 */
@WebServlet("/registerEmployee")
public class EmployeeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private EmployeeDAO dao;

    @Override
    public void init() {
        // DAO is instantiated once when the servlet is loaded
        dao = new EmployeeDAO();
    }

    // ── GET ──────────────────────────────────────────────────────────────────

    /**
     * Simply forwards to the registration form.
     * Called when the user navigates to /registerEmployee directly.
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("index.jsp").forward(req, res);
    }

    // ── POST ─────────────────────────────────────────────────────────────────

    /**
     * Called when the registration form is submitted.
     *
     * Flow:
     *   1. Read & sanitise form parameters
     *   2. Server-side validation (empty fields, duplicate email, salary format)
     *   3. Build Employee object
     *   4. EmployeeDAO.registerEmployee() → MySQL INSERT
     *   5a. Success → set attribute, forward to success.jsp
     *   5b. Failure → set error attribute, forward back to index.jsp
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        // ── 1. Read parameters ─────────────────────────────────────────────
        String name       = req.getParameter("name");
        String email      = req.getParameter("email");
        String phone      = req.getParameter("phone");
        String department = req.getParameter("department");
        String salaryStr  = req.getParameter("salary");

        // Null-safe trim
        name       = (name       != null) ? name.trim()       : "";
        email      = (email      != null) ? email.trim()      : "";
        phone      = (phone      != null) ? phone.trim()      : "";
        department = (department != null) ? department.trim() : "";
        salaryStr  = (salaryStr  != null) ? salaryStr.trim()  : "";

        // ── 2. Validation ──────────────────────────────────────────────────
        StringBuilder error = new StringBuilder();

        if (name.isEmpty())       error.append("Full name is required. ");
        if (email.isEmpty())      error.append("Email is required. ");
        else if (!email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$"))
                                  error.append("Email format is invalid. ");
        else if (dao.isEmailExists(email))
                                  error.append("This email is already registered. ");
        if (phone.isEmpty())      error.append("Phone number is required. ");
        else if (!phone.matches("[6-9][0-9]{9}"))
                                  error.append("Phone must be a valid 10-digit Indian mobile number. ");
        if (department.isEmpty()) error.append("Please select a department. ");
        if (salaryStr.isEmpty())  error.append("Salary is required. ");

        double salary = 0;
        if (!salaryStr.isEmpty()) {
            try {
                salary = Double.parseDouble(salaryStr);
                if (salary < 0) error.append("Salary cannot be negative. ");
            } catch (NumberFormatException e) {
                error.append("Salary must be a valid number. ");
            }
        }

        // If any validation failed, bounce back to the form
        if (error.length() > 0) {
            req.setAttribute("error", error.toString().trim());
            // Repopulate form fields so the user doesn't re-type everything
            req.setAttribute("prevName",       name);
            req.setAttribute("prevEmail",      email);
            req.setAttribute("prevPhone",      phone);
            req.setAttribute("prevDepartment", department);
            req.setAttribute("prevSalary",     salaryStr);
            req.getRequestDispatcher("index.jsp").forward(req, res);
            return;
        }

        // ── 3. Build model ─────────────────────────────────────────────────
        Employee emp = new Employee(name, email, phone, department, salary);

        // ── 4. Persist ─────────────────────────────────────────────────────
        boolean ok = dao.registerEmployee(emp);

        // ── 5. Respond ─────────────────────────────────────────────────────
        if (ok) {
            req.setAttribute("employee", emp);
            req.getRequestDispatcher("success.jsp").forward(req, res);
        } else {
            req.setAttribute("error", "Database error — registration failed. Please try again.");
            req.getRequestDispatcher("index.jsp").forward(req, res);
        }
    }
}
