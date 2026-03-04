package dao;

import model.Reservation;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

	public List<Reservation> getAllReservations() {
	    List<Reservation> list = new ArrayList<>();

	    String sql =
	        "SELECT r.id, r.reservation_no, r.guest_name, r.contact_number, " +
	        "r.check_in, r.check_out, r.status, r.is_paid, " +
	        "rt.name AS room_type_name " +
	        "FROM reservations r " +
	        "JOIN room_types rt ON r.room_type_id = rt.id " +
	        "ORDER BY r.id DESC";

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {

	        while (rs.next()) {

	            Reservation r = new Reservation();

	            r.setReservationId(rs.getInt("id"));
	            r.setReservationNo(rs.getString("reservation_no"));
	            r.setGuestName(rs.getString("guest_name"));
	            r.setContactNo(rs.getString("contact_number"));

	            r.setCheckIn(rs.getDate("check_in").toLocalDate());
	            r.setCheckOut(rs.getDate("check_out").toLocalDate());

	            r.setStatus(rs.getString("status"));
	            r.setRoomTypeName(rs.getString("room_type_name"));

	            // 👇 THIS IS IMPORTANT
	            r.setPaid(rs.getInt("is_paid") == 1);

	            list.add(r);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list;
	}

    public boolean cancelReservation(int id) {

        String sql = "UPDATE reservations SET status = 'CANCELLED' WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    
    
    public Reservation getReservationById(int id) {

        String sql =
            "SELECT r.id, r.reservation_no, r.guest_name, r.contact_number, " +
            "r.check_in, r.check_out, r.status, r.is_paid, r.room_type_id, " +
            "rt.name AS room_type_name, rt.rate_per_night " +
            "FROM reservations r " +
            "JOIN room_types rt ON r.room_type_id = rt.id " +
            "WHERE r.id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Reservation r = new Reservation();
                    r.setReservationId(rs.getInt("id"));
                    r.setReservationNo(rs.getString("reservation_no"));
                    r.setGuestName(rs.getString("guest_name"));
                    r.setContactNo(rs.getString("contact_number"));

                    r.setCheckIn(rs.getDate("check_in").toLocalDate());
                    r.setCheckOut(rs.getDate("check_out").toLocalDate());

                    r.setStatus(rs.getString("status"));
                    r.setPaid(rs.getInt("is_paid") == 1);
                    r.setRoomTypeId(rs.getInt("room_type_id"));
                    r.setRoomTypeName(rs.getString("room_type_name"));

//                    calculate reate paymnt
                    return r;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    
    
    public Reservation getReservationForBill(int id) {

        String sql =
            "SELECT r.id, r.reservation_no, r.guest_name, r.contact_number, " +
            "r.check_in, r.check_out, r.status, r.is_paid, r.room_type_id, " +
            "rt.name AS room_type_name, rt.rate_per_night " +
            "FROM reservations r " +
            "JOIN room_types rt ON r.room_type_id = rt.id " +
            "WHERE r.id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {

                    Reservation r = new Reservation();

                    r.setReservationId(rs.getInt("id"));
                    r.setReservationNo(rs.getString("reservation_no"));
                    r.setGuestName(rs.getString("guest_name"));
                    r.setContactNo(rs.getString("contact_number"));

                    if (rs.getDate("check_in") != null)
                        r.setCheckIn(rs.getDate("check_in").toLocalDate());

                    if (rs.getDate("check_out") != null)
                        r.setCheckOut(rs.getDate("check_out").toLocalDate());

                    r.setStatus(rs.getString("status"));
                    r.setPaid(rs.getInt("is_paid") == 1);

                    r.setRoomTypeId(rs.getInt("room_type_id"));
                    r.setRoomTypeName(rs.getString("room_type_name"));

                    // ✅ BILL IMPORTANT
                    r.setRatePerNight(rs.getDouble("rate_per_night"));

                    return r;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}