package com.employee.servlet;

import com.employee.dao.EmployeeDAO;
import com.employee.model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * ListEmployeeServlet
 * ───────────────────
 * Retrieves all employees from the database and forwards to list.jsp.
 *
 *  URL pattern : /listEmployees
 *  GET         : Fetches all rows → forwards to list.jsp
 *
 * Connected classes:
 *   EmployeeDAO  ← calls getAllEmployees()
 *   Employee     ← the data model
 *   list.jsp     ← iterates over the List<Employee> and renders the table
 */
@WebServlet("/listEmployees")
public class ListEmployeeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private EmployeeDAO dao;

    @Override
    public void init() {
        dao = new EmployeeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        List<Employee> employees = dao.getAllEmployees();

        // Make the list available to list.jsp via request scope
        req.setAttribute("employees", employees);

        // Summary stats (used in list.jsp for the dashboard cards)
        double totalSalary = employees.stream().mapToDouble(Employee::getSalary).sum();
        req.setAttribute("totalSalary", totalSalary);
        req.setAttribute("totalCount", employees.size());

        req.getRequestDispatcher("list.jsp").forward(req, res);
    }
}
