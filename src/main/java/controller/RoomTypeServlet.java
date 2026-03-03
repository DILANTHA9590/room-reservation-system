package controller;

import dao.RoomTypeDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/room-types")
public class RoomTypeServlet extends HttpServlet {

    private final RoomTypeDAO dao = new RoomTypeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // security
        User u = (User) request.getSession().getAttribute("loggedUser");
        if (u == null) {
            response.sendRedirect(request.getContextPath() + "/view/login.jsp");
            return;
        }
        if (!"ADMIN".equalsIgnoreCase(u.getRole())) {
            response.getWriter().print("403 - ADMIN only");
            return;
        }

        // delete action
        String del = request.getParameter("delete");
        if (del != null) {
            int id = Integer.parseInt(del);
            dao.deleteRoomType(id);
            response.sendRedirect(request.getContextPath() + "/admin/room-types");
            return;
        }

        request.setAttribute("roomTypes", dao.getAllRoomTypes());
        request.getRequestDispatcher("/admin/room-types.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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

        String name = request.getParameter("name");
        String rateStr = request.getParameter("rate");

        if (name == null || name.trim().isEmpty() || rateStr == null || rateStr.trim().isEmpty()) {
            request.setAttribute("error", "Name and rate are required.");
            request.setAttribute("roomTypes", dao.getAllRoomTypes());
            request.getRequestDispatcher("/admin/room-types.jsp").forward(request, response);
            return;
        }

        double rate = Double.parseDouble(rateStr);
        dao.addRoomType(name.trim(), rate);

        response.sendRedirect(request.getContextPath() + "/admin/room-types");
    }
}