package dao;

import UtilCommon.DBConnect;
import model.Fashion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class FashionDAO {

    public boolean insertFashion(Fashion fashion) {
        Connection connection = DBConnect.getConnection();
        String sql = "INSERT INTO fashion(fashion_name) VALUES(?)";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, fashion.getFashionName());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean updateFashion(Fashion fashion) {
        Connection connection = DBConnect.getConnection();
        String sql = "UPDATE fashion SET fashion_name = ? WHERE fashion_id = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, fashion.getFashionName());
            ps.setLong(2, fashion.getFashionId());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean deleteCategory(long category_id) {
        Connection connection = DBConnect.getConnection();
        String sql = "DELETE FROM fashion WHERE fashion_id = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, category_id);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public ArrayList<Fashion> getListFashion() throws SQLException {
        Connection connection = DBConnect.getConnection();
        String sql = "SELECT * FROM fashion";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Fashion> list = new ArrayList<>();
        while (rs.next()) {
            Fashion fashion = new Fashion();
            fashion.setFashionId(rs.getInt("fashion_id"));
            fashion.setFashionName(rs.getString("fashion_name"));
            list.add(fashion);
        }
        rs.close();
        ps.close();
        connection.close();
        return list;
    }

    public ArrayList<Fashion> getListFashionById(Long fashionId) throws SQLException {
        Connection connection = DBConnect.getConnection();
        String sql = "SELECT * FROM fashion where fashion_id = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setLong(1, fashionId);
        ResultSet rs = ps.executeQuery();
        ArrayList<Fashion> list = new ArrayList<>();
        while (rs.next()) {
            Fashion fashion = new Fashion();
            fashion.setFashionId(rs.getInt("fashion_id"));
            fashion.setFashionName(rs.getString("fashion_name"));
            list.add(fashion);
        }
        rs.close();
        ps.close();
        connection.close();
        return list;
    }

    public Fashion getFashionById(Long fashionId) throws SQLException {
        Fashion fashion;
        try (Connection connection = DBConnect.getConnection()) {
            String sql = "SELECT * FROM fashion where fashion_id = ?";
            try (PreparedStatement ps = connection.prepareCall(sql)) {
                ps.setLong(1, fashionId);
                try (ResultSet rs = ps.executeQuery()) {
                    fashion = new Fashion();
                    while (rs.next()) {
                        fashion.setFashionId(rs.getInt("fashion_id"));
                        fashion.setFashionName(rs.getString("fashion_name"));
                    }
                }
            }
        }
        return fashion;
    }

    public static void main(String[] args) throws SQLException {
        FashionDAO fashionDAO = new FashionDAO();
        System.out.println(fashionDAO.getFashionById(Long.parseLong("2")).getFashionName());
    }
}
