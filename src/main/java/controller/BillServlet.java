package controller;

import dao.ReservationDAO;
import model.Reservation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.temporal.ChronoUnit;

@WebServlet("/bill")
public class BillServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("reservationId");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.getWriter().print("Reservation ID required");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException ex) {
            response.getWriter().print("Invalid Reservation ID");
            return;
        }

        Reservation r = reservationDAO.getReservationForBill(id);
        if (r == null) {
            response.getWriter().print("Reservation not found");
            return;
        }

        if (r.getCheckIn() == null || r.getCheckOut() == null) {
            response.getWriter().print("Check-in / Check-out dates missing");
            return;
        }

        long nights = ChronoUnit.DAYS.between(r.getCheckIn(), r.getCheckOut());
        if (nights < 1) nights = 1; // safety

        double total = nights * r.getRatePerNight();

        request.setAttribute("reservation", r);
        request.setAttribute("nights", nights);
        request.setAttribute("total", total);

        request.getRequestDispatcher("/view/bill.jsp").forward(request, response);
    }
}