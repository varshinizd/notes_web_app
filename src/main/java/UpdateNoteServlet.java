import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/updateNote")
public class UpdateNoteServlet extends HttpServlet {

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
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/notesapp", "root", "1234")) {

            PreparedStatement stmt = conn.prepareStatement(
                    "UPDATE notes SET title = ?, content = ? WHERE id = ? AND user_id = ?");
            stmt.setString(1, title);
            stmt.setString(2, content);
            stmt.setInt(3, noteId);
            stmt.setInt(4, userId);

            stmt.executeUpdate();

            response.sendRedirect("notes");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=update_error");
        }
    }
}
