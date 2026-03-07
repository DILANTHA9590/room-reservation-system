package controller;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    // simple admin key (change this)
    private static final String ADMIN_KEY = "ADMIN123";
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    
            throws ServletException, IOException {
    	

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        String adminKey = request.getParameter("adminKey");

        // If user selected ADMIN, require admin key
        if ("ADMIN".equalsIgnoreCase(role)) {
            if (adminKey == null || !ADMIN_KEY.equals(adminKey)) {
                request.setAttribute("error", "Invalid Admin Key. Cannot create ADMIN account.");
                request.getRequestDispatcher("view/register.jsp").forward(request, response);
                return;
            }
        }

        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password); // (demo) later hash
        user.setRole(role);

        UserDAO dao = new UserDAO();

        // email already exists check
        if (dao.emailExists(email)) {
            request.setAttribute("error", "Email already exists. Try another.");
            request.getRequestDispatcher("view/register.jsp").forward(request, response);
            return;
        }

        boolean saved = dao.saveUser(user);

        if (saved) {
            response.sendRedirect(request.getContextPath() + "/view/login.jsp");
        } else {
            request.setAttribute("error", "Registration failed. Try again.");
            request.getRequestDispatcher("view/register.jsp").forward(request, response);
        }
    }
}