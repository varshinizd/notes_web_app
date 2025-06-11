import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.*;

@WebServlet("/notes")
public class NotesListServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int userId = (Integer) session.getAttribute("user_id");
        List<String[]> notes = new ArrayList<>(); // [id, title, content, mood, color]
        
        try (Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/notesapp", "root", "1234")) {
            
            PreparedStatement stmt = conn.prepareStatement(
                "SELECT id, title, content FROM notes WHERE user_id = ?");
            stmt.setInt(1, userId);
            
            ResultSet rs = stmt.executeQuery();
            MoodAnalyzer moodAnalyzer = new MoodAnalyzer();
            
            while (rs.next()) {
                String[] note = new String[5];
                note[0] = rs.getString("id");
                note[1] = rs.getString("title");
                note[2] = rs.getString("content");
                note[3] = moodAnalyzer.detectMood(note[2]); // Detect mood
                note[4] = moodAnalyzer.getMoodColor(note[3]); // Get color
                notes.add(note);
            }
            
            request.setAttribute("notes", notes);
            request.getRequestDispatcher("/notes.jsp").forward(request, response);
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=notes_error");
        }
    }
}



class MoodAnalyzer {
    public String detectMood(String text) {
        if (text == null || text.isEmpty()) return "neutral";

        text = text.toLowerCase();

        String happyRegex = "\\b(happy|joy|excited|great|awesome|wonderful|fantastic|amazing|grateful|beautiful|bliss|delight|satisfaction|laugh|glee|smile|fun|smiling|cheerful|ecstatic)\\b";
        String angryRegex = "\\b(angry|mad|hate|annoyed|furious|upset|rage|irritated|frustrated|livid|resentment|wrath|grudge|outburst|temper|infuriated|snapped)\\b";
        String sadRegex = "\\b(sad|pain|tears|loss|hurt|heartbreak|sorrow|gloom|misery|loneliness|despair|crying|depressed|hopeless)\\b";
        String romanticRegex = "\\b(love|passion|desire|affection|intimacy|crush|heartbeat|chemistry|embrace|warmth|romantic|caring|darling|sweetheart|butterflies)\\b";

        if (Pattern.compile(happyRegex).matcher(text).find()) return "happy";
        else if (Pattern.compile(angryRegex).matcher(text).find()) return "angry";
        else if (Pattern.compile(sadRegex).matcher(text).find()) return "sad";
        else if (Pattern.compile(romanticRegex).matcher(text).find()) return "romantic";

        return "neutral";
    }

    public String getMoodColor(String mood) {
        if (mood == null) return "#6C5CE7";
        
        switch (mood.toLowerCase()) {
            case "happy":    return "#F9D71C"; // Yellow
            case "angry":    return "#E74C3C"; // Red
            case "sad":      return "#3498DB"; // Blue
            case "romantic": return "#FF9FF3"; // Pink
            case "neutral":  return "#95A5A6"; // Gray
            default:         return "#6C5CE7"; // Default purple
        }
    }
}