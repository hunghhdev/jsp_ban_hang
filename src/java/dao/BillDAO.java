package dao;

import UtilCommon.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Bill;

public class BillDAO {

    public void insertBill(Bill bill) throws SQLException {
        Connection connection = DBConnect.getConnection();
        String sql = "INSERT INTO bill(userID,total,payment,address,date,note) VALUES(?,?,?,?,?,?)";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setLong(1, bill.getUserID());
        ps.setDouble(2, bill.getTotal());
        ps.setString(3, bill.getPayment());
        ps.setString(4, bill.getAddress());
        ps.setTimestamp(5, bill.getDate());
        ps.setString(6, bill.getNote());
        ps.executeUpdate();
    }

    public ArrayList<Bill> getListBill() {
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "SELECT * FROM bill";
            PreparedStatement ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            ArrayList<Bill> list = new ArrayList<>();
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillID(rs.getLong("billID"));
                bill.setUserID(rs.getLong("userID"));
                bill.setTotal(rs.getDouble("total"));
                bill.setPayment(rs.getString("payment"));
                bill.setAddress(rs.getString("address"));
                bill.setDate(rs.getTimestamp("date"));
                bill.setStatus(rs.getInt("status"));
                bill.setNote(rs.getString("note"));
                list.add(bill);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean updateBillStatus(int status, long billID) {
        Connection connection = DBConnect.getConnection();
        String sql = "UPDATE bill set status = ? where billID = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setInt(1, status);
            ps.setLong(2, billID);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public int getCountBill(int status) {
        int i = -1;
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "SELECT count(1) as xxx FROM bill where status = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setInt(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                i = rs.getInt("xxx");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return i;
    }

    public ArrayList<Bill> getListBillByUserId(long userId) {
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "SELECT * FROM bill where userID = ? ";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();
            ArrayList<Bill> list = new ArrayList<>();
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillID(rs.getLong("billID"));
                bill.setUserID(rs.getLong("userID"));
                bill.setTotal(rs.getDouble("total"));
                bill.setPayment(rs.getString("payment"));
                bill.setAddress(rs.getString("address"));
                bill.setDate(rs.getTimestamp("date"));
                bill.setStatus(rs.getInt("status"));
                bill.setNote(rs.getString("note"));
                list.add(bill);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public static void main(String[] args) throws SQLException {
        BillDAO billDAO = new BillDAO();
        ArrayList<Bill> arrayList = billDAO.getListBillByUserId(4);
        for (Bill bill : arrayList) {
            System.out.println(bill.getBillID());
        }
    }
}
