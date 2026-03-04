package controller;

import dao.ReservationCreateDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/reservations/update")
public class UpdateReservationServlet extends HttpServlet {

    private final ReservationCreateDAO reservationDAO = new ReservationCreateDAO();

    private boolean allowed(User u) {
        return u != null && ("ADMIN".equalsIgnoreCase(u.getRole()) || "RECEPTIONIST".equalsIgnoreCase(u.getRole()));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User u = (User) request.getSession().getAttribute("loggedUser");
        if (!allowed(u)) {
            response.sendRedirect(request.getContextPath() + "/view/login.jsp");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));

        String guestName = request.getParameter("guestName");
        String address = request.getParameter("address");
        String contactNo = request.getParameter("contactNo");
        int roomTypeId = Integer.parseInt(request.getParameter("roomTypeId"));

        LocalDate checkIn = LocalDate.parse(request.getParameter("checkIn"));
        LocalDate checkOut = LocalDate.parse(request.getParameter("checkOut"));

        reservationDAO.updateReservation(
                id, guestName, address, contactNo,
                roomTypeId, checkIn, checkOut
        );

        response.sendRedirect(request.getContextPath() + "/admin/reservations");
    }
}