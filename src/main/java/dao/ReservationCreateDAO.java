package dao;

import util.DBConnection;
import model.Reservation;

import java.sql.*;
import java.time.LocalDate;

public class ReservationCreateDAO {

    public boolean createReservation(String reservationNo, String guestName, String address,
                                     String contactNo, int roomTypeId,
                                     LocalDate checkIn, LocalDate checkOut) {

        String sql = "INSERT INTO reservations " +
                "(reservation_no, guest_name, address, contact_number, room_type_id, check_in, check_out, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, 'BOOKED')";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, reservationNo);
            ps.setString(2, guestName);
            ps.setString(3, address);
            ps.setString(4, contactNo);
            ps.setInt(5, roomTypeId);
            ps.setDate(6, Date.valueOf(checkIn));
            ps.setDate(7, Date.valueOf(checkOut));

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 🔹 GET reservation by ID (Edit ekata)
    public Reservation getReservationById(int id) {

        Reservation r = null;

        String sql = "SELECT * FROM reservations WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                r = new Reservation();

                r.setReservationId(rs.getInt("id"));
                r.setReservationNo(rs.getString("reservation_no"));
                r.setGuestName(rs.getString("guest_name"));
                r.setAddress(rs.getString("address"));
                r.setContactNo(rs.getString("contact_number"));
                r.setCheckIn(rs.getDate("check_in").toLocalDate());
                r.setCheckOut(rs.getDate("check_out").toLocalDate());

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return r;
    }

    // 🔹 UPDATE reservation
    public boolean updateReservation(int id, String guestName, String address,
                                     String contactNo, int roomTypeId,
                                     LocalDate checkIn, LocalDate checkOut) {

        String sql = "UPDATE reservations SET guest_name=?, address=?, contact_number=?, " +
                "room_type_id=?, check_in=?, check_out=? WHERE id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, guestName);
            ps.setString(2, address);
            ps.setString(3, contactNo);
            ps.setInt(4, roomTypeId);
            ps.setDate(5, Date.valueOf(checkIn));
            ps.setDate(6, Date.valueOf(checkOut));
            ps.setInt(7, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}