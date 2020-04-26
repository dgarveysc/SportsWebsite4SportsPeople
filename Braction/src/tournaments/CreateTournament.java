package tournaments;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import sql.BracketIdCodePair;
import sql.JDBCBracketStuff;

/**
 * Servlet implementation class CreateTournament
 */
@WebServlet("/CreateTournament")
public class CreateTournament extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateTournament() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session =request.getSession();
		int userID = -1;
		int gameType = -1;
		
		boolean success = true;
		String name = request.getParameter("tournamentName");
		try {
			userID = Integer.parseInt((String)session.getAttribute("userID"));
			gameType = Integer.parseInt(request.getParameter("gameType"));
		} catch (NumberFormatException | NullPointerException e) {
			success = false;
		}
		BracketIdCodePair b = null;
		if (success && userID != -1 && gameType != -1) {
			b = JDBCBracketStuff.createBracket(userID, name, gameType);
			if (b == null)  {
				success = false;
			}
		} else {
			success = false;
		}
		String[] messages = new String[2];
		if(success) {
			messages[0] = b.getBracketCode();
			messages[1] = Integer.toString(b.getBracketID());
		} else {
			messages[0] = "error creating tournament";
			messages[1] = "";
		}
		Gson gson = new Gson();
		PrintWriter out = response.getWriter();
		out.println(gson.toJson(messages));
		out.flush();
		out.close();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
