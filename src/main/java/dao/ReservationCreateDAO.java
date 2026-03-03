package dao;

import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
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
            ps.setDate(6, java.sql.Date.valueOf(checkIn));
            ps.setDate(7, java.sql.Date.valueOf(checkOut));

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}