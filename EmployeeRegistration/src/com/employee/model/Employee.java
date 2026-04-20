package com.employee.model;

/**
 * Employee — JavaBean / POJO that maps to the `employee` table in MySQL.
 *
 * Table columns  →  Java fields
 * ─────────────────────────────────
 * id             →  int    id
 * name           →  String name
 * email          →  String email
 * phone          →  String phone
 * department     →  String department
 * salary         →  double salary
 * created_at     →  String createdAt  (stored as ISO string, formatted in JSP)
 */
public class Employee {

    // ── Fields ──────────────────────────────────────────────────────────────
    private int    id;
    private String name;
    private String email;
    private String phone;
    private String department;
    private double salary;
    private String createdAt;

    // ── Constructors ─────────────────────────────────────────────────────────

    /** No-arg constructor required by JavaBeans spec. */
    public Employee() {}

    /**
     * Constructor used when building an object from form data
     * (before it has an id or createdAt timestamp).
     */
    public Employee(String name, String email, String phone,
                    String department, double salary) {
        this.name       = name;
        this.email      = email;
        this.phone      = phone;
        this.department = department;
        this.salary     = salary;
    }

    // ── Getters & Setters ────────────────────────────────────────────────────

    public int    getId()                     { return id; }
    public void   setId(int id)               { this.id = id; }

    public String getName()                   { return name; }
    public void   setName(String name)        { this.name = name; }

    public String getEmail()                  { return email; }
    public void   setEmail(String email)      { this.email = email; }

    public String getPhone()                  { return phone; }
    public void   setPhone(String phone)      { this.phone = phone; }

    public String getDepartment()             { return department; }
    public void   setDepartment(String dept)  { this.department = dept; }

    public double getSalary()                 { return salary; }
    public void   setSalary(double salary)    { this.salary = salary; }

    public String getCreatedAt()              { return createdAt; }
    public void   setCreatedAt(String c)      { this.createdAt = c; }

    @Override
    public String toString() {
        return "Employee{id=" + id
             + ", name='" + name + '\''
             + ", email='" + email + '\''
             + ", department='" + department + '\''
             + ", salary=" + salary + '}';
    }
}
