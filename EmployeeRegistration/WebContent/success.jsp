<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.employee.model.Employee" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Registration Successful</title>
<style>
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

body {
    font-family: 'Segoe UI', system-ui, sans-serif;
    background: #f0f4f8;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}
.topbar {
    background: #0d3b66;
    color: #fff;
    display: flex;
    align-items: center;
    padding: 0 28px;
    height: 54px;
    gap: 0;
}
.topbar .brand { font-size: 15px; font-weight: 600; padding-right: 24px; border-right: 1px solid rgba(255,255,255,0.2); margin-right: 8px; }
.topbar a { color: rgba(255,255,255,0.75); text-decoration: none; font-size: 13px; padding: 0 14px; height: 54px; display: inline-flex; align-items: center; border-bottom: 3px solid transparent; transition: color 0.15s; }
.topbar a:hover { color: #fff; }
main { flex: 1; display: flex; align-items: flex-start; justify-content: center; padding: 36px 16px; }

.card {
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 2px 16px rgba(0,0,0,0.07);
    padding: 32px 36px;
    width: 100%;
    max-width: 500px;
    text-align: center;
}

.success-icon {
    width: 56px; height: 56px; border-radius: 50%;
    background: #d1fae5;
    display: flex; align-items: center; justify-content: center;
    margin: 0 auto 14px;
    font-size: 24px;
    color: #059669;
}

.card h1 { font-size: 20px; font-weight: 600; color: #059669; margin-bottom: 5px; }
.card .subtitle { font-size: 13px; color: #6b7280; margin-bottom: 24px; }

/* ── Employee info card ─────────────────────────────── */
.emp-card {
    background: #f9fafb;
    border: 1px solid #e5e7eb;
    border-radius: 8px;
    padding: 14px 16px;
    display: flex;
    align-items: center;
    gap: 12px;
    text-align: left;
    margin-bottom: 18px;
}
.avatar {
    width: 42px; height: 42px; border-radius: 50%;
    background: #dbeafe;
    color: #1e40af;
    display: flex; align-items: center; justify-content: center;
    font-size: 14px; font-weight: 600;
    flex-shrink: 0;
}
.emp-card .emp-name  { font-size: 15px; font-weight: 600; color: #111827; }
.emp-card .emp-email { font-size: 12px; color: #6b7280; }
.badge {
    margin-left: auto;
    background: #d1fae5; color: #065f46;
    font-size: 11px; font-weight: 600;
    padding: 3px 10px; border-radius: 20px;
}

/* ── Detail table ──────────────────────────────────── */
.detail-table { width: 100%; border-collapse: collapse; font-size: 13px; text-align: left; margin-bottom: 22px; }
.detail-table tr { border-top: 1px solid #f3f4f6; }
.detail-table td:first-child { padding: 9px 0; color: #6b7280; width: 120px; }
.detail-table td:last-child  { padding: 9px 0; font-weight: 600; color: #111827; }

/* ── Buttons ───────────────────────────────────────── */
.btn-row { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
.btn {
    padding: 10px;
    border-radius: 6px;
    font-size: 13.5px;
    font-weight: 600;
    font-family: inherit;
    cursor: pointer;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    transition: opacity 0.15s;
    border: none;
}
.btn:hover { opacity: 0.85; }
.btn-outline { background: #f3f4f6; color: #374151; }
.btn-primary { background: #0d3b66; color: #fff; }
</style>
</head>
<body>
<%
    // Guard: if accessed directly without going through the servlet, redirect
    Employee emp = (Employee) request.getAttribute("employee");
    if (emp == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    // Generate initials for avatar
    String[] parts = emp.getName().trim().split("\\s+");
    StringBuilder initBuilder = new StringBuilder();
    for (String p : parts) { if (!p.isEmpty()) initBuilder.append(p.charAt(0)); }
    String initials = initBuilder.toString().toUpperCase();
    if (initials.length() > 2) initials = initials.substring(0, 2);
%>

<nav class="topbar">
    <span class="brand">&#128188; Employee Portal</span>
    <a href="index.jsp">Register</a>
    <a href="listEmployees">All Employees</a>
</nav>

<main>
  <div class="card">

    <div class="success-icon">&#10003;</div>
    <h1>Registration Successful!</h1>
    <p class="subtitle">The employee has been saved to the database.</p>

    <!-- Employee summary card -->
    <div class="emp-card">
      <div class="avatar"><%= initials %></div>
      <div>
        <p class="emp-name"><%= emp.getName() %></p>
        <p class="emp-email"><%= emp.getEmail() %></p>
      </div>
      <span class="badge"><%= emp.getDepartment() %></span>
    </div>

    <!-- Detail table -->
    <table class="detail-table">
      <tr><td>Phone</td>     <td><%= emp.getPhone() %></td></tr>
      <tr><td>Salary</td>    <td>&#x20B9; <%= String.format("%,.2f", emp.getSalary()) %></td></tr>
      <tr><td>Status</td>    <td style="color:#059669">&#9679;&nbsp;Active</td></tr>
    </table>

    <!-- Action buttons -->
    <div class="btn-row">
      <a href="index.jsp"       class="btn btn-outline">&#43;&nbsp;Register Another</a>
      <a href="listEmployees"   class="btn btn-primary">&#128203;&nbsp;View All Records</a>
    </div>

  </div>
</main>
</body>
</html>
