import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/deleteNote")
public class DeleteNoteServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("user_id");
        int noteId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/notesapp", "root", "1234")) {

            PreparedStatement stmt = conn.prepareStatement(
                    "DELETE FROM notes WHERE id = ? AND user_id = ?");
            stmt.setInt(1, noteId);
            stmt.setInt(2, userId);

            stmt.executeUpdate();

            response.sendRedirect("notes");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=delete_error");
        }
    }
}
