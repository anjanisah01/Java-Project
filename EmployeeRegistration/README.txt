╔══════════════════════════════════════════════════════════════════════╗
║          EMPLOYEE REGISTRATION APP — Setup & Run Guide              ║
╚══════════════════════════════════════════════════════════════════════╝

── Prerequisites ────────────────────────────────────────────────────────
  • JDK 1.8 or later
  • Apache Tomcat 8.5
  • MySQL 8.x
  • IDE: Eclipse / STS (Spring Tool Suite)
  • MySQL Connector JAR: mysql-connector-java-8.0.13.jar

── Project Structure ────────────────────────────────────────────────────

EmployeeRegistration/
├── schema.sql                          ← Run first in MySQL
├── src/
│   └── com/employee/
│       ├── model/
│       │   └── Employee.java           ← POJO / JavaBean
│       ├── util/
│       │   └── DBConnection.java       ← JDBC connection helper
│       ├── dao/
│       │   └── EmployeeDAO.java        ← All SQL operations
│       └── servlet/
│           ├── EmployeeServlet.java    ← POST /registerEmployee
│           ├── ListEmployeeServlet.java← GET  /listEmployees
│           └── DeleteEmployeeServlet.java ← GET /deleteEmployee
└── WebContent/
    ├── index.jsp                       ← Registration form
    ├── success.jsp                     ← Confirmation page
    ├── list.jsp                        ← Employee table
    └── WEB-INF/
        ├── web.xml                     ← Deployment descriptor
        └── lib/
            └── mysql-connector-java-8.0.13.jar  ← ADD THIS JAR

── Step-by-step Setup ───────────────────────────────────────────────────

STEP 1 — Setup MySQL
  a) Open MySQL Workbench (or MySQL CLI)
  b) Run: schema.sql
     This creates the database, table, and adds 5 sample employees.
  c) Verify: SELECT * FROM employee_db.employee;

STEP 2 — Configure DB password
  Open: src/com/employee/util/DBConnection.java
  Change line:
      private static final String DB_PASS = "your_password";
  To your actual MySQL root password.

STEP 3 — Import into Eclipse
  a) File → Import → Existing Projects into Workspace
  b) Select the EmployeeRegistration folder
  c) Right-click project → Properties → Java Build Path
     → Add External JARs → select mysql-connector-java-8.0.13.jar
  d) Copy the same JAR to: WebContent/WEB-INF/lib/

STEP 4 — Configure Tomcat in Eclipse
  a) Window → Preferences → Server → Runtime Environments → Add
  b) Choose Apache Tomcat 8.5 → browse to Tomcat directory
  c) Right-click project → Run As → Run on Server

STEP 5 — Run
  Open browser: http://localhost:8080/EmployeeRegistration/

── URL Map ──────────────────────────────────────────────────────────────

  /                        → index.jsp (registration form)
  /registerEmployee (GET)  → index.jsp
  /registerEmployee (POST) → EmployeeServlet → success.jsp
  /listEmployees           → ListEmployeeServlet → list.jsp
  /deleteEmployee?id=N     → DeleteEmployeeServlet → redirects to list

── How the classes connect ──────────────────────────────────────────────

  Browser
    │
    ▼ (POST /registerEmployee)
  EmployeeServlet.doPost()
    │  reads form params, validates
    ├─ isEmailExists() ──► EmployeeDAO.isEmailExists() ──► DBConnection ──► MySQL
    ├─ new Employee(...)
    └─ registerEmployee() ─► EmployeeDAO.registerEmployee() ─► DBConnection ─► MySQL
         │
         ▼ (success)
       index.jsp ◄─── (on error, forward back)
       success.jsp ◄── (on success, forward with Employee attribute)

  Browser (GET /listEmployees)
    │
    ▼
  ListEmployeeServlet.doGet()
    └─ getAllEmployees() ─► EmployeeDAO.getAllEmployees() ─► DBConnection ─► MySQL
         │
         ▼
       list.jsp  (iterates List<Employee> from request attribute)

  Browser (GET /deleteEmployee?id=N)
    │
    ▼
  DeleteEmployeeServlet.doGet()
    └─ deleteEmployee(N) ─► EmployeeDAO.deleteEmployee() ─► DBConnection ─► MySQL
         │
         ▼ (redirect)
       /listEmployees

── Troubleshooting ──────────────────────────────────────────────────────

  Problem: ClassNotFoundException: com.mysql.cj.jdbc.Driver
  Fix:     Add mysql-connector-java-8.0.13.jar to WEB-INF/lib/

  Problem: SQLException: Access denied for user 'root'
  Fix:     Check DB_PASS in DBConnection.java

  Problem: 404 on /registerEmployee
  Fix:     Ensure @WebServlet annotation processing is enabled in Tomcat
           OR manually declare servlets in web.xml (see web.xml comments)

  Problem: Table 'employee_db.employee' doesn't exist
  Fix:     Run schema.sql first

══════════════════════════════════════════════════════════════════════════
