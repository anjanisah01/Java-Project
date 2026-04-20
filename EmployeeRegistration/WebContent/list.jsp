<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.employee.model.Employee, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>All Employees</title>
<style>
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: 'Segoe UI', system-ui, sans-serif; background: #f0f4f8; min-height: 100vh; display: flex; flex-direction: column; }

/* Nav (same as other pages) */
.topbar { background: #0d3b66; color: #fff; display: flex; align-items: center; padding: 0 28px; height: 54px; }
.topbar .brand { font-size: 15px; font-weight: 600; padding-right: 24px; border-right: 1px solid rgba(255,255,255,0.2); margin-right: 8px; }
.topbar a { color: rgba(255,255,255,0.75); text-decoration: none; font-size: 13px; padding: 0 14px; height: 54px; display: inline-flex; align-items: center; border-bottom: 3px solid transparent; transition: color 0.15s; }
.topbar a.active { color: #fff; border-bottom-color: #1D9E75; }
.topbar a:hover  { color: #fff; }

main { flex: 1; padding: 28px 24px; max-width: 1000px; margin: 0 auto; width: 100%; }

/* ── Dashboard stats ───────────────────────────────── */
.stats { display: grid; grid-template-columns: repeat(3, 1fr); gap: 12px; margin-bottom: 22px; }
.stat-card {
    background: #fff; border-radius: 8px; padding: 14px 16px;
    box-shadow: 0 1px 6px rgba(0,0,0,0.06);
}
.stat-card .label { font-size: 11.5px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.05em; color: #6b7280; margin-bottom: 6px; }
.stat-card .value { font-size: 22px; font-weight: 700; color: #0d3b66; }

/* ── Toolbar ───────────────────────────────────────── */
.toolbar { display: flex; align-items: center; gap: 10px; margin-bottom: 14px; }
.toolbar input {
    flex: 1; padding: 8px 12px; border: 1.5px solid #d1d5db;
    border-radius: 6px; font-size: 14px; font-family: inherit; outline: none;
    transition: border-color 0.15s;
}
.toolbar input:focus { border-color: #1D9E75; }
.toolbar .btn-reg {
    background: #0d3b66; color: #fff; text-decoration: none;
    padding: 9px 16px; border-radius: 6px; font-size: 13.5px;
    font-weight: 600; white-space: nowrap;
    transition: background 0.15s;
}
.toolbar .btn-reg:hover { background: #0a2f52; }

/* ── Table ─────────────────────────────────────────── */
.table-wrap { background: #fff; border-radius: 10px; box-shadow: 0 1px 8px rgba(0,0,0,0.06); overflow: hidden; }
table { width: 100%; border-collapse: collapse; font-size: 13.5px; }
thead { background: #0d3b66; }
thead th { padding: 12px 16px; text-align: left; color: #fff; font-weight: 600; font-size: 12px; text-transform: uppercase; letter-spacing: 0.04em; white-space: nowrap; }
tbody tr { border-bottom: 1px solid #f3f4f6; transition: background 0.1s; }
tbody tr:last-child { border-bottom: none; }
tbody tr:hover { background: #f9fafb; }
tbody td { padding: 12px 16px; color: #374151; vertical-align: middle; }

.avatar {
    width: 34px; height: 34px; border-radius: 50%;
    background: #dbeafe; color: #1e40af;
    display: inline-flex; align-items: center; justify-content: center;
    font-size: 12px; font-weight: 700;
    vertical-align: middle; margin-right: 8px;
}
.emp-name { font-weight: 600; color: #111827; }
.emp-email { font-size: 12px; color: #6b7280; }

.badge {
    display: inline-block; padding: 3px 9px; border-radius: 20px;
    font-size: 11px; font-weight: 600;
}
.badge-eng  { background: #d1fae5; color: #065f46; }
.badge-mkt  { background: #dbeafe; color: #1e40af; }
.badge-fin  { background: #fef3c7; color: #92400e; }
.badge-hr   { background: #fee2e2; color: #991b1b; }
.badge-ops  { background: #ede9fe; color: #5b21b6; }
.badge-sal  { background: #fce7f3; color: #9d174d; }
.badge-it   { background: #d1fae5; color: #065f46; }
.badge-leg  { background: #fef3c7; color: #92400e; }
.badge-def  { background: #f3f4f6; color: #374151; }

.salary-cell { font-weight: 600; color: #059669; }

.btn-del {
    background: none; border: 1px solid #fca5a5; color: #dc2626;
    padding: 4px 10px; border-radius: 5px; font-size: 12px; font-family: inherit;
    cursor: pointer; transition: background 0.12s;
}
.btn-del:hover { background: #fee2e2; }

/* ── Empty state ───────────────────────────────────── */
.empty { padding: 48px; text-align: center; color: #9ca3af; }
.empty p { font-size: 14px; }
.empty a { color: #1D9E75; font-weight: 600; text-decoration: none; }
</style>
</head>
<body>

<nav class="topbar">
  <span class="brand">&#128188; Employee Portal</span>
  <a href="index.jsp">Register</a>
  <a href="listEmployees" class="active">All Employees</a>
</nav>

<main>
<%
    List<Employee> employees = (List<Employee>) request.getAttribute("employees");
    if (employees == null) employees = new java.util.ArrayList<>();

    int total = employees.size();
    double totalSalary = 0;
    for (Employee e : employees) totalSalary += e.getSalary();

    // Find largest dept
    java.util.Map<String,Integer> deptMap = new java.util.LinkedHashMap<>();
    for (Employee e : employees) deptMap.merge(e.getDepartment(), 1, Integer::sum);
    String topDept = "—";
    int topCount = 0;
    for (java.util.Map.Entry<String,Integer> entry : deptMap.entrySet()) {
        if (entry.getValue() > topCount) { topCount = entry.getValue(); topDept = entry.getKey() + " (" + topCount + ")"; }
    }

    // Badge CSS class helper
    java.util.Map<String,String> deptBadge = new java.util.HashMap<>();
    deptBadge.put("Engineering","badge-eng"); deptBadge.put("Marketing","badge-mkt");
    deptBadge.put("Finance","badge-fin");     deptBadge.put("Human Resources","badge-hr");
    deptBadge.put("Operations","badge-ops");  deptBadge.put("Sales","badge-sal");
    deptBadge.put("IT","badge-it");           deptBadge.put("Legal","badge-leg");
%>

  <!-- Stats row -->
  <div class="stats">
    <div class="stat-card"><p class="label">Total Employees</p><p class="value"><%= total %></p></div>
    <div class="stat-card"><p class="label">Total Payroll</p><p class="value">&#x20B9;&nbsp;<%= String.format("%,.0f", totalSalary) %></p></div>
    <div class="stat-card"><p class="label">Largest Team</p><p class="value" style="font-size:16px"><%= total > 0 ? topDept : "—" %></p></div>
  </div>

  <!-- Search bar + Register button -->
  <div class="toolbar">
    <input type="text" id="searchInput" placeholder="Search by name, email, or department..." oninput="filterTable()">
    <a href="index.jsp" class="btn-reg">&#43;&nbsp;Register New</a>
  </div>

  <!-- Employee table -->
  <div class="table-wrap">
    <% if (employees.isEmpty()) { %>
      <div class="empty">
        <p>No employees registered yet.</p>
        <p style="margin-top:8px"><a href="index.jsp">Register your first employee &rarr;</a></p>
      </div>
    <% } else { %>
    <table id="empTable">
      <thead>
        <tr>
          <th>#</th>
          <th>Employee</th>
          <th>Phone</th>
          <th>Department</th>
          <th>Salary</th>
          <th>Registered</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
      <%
          int sr = 1;
          for (Employee emp : employees) {
              String[] nameParts = emp.getName().trim().split("\\s+");
              StringBuilder initB = new StringBuilder();
              for (String p : nameParts) { if (!p.isEmpty()) initB.append(p.charAt(0)); }
              String ini = initB.toString().toUpperCase();
              if (ini.length() > 2) ini = ini.substring(0, 2);
              String badgeCss = deptBadge.getOrDefault(emp.getDepartment(), "badge-def");
      %>
        <tr>
          <td style="color:#9ca3af; font-size:12px"><%= sr++ %></td>
          <td>
            <span class="avatar"><%= ini %></span>
            <span class="emp-name"><%= emp.getName() %></span><br>
            <span class="emp-email" style="margin-left:42px"><%= emp.getEmail() %></span>
          </td>
          <td><%= emp.getPhone() %></td>
          <td><span class="badge <%= badgeCss %>"><%= emp.getDepartment() %></span></td>
          <td class="salary-cell">&#x20B9;&nbsp;<%= String.format("%,.2f", emp.getSalary()) %></td>
          <td style="color:#6b7280; font-size:12px"><%= emp.getCreatedAt() %></td>
          <td>
            <a href="deleteEmployee?id=<%= emp.getId() %>"
               class="btn-del"
               onclick="return confirm('Remove <%= emp.getName() %> from the system?')">
              Remove
            </a>
          </td>
        </tr>
      <% } %>
      </tbody>
    </table>
    <% } %>
  </div>

  <% if (!employees.isEmpty()) { %>
  <p style="font-size:12px; color:#9ca3af; margin-top:10px; text-align:right">
    Showing <span id="visibleCount"><%= total %></span> of <%= total %> employees
  </p>
  <% } %>
</main>

<script>
function filterTable() {
    var q = document.getElementById('searchInput').value.toLowerCase();
    var rows = document.querySelectorAll('#empTable tbody tr');
    var visible = 0;
    rows.forEach(function(row) {
        var text = row.textContent.toLowerCase();
        var show = text.includes(q);
        row.style.display = show ? '' : 'none';
        if (show) visible++;
    });
    var vc = document.getElementById('visibleCount');
    if (vc) vc.textContent = visible;
}
</script>
</body>
</html>
