<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        :root {
            --primary: #6c5ce7;
            --secondary: #a29bfe;
            --dark: #2d3436;
            --darker: #1e272e;
            --light: #f5f6fa;
            --danger: #ff7675;
            --success: #00b894;
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
            background-image: radial-gradient(circle at 10% 20%, rgba(108, 92, 231, 0.1) 0%, rgba(30, 39, 46, 1) 90%);
        }
        .container {
            width: 400px;
            padding: 40px;
            background: var(--darker);
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            backdrop-filter: blur(10px);
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
            position: relative;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: var(--secondary);
            font-size: 14px;
            font-weight: 500;
        }
        input {
            width: 100%;
            padding: 12px 15px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 8px;
            color: var(--light);
            font-size: 15px;
            transition: all 0.3s ease;
        }
        input:focus {
            outline: none;
            border-color: var(--primary);
            background: rgba(108, 92, 231, 0.1);
        }
        button {
            width: 100%;
            padding: 14px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
        }
        button:hover {
            background: #5649d6;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(108, 92, 231, 0.3);
        }
        .error {
            color: var(--danger);
            margin: 15px 0;
            text-align: center;
            font-size: 14px;
        }
        .signup-link {
            text-align: center;
            margin-top: 25px;
            font-size: 14px;
        }
        .signup-link a {
            color: var(--secondary);
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .signup-link a:hover {
            color: var(--primary);
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Welcome Back</h2>
        <% if (request.getParameter("error") != null) { %>
            <div class="error">Invalid username or password</div>
        <% } %>
        <form action="login" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit">Sign In</button>
        </form>
        <div class="signup-link">
            New here? <a href="signup.jsp">Create an account</a>
        </div>
    </div>
</body>
</html>