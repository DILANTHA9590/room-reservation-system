package controller;

import dao.RoomTypeDAO;
import model.RoomType;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/room-types")
public class RoomTypeServlet extends HttpServlet {

    private final RoomTypeDAO dao = new RoomTypeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // delete action: /admin/room-types?delete=ID
        String deleteId = request.getParameter("delete");
        if (deleteId != null) {
            dao.deleteById(Integer.parseInt(deleteId));
            response.sendRedirect(request.getContextPath() + "/admin/room-types");
            return;
        }

        List<RoomType> roomTypes = dao.getAll();
        request.setAttribute("roomTypes", roomTypes);
        request.getRequestDispatcher("/admin/room-types.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String name = request.getParameter("name");
        String rateStr = request.getParameter("rate");

        double rate = Double.parseDouble(rateStr);

        RoomType rt = new RoomType();
        rt.setName(name);
        rt.setRatePerNight(rate);

        dao.add(rt);

        response.sendRedirect(request.getContextPath() + "/admin/room-types");
    }
}