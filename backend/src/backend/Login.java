

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
				String username = request.getParameter("Username"); System.out.println(username);
				String password = request.getParameter("Password"); System.out.println(password);
				//String next = "/loginsingup.html";
				PrintWriter out = response.getWriter();
				response.setContentType("text/html"); out.println("<html>");
				Connection connection = null;
				PreparedStatement st = null;
				ResultSet rs = null;
				
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/hw4?user=root&password=root");
					st = connection.prepareStatement("SELECT * FROM userinfo WHERE username=? AND password=?");
					st.setString(1, username);
					st.setString(2, password);
					rs = st.executeQuery();
					if(rs.next()) {
						out.println("<p>Logged in!</p>");
						//Send dispatch
						/*request.setAttribute("loggedIn", "true");
						request.setAttribute("username", username);
						RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
						dispatch.forward(request, response);*/
					}
					else {
						out.println("<p>Login error</p>");
						//If username and password aren't in database, throw an error
						/*request.setAttribute("loginError", "\tUsername and password combination is not registered.");
						next = "/LoginSignup.jsp";
						
						//Send dispatch
						RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
						dispatch.forward(request, response);*/
					}
				} catch (ClassNotFoundException | SQLException e) {
					e.printStackTrace();
				} finally {
					try {
						connection.close();
						st.close();
						rs.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				out.println("</html>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
