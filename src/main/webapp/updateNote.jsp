<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Note</title>
    <style>
        :root {
            --primary: #6c5ce7;
            --secondary: #a29bfe;
            --dark: #2d3436;
            --darker: #1e272e;
            --light: #f5f6fa;
            --danger: #ff7675;
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
            display: flex;
            justify-content: center;
            min-height: 100vh;
            padding: 40px;
            background-image: radial-gradient(circle at 20% 70%, rgba(108, 92, 231, 0.1) 0%, rgba(30, 39, 46, 1) 90%);
        }
        .container {
            width: 100%;
            max-width: 700px;
            padding: 40px;
            background: var(--darker);
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.05);
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: var(--light);
            font-weight: 600;
            letter-spacing: 1px;
        }
        .form-group {
            margin-bottom: 25px;
        }
        label {
            display: block;
            margin-bottom: 10px;
            color: var(--secondary);
            font-size: 15px;
            font-weight: 500;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 15px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            color: var(--light);
            font-size: 16px;
            transition: all 0.3s ease;
        }
        input[type="text"]:focus, textarea:focus {
            outline: none;
            border-color: var(--primary);
            background: rgba(108, 92, 231, 0.1);
        }
        textarea {
            min-height: 200px;
            resize: vertical;
        }
        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 20px;
        }
        .btn {
            padding: 14px 25px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            text-align: center;
        }
        .btn-save {
            background: var(--primary);
            color: white;
            border: none;
            flex: 1;
        }
        .btn-save:hover {
            background: #5649d6;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(108, 92, 231, 0.3);
        }
        .btn-back {
            background: var(--darker);
            color: var(--light);
            border: 1px solid rgba(255, 255, 255, 0.1);
            flex: 1;
        }
        .btn-back:hover {
            background: rgba(255, 255, 255, 0.05);
            transform: translateY(-2px);
        }
        .error {
            color: var(--danger);
            margin: 15px 0;
            text-align: center;
            font-size: 14px;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="container">
        <h2>Edit Note</h2>
        <% if (request.getParameter("error") != null) { %>
            <div class="error">Error updating note. Please try again.</div>
        <% } %>
        <form action="updateNote" method="post">
            <input type="hidden" name="id" value="<%= request.getParameter("id") %>">
            <div class="form-group">
                <label for="title">Title</label>
                <input type="text" id="title" name="title" value="<%= request.getParameter("title") %>" required>
            </div>
            <div class="form-group">
                <label for="content">Content</label>
                <textarea id="content" name="content" required><%= request.getParameter("content") %></textarea>
            </div>
            <div class="btn-group">
                <button type="submit" class="btn btn-save">
                    <i class="fas fa-save"></i> Update Note
                </button>
                <a href="notes" class="btn btn-back">
                    <i class="fas fa-arrow-left"></i> Cancel
                </a>
            </div>
        </form>
    </div>
</body>
</html>