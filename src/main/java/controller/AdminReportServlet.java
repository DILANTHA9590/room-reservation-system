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

    private boolean allowed(User u){
        if(u == null) return false;
        String role = u.getRole();
        return "ADMIN".equalsIgnoreCase(role) || "RECEPTIONIST".equalsIgnoreCase(role);
      
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User u = (User) request.getSession().getAttribute("loggedUser");
        if (!allowed(u)) {
            response.getWriter().print("403 - Access Denied");
            return;
        }

        request.setAttribute("totalRoomTypes", dao.totalRoomTypes());
        request.setAttribute("totalUsers", dao.totalUsers());
        request.setAttribute("totalReservations", dao.totalReservations());
        request.setAttribute("cancelledReservations", dao.cancelledReservations());

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