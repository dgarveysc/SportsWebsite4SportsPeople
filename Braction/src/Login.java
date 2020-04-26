import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
​
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
​
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				String username = request.getParameter("Username"); System.out.println(username);
				String password = request.getParameter("Password"); System.out.println(password);
				String next = "/login-sign-up.jsp";
				PrintWriter out = response.getWriter();
				response.setContentType("text/html");
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
                        // Using sessions 
                        HttpSession session = request.getSession();
                        session.setAttribute("username", username);
                        next = "/profile.jsp";
                        
                        
                        //Send dispatch
						request.setAttribute("loggedIn", "true");
						//request.setAttribute("username", username);
						RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
						dispatch.forward(request, response);*/
					}
					else {
						//If username and password aren't in database, throw an error
						request.setAttribute("loginError", "\tUsername and password combination is not registered.");
						next = "/login-sign-up.jsp";
						
						//Send dispatch
						RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
						dispatch.forward(request, response);
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
    }
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
​
}