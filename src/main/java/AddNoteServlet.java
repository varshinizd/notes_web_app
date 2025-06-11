import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/addNote")
public class AddNoteServlet extends HttpServlet {
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int userId = (Integer) session.getAttribute("user_id");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        
        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/notesapp", "root", "1234")) {
            
            PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO notes (user_id, title, content) VALUES (?, ?, ?)");
            stmt.setInt(1, userId);
            stmt.setString(2, title);
            stmt.setString(3, content);
            stmt.executeUpdate();
            
            response.sendRedirect("notes");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("addNote.jsp?error=1");
        }
    }
}