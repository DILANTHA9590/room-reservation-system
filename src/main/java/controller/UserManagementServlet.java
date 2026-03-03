package controller;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class UserManagementServlet extends HttpServlet {

    private final UserDAO dao = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String deleteId = request.getParameter("delete");
        if (deleteId != null) {
            int id = Integer.parseInt(deleteId);

            User logged = (User) request.getSession().getAttribute("loggedUser");
            if (logged != null && logged.getUserId() == id) {
                request.setAttribute("error", "You cannot delete your own account.");
            } else {
                dao.deleteUserById(id);
            }
        }

        List<User> users = dao.getAllUsers();
        request.setAttribute("users", users);

        request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (dao.emailExists(email)) {
            request.setAttribute("error", "Email already exists. Try another.");
            request.setAttribute("users", dao.getAllUsers());
            request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);

        dao.saveUser(user);

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}