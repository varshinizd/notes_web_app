<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Notes</title>
    <style>
        :root {
            --primary: #6c5ce7;
            --secondary: #a29bfe;
            --dark: #2d3436;
            --darker: #1e272e;
            --light: #f5f6fa;
            --danger: #ff7675;
            --success: #00b894;
            --warning: #fdcb6e;

            /* Mood colors */
            --happy: #F9D71C;
            --angry: #E74C3C;
            --sad: #3498DB;
            --romantic: #FF9FF3;
            --neutral: #95A5A6;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: var(--dark);
            color: var(--light);
            min-height: 100vh;
            padding: 40px;
            background-image: radial-gradient(circle at 20% 30%, rgba(108, 92, 231, 0.1) 0%, rgba(30, 39, 46, 1) 90%);
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
            padding-bottom: 20px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .header h1 {
            font-weight: 600;
            color: var(--light);
            font-size: 28px;
        }

        .header h1 span {
            color: var(--secondary);
        }

        .btn-group {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn i {
            font-size: 16px;
        }

        .btn-add {
            background: var(--primary);
            color: white;
        }

        .btn-add:hover {
            background: #5649d6;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(108, 92, 231, 0.3);
        }

        .user-menu {
            position: relative;
            display: inline-block;
        }

        .btn-user {
            background: var(--darker);
            color: var(--light);
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding-right: 35px;
            position: relative;
        }

        .btn-user:hover {
            background: rgba(255, 255, 255, 0.05);
            transform: translateY(-2px);
        }

        .btn-user::after {
            content: "▼";
            font-size: 10px;
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
        }

        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            background: var(--darker);
            min-width: 200px;
            border-radius: 8px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.3);
            border: 1px solid rgba(255, 255, 255, 0.1);
            z-index: 1;
            overflow: hidden;
        }

        .user-menu:hover .dropdown-content {
            display: block;
        }

        .dropdown-item {
            color: var(--light);
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            transition: all 0.3s ease;
        }

        .dropdown-item:hover {
            background: rgba(255, 255, 255, 0.05);
            color: var(--primary);
        }

        .dropdown-item.logout {
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        .dropdown-item.delete {
            color: var(--danger);
        }

        .dropdown-item.delete:hover {
            background: rgba(255, 118, 117, 0.1);
            color: var(--danger);
        }

        .note-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
        }

        .note {
            background: var(--darker);
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            border: 2px solid transparent;
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            height: 100%;
            position: relative;
        }

        .note:hover {
            transform: translateY(-5px);
        }

        /* Mood-specific clean borders */
        .happy { border-color: var(--happy); }
        .angry { border-color: var(--angry); }
        .sad { border-color: var(--sad); }
        .romantic { border-color: var(--romantic); }
        .neutral { border-color: var(--neutral); }

        /* Mood indicator */
        .mood-indicator {
            position: absolute;
            top: 15px;
            right: 15px;
            width: 12px;
            height: 12px;
            border-radius: 50%;
        }

        .happy .mood-indicator { background: var(--happy); }
        .angry .mood-indicator { background: var(--angry); }
        .sad .mood-indicator { background: var(--sad); }
        .romantic .mood-indicator { background: var(--romantic); }
        .neutral .mood-indicator { background: var(--neutral); }

        .mood-label {
            position: absolute;
            bottom: 15px;
            right: 15px;
            font-size: 12px;
            text-transform: capitalize;
            padding: 3px 8px;
            border-radius: 12px;
        }

        .happy .mood-label { color: var(--happy); background: rgba(249, 215, 28, 0.1); }
        .angry .mood-label { color: var(--angry); background: rgba(231, 76, 60, 0.1); }
        .sad .mood-label { color: var(--sad); background: rgba(52, 152, 219, 0.1); }
        .romantic .mood-label { color: var(--romantic); background: rgba(255, 159, 243, 0.1); }
        .neutral .mood-label { color: var(--neutral); background: rgba(149, 165, 166, 0.1); }

        .note h3 {
            margin-top: 0;
            margin-bottom: 15px;
            color: var(--light);
            font-size: 20px;
            font-weight: 600;
        }

        .note p {
            color: rgba(255, 255, 255, 0.7);
            line-height: 1.6;
            margin-bottom: 20px;
            flex-grow: 1;
        }

        .note-actions {
            display: flex;
            gap: 10px;
            margin-top: auto;
        }

        .btn-edit {
            background: rgba(108, 92, 231, 0.1);
            color: var(--secondary);
            border: 1px solid rgba(108, 92, 231, 0.3);
            padding: 8px 15px;
            border-radius: 6px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .btn-edit:hover {
            background: rgba(108, 92, 231, 0.2);
            color: var(--light);
        }

        .btn-delete {
            background: rgba(255, 118, 117, 0.1);
            color: var(--danger);
            border: 1px solid rgba(255, 118, 117, 0.3);
            padding: 8px 15px;
            border-radius: 6px;
            font-size: 14px;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .btn-delete:hover {
            background: rgba(255, 118, 117, 0.2);
            color: var(--light);
        }

        .empty-state {
            grid-column: 1 / -1;
            text-align: center;
            padding: 60px 20px;
            color: rgba(255, 255, 255, 0.5);
        }

        .empty-state h3 {
            font-size: 24px;
            margin-bottom: 15px;
            color: var(--light);
        }

        .empty-state p {
            margin-bottom: 25px;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="header">
        <h1>My <span>Notes</span></h1>
        <div class="btn-group">
            <a href="addNote.jsp" class="btn btn-add">
                <i class="fas fa-plus"></i> New Note
            </a>
            <div class="user-menu">
                <button class="btn btn-user">
                    <i class="fas fa-user"></i> <%= session.getAttribute("username") %>
                </button>
                <div class="dropdown-content">
                    <a href="logout" class="dropdown-item logout">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                    <a href="deleteAccount.jsp" class="dropdown-item delete">
                        <i class="fas fa-trash"></i> Delete Account
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="note-container">
        <% List<String[]> notes = (List<String[]>) request.getAttribute("notes");
           if (notes != null && !notes.isEmpty()) {
               for (String[] note : notes) { %>
                <div class="note <%= note[3] %>">
                    <div class="mood-indicator"></div>
                    <h3><%= note[1] %></h3>
                    <p><%= note[2] %></p>
                    <div class="mood-label"><%= note[3] %></div>
                    <div class="note-actions">
                        <a href="updateNote.jsp?id=<%= note[0] %>&title=<%= java.net.URLEncoder.encode(note[1], "UTF-8") %>&content=<%= java.net.URLEncoder.encode(note[2], "UTF-8") %>"
                           class="btn-edit">
                            <i class="fas fa-edit"></i> Edit
                        </a>
                        <form action="deleteNote" method="post" style="display: inline;">
                            <input type="hidden" name="id" value="<%= note[0] %>">
                            <button type="submit" class="btn-delete">
                                <i class="fas fa-trash"></i> Delete
                            </button>
                        </form>
                    </div>
                </div>
        <%   }
           } else { %>
            <div class="empty-state">
                <h3>No Notes Found</h3>
                <p>You don't have any notes yet. Create your first note!</p>
                <a href="addNote.jsp" class="btn btn-add">
                    <i class="fas fa-plus"></i> Create Note
                </a>
            </div>
        <% } %>
    </div>
</body>
</html>
