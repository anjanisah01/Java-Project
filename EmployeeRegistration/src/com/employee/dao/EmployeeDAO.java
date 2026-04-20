package com.employee.dao;

import com.employee.model.Employee;
import com.employee.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * EmployeeDAO (Data Access Object)
 *
 * Centralises ALL SQL operations for the employee table.
 * Servlets call this class; this class talks to MySQL via DBConnection.
 *
 * Operations provided:
 *   - registerEmployee(Employee)   → INSERT
 *   - getAllEmployees()             → SELECT all
 *   - getEmployeeById(int)         → SELECT by PK
 *   - isEmailExists(String)        → duplicate-email check
 *   - deleteEmployee(int)          → DELETE by PK
 */
public class EmployeeDAO {

    // ── INSERT ───────────────────────────────────────────────────────────────

    /**
     * Inserts a new employee record into the database.
     *
     * @param emp  Employee object (name, email, phone, department, salary set)
     * @return true if at least one row was inserted, false otherwise
     */
    public boolean registerEmployee(Employee emp) {
        String sql = "INSERT INTO employee (name, email, phone, department, salary) "
                   + "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, emp.getName());
            ps.setString(2, emp.getEmail());
            ps.setString(3, emp.getPhone());
            ps.setString(4, emp.getDepartment());
            ps.setDouble(5, emp.getSalary());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[EmployeeDAO.registerEmployee] Error: " + e.getMessage());
            return false;
        }
    }

    // ── SELECT ALL ───────────────────────────────────────────────────────────

    /**
     * Returns all employees ordered by most recently registered first.
     */
    public List<Employee> getAllEmployees() {
        List<Employee> list = new ArrayList<>();
        String sql = "SELECT id, name, email, phone, department, salary, "
                   + "DATE_FORMAT(created_at,'%d-%b-%Y') AS created_at "
                   + "FROM employee ORDER BY created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Employee emp = new Employee();
                emp.setId(rs.getInt("id"));
                emp.setName(rs.getString("name"));
                emp.setEmail(rs.getString("email"));
                emp.setPhone(rs.getString("phone"));
                emp.setDepartment(rs.getString("department"));
                emp.setSalary(rs.getDouble("salary"));
                emp.setCreatedAt(rs.getString("created_at"));
                list.add(emp);
            }

        } catch (SQLException e) {
            System.err.println("[EmployeeDAO.getAllEmployees] Error: " + e.getMessage());
        }
        return list;
    }

    // ── SELECT BY ID ─────────────────────────────────────────────────────────

    /**
     * Returns a single Employee by primary key, or null if not found.
     */
    public Employee getEmployeeById(int id) {
        String sql = "SELECT * FROM employee WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Employee emp = new Employee();
                    emp.setId(rs.getInt("id"));
                    emp.setName(rs.getString("name"));
                    emp.setEmail(rs.getString("email"));
                    emp.setPhone(rs.getString("phone"));
                    emp.setDepartment(rs.getString("department"));
                    emp.setSalary(rs.getDouble("salary"));
                    return emp;
                }
            }
        } catch (SQLException e) {
            System.err.println("[EmployeeDAO.getEmployeeById] Error: " + e.getMessage());
        }
        return null;
    }

    // ── DUPLICATE EMAIL CHECK ────────────────────────────────────────────────

    /**
     * Returns true if the given email already exists in the database.
     * Used for server-side validation before INSERT.
     */
    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM employee WHERE email = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            System.err.println("[EmployeeDAO.isEmailExists] Error: " + e.getMessage());
        }
        return false;
    }

    // ── DELETE ───────────────────────────────────────────────────────────────

    /**
     * Deletes an employee by primary key.
     *
     * @param id  Primary key of the employee to delete
     * @return true if the row was deleted
     */
    public boolean deleteEmployee(int id) {
        String sql = "DELETE FROM employee WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[EmployeeDAO.deleteEmployee] Error: " + e.getMessage());
            return false;
        }
    }
}
