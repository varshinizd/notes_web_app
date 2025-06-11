<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
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
            align-items: center;
            min-height: 100vh;
            background-image: radial-gradient(circle at 50% 50%, rgba(255, 118, 117, 0.1) 0%, rgba(30, 39, 46, 1) 90%);
        }
        .container {
            width: 500px;
            padding: 40px;
            background: var(--darker);
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            text-align: center;
            border: 1px solid rgba(255, 118, 117, 0.2);
        }
        h2 {
            color: var(--danger);
            margin-bottom: 20px;
            font-size: 28px;
        }
        .error-icon {
            font-size: 60px;
            color: var(--danger);
            margin-bottom: 20px;
        }
        p {
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 30px;
            font-size: 18px;
            line-height: 1.6;
        }
        .btn {
            padding: 12px 25px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        .btn:hover {
            background: #5649d6;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(108, 92, 231, 0.3);
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="container">
        <div class="error-icon">
            <i class="fas fa-exclamation-triangle"></i>
        </div>
        <h2>Error Occurred</h2>
        <p>
            <%= request.getParameter("message") != null ? 
                request.getParameter("message").replace("_", " ") : 
                "An unexpected error occurred while processing your request" %>
        </p>
        <a href="notes" class="btn">
            <i class="fas fa-arrow-left"></i> Back to Notes
        </a>
    </div>
</body>
</html>