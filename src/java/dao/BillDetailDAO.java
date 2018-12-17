package dao;

import UtilCommon.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.BillDetail;

public class BillDetailDAO {

    public void insertBillDetail(BillDetail bd) throws SQLException {
        Connection connection = DBConnect.getConnection();
        String sql = "INSERT INTO bill_detail VALUES(?,?,?,?,?)";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setLong(1, bd.getBillDetailID());
        ps.setLong(2, bd.getBillID());
        ps.setLong(3, bd.getProductID());
        ps.setDouble(4, bd.getPrice());
        ps.setInt(5, bd.getQuantity());
        ps.executeUpdate();
    }

    public ArrayList<BillDetail> getBillDetailsByBillId(long billId) {
        ArrayList<BillDetail> list = new ArrayList<>();
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "SELECT * FROM bill_detail where billID = ? ";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, billId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BillDetail billDetail = new BillDetail();
                billDetail.setBillDetailID(rs.getLong("billDetailID"));
                billDetail.setProductID(rs.getLong("productID"));
                billDetail.setPrice(rs.getDouble("price"));
                billDetail.setQuantity(rs.getInt("quantity"));
                list.add(billDetail);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDetailDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public static void main(String[] args) throws SQLException {
       BillDetailDAO billDetailDAO = new BillDetailDAO();
        ArrayList<BillDetail> billDetails = billDetailDAO.getBillDetailsByBillId(Long.parseLong("1544628803116"));
        for (BillDetail billDetail : billDetails) {
            System.out.println(billDetail.getProductID());
        }
    }
}
