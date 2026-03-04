package controller;

import dao.ReservationCreateDAO;
import dao.RoomTypeDAO;
import model.Reservation;
import model.RoomType;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/reservations/edit")
public class EditReservationServlet extends HttpServlet {

    private final ReservationCreateDAO reservationDAO = new ReservationCreateDAO();
    private final RoomTypeDAO roomTypeDAO = new RoomTypeDAO();

    private boolean allowed(User u) {
        return u != null && ("ADMIN".equalsIgnoreCase(u.getRole()) || "RECEPTIONIST".equalsIgnoreCase(u.getRole()));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User u = (User) request.getSession().getAttribute("loggedUser");
        if (!allowed(u)) {
            response.sendRedirect(request.getContextPath() + "/view/login.jsp");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));

        Reservation reservation = reservationDAO.getReservationById(id);

        List<RoomType> roomTypes = roomTypeDAO.getAllRoomTypes();

        request.setAttribute("reservation", reservation);
        request.setAttribute("roomTypes", roomTypes);

        request.getRequestDispatcher("/view/reservation-edit.jsp").forward(request, response);
    }
}