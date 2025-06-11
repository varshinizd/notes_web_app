import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/deleteAccount")
public class DeleteAccountServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("user_id");

        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/notesapp", "root", "1234")) {

            // Step 1: Delete user's notes
            PreparedStatement deleteNotes = conn.prepareStatement("DELETE FROM notes WHERE user_id = ?");
            deleteNotes.setInt(1, userId);
            deleteNotes.executeUpdate();

            // Step 2: Delete the user
            PreparedStatement deleteUser = conn.prepareStatement("DELETE FROM users WHERE id = ?");
            deleteUser.setInt(1, userId);
            deleteUser.executeUpdate();

            // Step 3: Invalidate session
            session.invalidate();

            response.sendRedirect("signup.jsp?account_deleted=1");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=account_delete_error");
        }
    }
}
