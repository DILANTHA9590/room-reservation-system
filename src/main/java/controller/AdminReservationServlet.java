package controller;

import dao.ReservationDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/reservations")
public class AdminReservationServlet extends HttpServlet {

    private final ReservationDAO dao = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ security check
        User u = (User) request.getSession().getAttribute("loggedUser");
        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/view/login.jsp");
            return;
        }

        // ✅ allow ADMIN + RECEPTIONIST
        String role = u.getRole();
        boolean isAdmin = "ADMIN".equalsIgnoreCase(role);
        boolean isReceptionist = "RECEPTIONIST".equalsIgnoreCase(role);

        if (!isAdmin && !isReceptionist) {
            response.getWriter().print("403 - Access Denied");
            return;
        }

        // ✅ cancel action (ADMIN only)
        String cancelId = request.getParameter("cancel");
        if (cancelId != null) {
            if (!isAdmin) {
                response.getWriter().print("403 - Only ADMIN can cancel reservations");
                return;
            }

            dao.cancelReservation(Integer.parseInt(cancelId));
            response.sendRedirect(request.getContextPath() + "/admin/reservations");
            return;
        }

        request.setAttribute("reservations", dao.getAllReservations());
        request.getRequestDispatcher("/admin/reservations.jsp").forward(request, response);
    }
}