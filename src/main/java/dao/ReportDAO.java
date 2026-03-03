package dao;

import util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ReportDAO {

    private int getCount(String sql) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    private double getSum(String sql) {
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0.0;
    }

    public int totalRoomTypes() { return getCount("SELECT COUNT(*) FROM room_types"); }

    public int totalUsers() { return getCount("SELECT COUNT(*) FROM users"); }

    public int totalReservations() { return getCount("SELECT COUNT(*) FROM reservations"); }

    public int cancelledReservations() {
        return getCount("SELECT COUNT(*) FROM reservations WHERE status='CANCELLED'");
    }

    // payments table තියෙනවා නම්
    public int totalPayments() { return getCount("SELECT COUNT(*) FROM payments"); }

    public double totalRevenue() { return getSum("SELECT IFNULL(SUM(amount),0) FROM payments"); }
}