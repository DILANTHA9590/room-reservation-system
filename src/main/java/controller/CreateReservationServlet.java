package controller;

import dao.RoomTypeDAO;
import dao.ReservationCreateDAO;
import model.RoomType;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/reservations/create")
public class CreateReservationServlet extends HttpServlet {

    private final RoomTypeDAO roomTypeDAO = new RoomTypeDAO();
    private final ReservationCreateDAO reservationDAO = new ReservationCreateDAO();

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

        List<RoomType> roomTypes = roomTypeDAO.getAllRoomTypes();
        request.setAttribute("roomTypes", roomTypes);
        request.getRequestDispatcher("/view/reservation-create.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User u = (User) request.getSession().getAttribute("loggedUser");
        if (!allowed(u)) {
            response.sendRedirect(request.getContextPath() + "/view/login.jsp");
            return;
        }

        // basic validation
        String reservationNo = request.getParameter("reservationNo");
        String guestName = request.getParameter("guestName");
        String address = request.getParameter("address");
        String contactNo = request.getParameter("contactNo");
        String roomTypeIdStr = request.getParameter("roomTypeId");
        String checkInStr = request.getParameter("checkIn");
        String checkOutStr = request.getParameter("checkOut");

        if (reservationNo == null || reservationNo.isBlank() ||
            guestName == null || guestName.isBlank() ||
            address == null || address.isBlank() ||
            contactNo == null || contactNo.isBlank() ||
            roomTypeIdStr == null || roomTypeIdStr.isBlank() ||
            checkInStr == null || checkInStr.isBlank() ||
            checkOutStr == null || checkOutStr.isBlank()) {

            request.setAttribute("error", "Please fill all fields.");
            doGet(request, response);
            return;
        }

        LocalDate checkIn = LocalDate.parse(checkInStr);
        LocalDate checkOut = LocalDate.parse(checkOutStr);

        if (!checkOut.isAfter(checkIn)) {
            request.setAttribute("error", "Check-out date must be after check-in date.");
            doGet(request, response);
            return;
        }

        int roomTypeId = Integer.parseInt(roomTypeIdStr);

        boolean ok = reservationDAO.createReservation(
                reservationNo, guestName, address, contactNo,
                roomTypeId, checkIn, checkOut
        );

        if (!ok) {
            request.setAttribute("error", "Reservation could not be created. Try a different Reservation No.");
            doGet(request, response);
            return;
        }

        // redirect to correct dashboard by role
        if ("ADMIN".equalsIgnoreCase(u.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/staff/dashboard.jsp");
        }
    }
}