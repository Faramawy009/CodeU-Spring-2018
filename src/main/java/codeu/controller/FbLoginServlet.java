package codeu.controller;

import codeu.model.data.User;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class FbLoginServlet extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
					throws IOException, ServletException {
		request.getRequestDispatcher("/WEB-INF/view/fblogin.jsp").forward(request, response);
	}

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
					throws IOException, ServletException {
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		request.setAttribute("username",username);
		request.setAttribute("email",email);
		request.getRequestDispatcher("/WEB-INF/view/fblogin.jsp").forward(request, response);
	}
}
