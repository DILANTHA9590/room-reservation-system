package controller;

import dao.ReportDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/reports")
public class AdminReportServlet extends HttpServlet {

    private final ReportDAO dao = new ReportDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User u = (User) request.getSession().getAttribute("loggedUser");
        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/view/login.jsp");
            return;
        }
        if (!"ADMIN".equalsIgnoreCase(u.getRole())) {
            response.getWriter().print("403 - ADMIN only");
            return;
        }

        request.setAttribute("totalRoomTypes", dao.totalRoomTypes());
        request.setAttribute("totalUsers", dao.totalUsers());
        request.setAttribute("totalReservations", dao.totalReservations());
        request.setAttribute("cancelledReservations", dao.cancelledReservations());

     // Handle exception safely in case the payments table is not available in the database
        try {
            request.setAttribute("totalPayments", dao.totalPayments());
            request.setAttribute("totalRevenue", dao.totalRevenue());
        } catch (Exception ex) {
            request.setAttribute("totalPayments", 0);
            request.setAttribute("totalRevenue", 0.0);
        }

        request.getRequestDispatcher("/admin/reports.jsp").forward(request, response);
    }
}