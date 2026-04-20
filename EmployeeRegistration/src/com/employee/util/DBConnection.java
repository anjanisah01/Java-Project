package com.employee.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection
 * Utility class that provides a JDBC Connection to MySQL.
 *
 * HOW TO USE:
 *   Connection con = DBConnection.getConnection();
 *   // ... use con ...
 *   con.close();   // always close in finally / try-with-resources
 *
 * SETUP:
 *   1. Place mysql-connector-java-8.0.13.jar in WebContent/WEB-INF/lib/
 *   2. Change DB_PASS below to your MySQL root password.
 */
public class DBConnection {

    // ── Connection parameters ──────────────────────────────────────────────
    private static final String DRIVER   = "com.mysql.cj.jdbc.Driver";
    private static final String DB_URL   = "jdbc:mysql://localhost:3306/employee_db"
                                         + "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String DB_USER  = "root";
    private static final String DB_PASS  = "your_password";   // ← CHANGE THIS

    // Prevent instantiation
    private DBConnection() {}

    /**
     * Returns a new Connection every time.
     * Always close it in a finally block or try-with-resources.
     *
     * @return java.sql.Connection
     * @throws SQLException if driver not found or credentials are wrong
     */
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException ex) {
            throw new SQLException(
                "MySQL JDBC Driver not found. Did you add the JAR to WEB-INF/lib? → " + ex.getMessage()
            );
        }
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
    }
}
