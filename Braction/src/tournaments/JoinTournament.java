package tournaments;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sql.JDBCBracketStuff;

/**
 * Servlet implementation class JoinTournament
 */
@WebServlet("/JoinTournament")
public class JoinTournament extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JoinTournament() {
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
		String code = request.getParameter("tournamentID");
		try {
			userID = Integer.parseInt((String)session.getAttribute("userID"));
		} catch (NumberFormatException | NullPointerException e) {
			success = false;
		}
		int bracketID = -1;
		if (success && userID != -1 && code != null && !code.equals("")) {
			bracketID = JDBCBracketStuff.addUserToBracket(userID, code);
		} else {
			success = false;
		}
		String message = "";
		if (bracketID == -1) {
			message ="an error occured!";
		} else if (bracketID == -2) {
			message = "you are already in this tournament!";
		} else if (bracketID >= 0) {
			message = Integer.toString(bracketID);
		}
		PrintWriter out = response.getWriter();
		out.println(message);
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
