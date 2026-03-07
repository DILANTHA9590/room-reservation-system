package controller;

import dao.PaymentDAO;
import dao.ReservationDAO;
import model.Payment;
import model.Reservation;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/payments/create")
public class PaymentServlet extends HttpServlet {

    private final ReservationDAO reservationDAO = new ReservationDAO();
    private final PaymentDAO paymentDAO = new PaymentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User u = (User) request.getSession().getAttribute("loggedUser");
        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/view/login.jsp");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));

        // reservation details fetch (simple)
        Reservation r = reservationDAO.getReservationById(id);
        if (r == null) {
            response.getWriter().print("Reservation not found");
            return;
        }

        request.setAttribute("reservation", r);
        request.getRequestDispatcher("/view/payment-create.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User u = (User) request.getSession().getAttribute("loggedUser");
        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/view/login.jsp");
            return;
        }

        int reservationId = Integer.parseInt(request.getParameter("reservationId"));
        double amount = Double.parseDouble(request.getParameter("amount"));
        String method = request.getParameter("method");
        String note = request.getParameter("note");

        Payment p = new Payment();
        p.setReservationId(reservationId);
        p.setAmount(amount);
        p.setMethod(method);
        p.setNote(note);

        boolean ok = paymentDAO.addPayment(p);
        if (ok) paymentDAO.markReservationPaid(reservationId);

        // redirect back to all reservations (role-based)
        if ("ADMIN".equalsIgnoreCase(u.getRole())) {
            response.sendRedirect(request.getContextPath() + "/admin/reservations");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/reservations");
        }
    }
}