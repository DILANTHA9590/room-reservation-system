package dao;

import model.RoomType;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class RoomTypeDAO {

    public List<RoomType> getAllRoomTypes() {
        List<RoomType> list = new ArrayList<>();
        String sql = "SELECT id, name, rate_per_night FROM room_types ORDER BY id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                RoomType rt = new RoomType();
                rt.setId(rs.getInt("id"));
                rt.setName(rs.getString("name"));
                rt.setRatePerNight(rs.getDouble("rate_per_night"));
                list.add(rt);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addRoomType(String name, double ratePerNight) {
        String sql = "INSERT INTO room_types(name, rate_per_night) VALUES (?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setDouble(2, ratePerNight);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteRoomType(int id) {
        String sql = "DELETE FROM room_types WHERE id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}