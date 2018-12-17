package dao;

import UtilCommon.DBConnect;
import UtilCommon.StringCommon;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.adminBO;

public class AdminDAO {

    StringCommon common = new StringCommon();

    public ArrayList<adminBO> getAllAdminList() throws SQLException {
        ArrayList<adminBO> arrayList = new ArrayList<>();
        Connection connection = DBConnect.getConnection();
        String sql = "select * from admin";

        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            adminBO adminbo = new adminBO();
            adminbo.setId(rs.getLong("id"));
            adminbo.setName(rs.getString("name"));
            adminbo.setEmail(rs.getString("email"));
            adminbo.setRole(rs.getInt("role"));
            arrayList.add(adminbo);
        }
        rs.close();
        ps.close();
        connection.close();
        return arrayList;
    }

    public adminBO getUser(String mail, String pass) {
        adminBO admin = new adminBO();
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "select * from admin where email = ? and password = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, mail);
            ps.setString(2, common.encryption(pass));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                admin.setId(rs.getLong("id"));
                admin.setName(rs.getString("name"));
                admin.setEmail(rs.getString("email"));
                admin.setPassword(rs.getString("password"));
                admin.setRole(rs.getInt("role"));
                break;
            }
            return admin;
        } catch (SQLException e) {
            Logger.getLogger(AdminDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return admin;
    }

    public boolean insertUser(adminBO admin) {
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "insert into admin(name,email,password) values(?,?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, admin.getName());
            ps.setString(2, admin.getEmail());
            ps.setString(3, common.encryption(admin.getPassword()));
            ps.execute();
            ps.close();
            connection.close();
            return true;
        } catch (SQLException e) {
            Logger.getLogger(AdminDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public boolean updateUser(adminBO admin) {
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "update admin set name = ?, email =? , password = ? where id = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, admin.getName());
            ps.setString(2, admin.getEmail());
            ps.setString(3, common.encryption(admin.getPassword()));
            ps.setLong(4, admin.getId());
            ps.execute();
            ps.close();
            connection.close();
            return true;
        } catch (SQLException e) {
            Logger.getLogger(AdminDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public boolean deleteUser(long id) {
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "delete from admin where id = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, id);
            ps.execute();
            ps.close();
            connection.close();
            return true;
        } catch (SQLException e) {
            Logger.getLogger(AdminDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public static void main(String[] args) {
        AdminDAO adminDAO = new AdminDAO();
//        adminBO bo = adminDAO.getUser("ngocgom.16596@gmail.com", "123456");
        StringCommon common = new StringCommon();
//        System.out.println(adminDAO.insertUser(new adminBO("admin2", "test@thu.thoi",common.encryption("123456"))));
        System.out.println(adminDAO.getUser("ngocgom.16596@gmail.com", "123456"));
    }
}
