<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Account</title>
    <style>
        :root {
            --primary: #6c5ce7;
            --secondary: #a29bfe;
            --dark: #2d3436;
            --darker: #1e272e;
            --light: #f5f6fa;
            --danger: #ff7675;
            --warning: #fdcb6e;
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
            align-items: center;
            min-height: 100vh;
            background-image: radial-gradient(circle at 30% 70%, rgba(255, 118, 117, 0.1) 0%, rgba(30, 39, 46, 1) 90%);
        }
        .container {
            width: 500px;
            padding: 40px;
            background: var(--darker);
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 118, 117, 0.2);
            text-align: center;
        }
        .warning-icon {
            font-size: 60px;
            color: var(--warning);
            margin-bottom: 20px;
        }
        h2 {
            margin-bottom: 20px;
            color: var(--light);
        }
        p {
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 30px;
            line-height: 1.6;
        }
        .btn-group {
            display: flex;
            gap: 15px;
            justify-content: center;
        }
        .btn {
            padding: 12px 25px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
        }
        .btn-delete {
            background: var(--danger);
            color: white;
            border: none;
        }
        .btn-delete:hover {
            background: #e84393;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 118, 117, 0.3);
        }
        .btn-cancel {
            background: var(--darker);
            color: var(--light);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        .btn-cancel:hover {
            background: rgba(255, 255, 255, 0.05);
            transform: translateY(-2px);
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="container">
        <div class="warning-icon">
            <i class="fas fa-exclamation-triangle"></i>
        </div>
        <h2>Delete Your Account</h2>
        <p>
            This action will permanently delete all your notes and account information. 
            You won't be able to recover any of your data once deleted.
        </p>
        <form action="deleteAccount" method="post" style="display: inline;">
            <div class="btn-group">
                <button type="submit" class="btn btn-delete">
                    <i class="fas fa-trash"></i> Confirm Delete
                </button>
                <a href="notes" class="btn btn-cancel">
                    <i class="fas fa-times"></i> Cancel
                </a>
            </div>
        </form>
    </div>
</body>
</html>