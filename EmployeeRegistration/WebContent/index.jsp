<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Employee Registration</title>
<style>
/* ── Reset ─────────────────────────────────────────────── */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

/* ── Page ──────────────────────────────────────────────── */
body {
    font-family: 'Segoe UI', system-ui, sans-serif;
    background: #f0f4f8;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

/* ── Top navigation bar ────────────────────────────────── */
.topbar {
    background: #0d3b66;
    color: #fff;
    display: flex;
    align-items: center;
    padding: 0 28px;
    height: 54px;
    gap: 0;
}
.topbar .brand {
    font-size: 15px;
    font-weight: 600;
    letter-spacing: 0.02em;
    padding-right: 24px;
    border-right: 1px solid rgba(255,255,255,0.2);
    margin-right: 8px;
}
.topbar a {
    color: rgba(255,255,255,0.75);
    text-decoration: none;
    font-size: 13px;
    padding: 0 14px;
    height: 54px;
    display: inline-flex;
    align-items: center;
    border-bottom: 3px solid transparent;
    transition: color 0.15s, border-color 0.15s;
}
.topbar a.active { color: #fff; border-bottom-color: #1D9E75; }
.topbar a:hover  { color: #fff; }

/* ── Main content ──────────────────────────────────────── */
main {
    flex: 1;
    display: flex;
    align-items: flex-start;
    justify-content: center;
    padding: 36px 16px;
}

/* ── Card ──────────────────────────────────────────────── */
.card {
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 2px 16px rgba(0,0,0,0.07);
    padding: 32px 36px;
    width: 100%;
    max-width: 540px;
}
.card-title   { font-size: 19px; font-weight: 600; color: #0d3b66; margin-bottom: 4px; }
.card-subtitle{ font-size: 13px; color: #6b7280; margin-bottom: 24px; }

/* ── Error banner ──────────────────────────────────────── */
.error-box {
    background: #fff5f5;
    border-left: 4px solid #E24B4A;
    color: #991b1b;
    padding: 10px 14px;
    border-radius: 4px;
    margin-bottom: 20px;
    font-size: 13px;
    line-height: 1.5;
}

/* ── Form grid ─────────────────────────────────────────── */
.grid-2 {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 0 16px;
}

/* ── Form group ────────────────────────────────────────── */
.form-group { margin-bottom: 16px; }
.form-group label {
    display: block;
    font-size: 11.5px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    color: #6b7280;
    margin-bottom: 6px;
}
.form-group input,
.form-group select {
    width: 100%;
    padding: 9px 12px;
    border: 1.5px solid #d1d5db;
    border-radius: 6px;
    font-size: 14px;
    font-family: inherit;
    color: #111827;
    background: #fff;
    outline: none;
    transition: border-color 0.15s, box-shadow 0.15s;
}
.form-group input:focus,
.form-group select:focus {
    border-color: #1D9E75;
    box-shadow: 0 0 0 3px rgba(29,158,117,0.12);
}
.form-group input.error,
.form-group select.error {
    border-color: #E24B4A;
}

/* ── Submit button ─────────────────────────────────────── */
.btn-submit {
    display: block;
    width: 100%;
    padding: 11px;
    background: #0d3b66;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 14.5px;
    font-weight: 600;
    font-family: inherit;
    cursor: pointer;
    margin-top: 8px;
    letter-spacing: 0.01em;
    transition: background 0.15s;
}
.btn-submit:hover { background: #0a2f52; }

.footer-link {
    text-align: center;
    margin-top: 16px;
    font-size: 13px;
    color: #6b7280;
}
.footer-link a { color: #1D9E75; text-decoration: none; font-weight: 600; }
.footer-link a:hover { text-decoration: underline; }
</style>
</head>
<body>

<!-- ── Navigation ──────────────────────────────────────── -->
<nav class="topbar">
    <span class="brand">&#128188; Employee Portal</span>
    <a href="index.jsp"      class="active">Register</a>
    <a href="listEmployees">All Employees</a>
</nav>

<!-- ── Main ────────────────────────────────────────────── -->
<main>
  <div class="card">
    <h1 class="card-title">New Employee Registration</h1>
    <p class="card-subtitle">Fill in all fields to register a new employee in the system.</p>

    <%-- Error message (set by EmployeeServlet on validation failure) --%>
    <%
      String errorMsg = (String) request.getAttribute("error");
      if (errorMsg != null && !errorMsg.isEmpty()) {
    %>
    <div class="error-box">&#9888;&nbsp;<%= errorMsg %></div>
    <%
      }

      // Helper: repopulate form fields if the servlet bounced back
      String pName  = (String) request.getAttribute("prevName");       if(pName  == null) pName  = "";
      String pEmail = (String) request.getAttribute("prevEmail");      if(pEmail == null) pEmail = "";
      String pPhone = (String) request.getAttribute("prevPhone");      if(pPhone == null) pPhone = "";
      String pDept  = (String) request.getAttribute("prevDepartment"); if(pDept  == null) pDept  = "";
      String pSal   = (String) request.getAttribute("prevSalary");     if(pSal   == null) pSal   = "";
      boolean hasError = (errorMsg != null && !errorMsg.isEmpty());
    %>

    <%-- Form POSTs to EmployeeServlet --%>
    <form action="registerEmployee" method="post" novalidate>

      <div class="grid-2">
        <div class="form-group">
          <label for="name">Full Name</label>
          <input type="text" id="name" name="name"
                 placeholder="e.g. Priya Sharma"
                 value="<%= pName %>"
                 class="<%= hasError && pName.isEmpty() ? \"error\" : \"\" %>"
                 required>
        </div>

        <div class="form-group">
          <label for="department">Department</label>
          <select id="department" name="department"
                  class="<%= hasError && pDept.isEmpty() ? \"error\" : \"\" %>"
                  required>
            <option value="">-- Select --</option>
            <%
              String[] depts = {"Engineering","Marketing","Finance",
                                "Human Resources","Operations","Sales","IT","Legal"};
              for (String d : depts) {
                String sel = d.equals(pDept) ? "selected" : "";
            %>
              <option value="<%= d %>" <%= sel %>><%= d %></option>
            <% } %>
          </select>
        </div>
      </div>

      <div class="form-group">
        <label for="email">Email Address</label>
        <input type="email" id="email" name="email"
               placeholder="e.g. priya@company.com"
               value="<%= pEmail %>"
               required>
      </div>

      <div class="grid-2">
        <div class="form-group">
          <label for="phone">Phone Number</label>
          <input type="tel" id="phone" name="phone"
                 placeholder="10-digit mobile number"
                 value="<%= pPhone %>"
                 pattern="[6-9][0-9]{9}"
                 required>
        </div>

        <div class="form-group">
          <label for="salary">Salary (&#x20B9; INR)</label>
          <input type="number" id="salary" name="salary"
                 placeholder="e.g. 60000"
                 value="<%= pSal %>"
                 min="0" step="100" required>
        </div>
      </div>

      <button type="submit" class="btn-submit">Register Employee</button>
    </form>

    <p class="footer-link">
      <a href="listEmployees">&#128203; View all registered employees</a>
    </p>
  </div>
</main>
</body>
</html>
