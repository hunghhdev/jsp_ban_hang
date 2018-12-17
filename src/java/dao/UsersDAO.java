package dao;

import UtilCommon.StringCommon;
import UtilCommon.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Users;

public class UsersDAO {

    StringCommon common = new StringCommon();

    public ArrayList<Users> getAllUsersList() throws SQLException {
        ArrayList<Users> arrayList = new ArrayList<>();
        Connection connection = DBConnect.getConnection();
        String sql = "select * from users";

        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Users users = new Users();
            users.setUserId(rs.getLong("user_id"));
            users.setUserName(rs.getString("user_name"));
            users.setUserEmail(rs.getString("user_mail"));
            users.setUserPhone(rs.getString("user_phone"));
            users.setUserSex(rs.getBoolean("user_sex"));
            users.setUserBirthday(rs.getDate("user_birthday"));
            users.setUserFBId(rs.getString("user_fbid"));
            users.setUserGGId(rs.getString("user_ggid"));
            users.setUserDollar(rs.getFloat("user_dollar"));
            arrayList.add(users);
        }
        rs.close();
        ps.close();
        connection.close();
        return arrayList;
    }

    public boolean checkEmail(String email) {
        Connection connection = DBConnect.getConnection();
        String sql = "Select * from users where user_mail = ?";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = connection.prepareCall(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            while (rs.next()) {
                rs.close();
                ps.close();
                connection.close();
                return false;
            }
        } catch (SQLException e) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return true;
    }

    public boolean checkPhonenumber(String number) {
        Connection connection = DBConnect.getConnection();
        String sql = "Select * from users where user_phone = ?";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = connection.prepareCall(sql);
            ps.setString(1, number);
            rs = ps.executeQuery();
            while (rs.next()) {
                rs.close();
                ps.close();
                connection.close();
                return false;
            }
        } catch (SQLException e) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return true;
    }

    public boolean insertUser(Users users) {
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "insert into users(user_name,user_phone,user_mail,user_pass,user_sex,user_birthday)"
                    + " values(?,?,?,?,?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, users.getUserName());
            ps.setString(2, users.getUserPhone());
            ps.setString(3, users.getUserEmail());
            ps.setString(4, common.encryption(users.getUserPass()));
            ps.setBoolean(5, users.isUserSex());
            ps.setDate(6, new java.sql.Date(users.getUserBirthday().getTime()));
            ps.execute();
            ps.close();
            connection.close();
            return true;
        } catch (SQLException e) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public Users getUser(String phoneMail, String pass) {
        Users users = new Users();
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "select * from users where (user_phone = ? or user_mail = ?) and user_pass = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, phoneMail);
            ps.setString(2, phoneMail);
            ps.setString(3, common.encryption(pass));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                users.setUserId(rs.getLong("user_id"));
                users.setUserName(rs.getString("user_name"));
                users.setUserPhone(rs.getString("user_phone"));
                users.setUserEmail(rs.getString("user_mail"));
                users.setUserSex(rs.getBoolean("user_sex"));
                users.setUserBirthday(rs.getDate("user_birthday"));
                users.setUserDollar(rs.getFloat("user_dollar"));
                break;
            }
            return users;
        } catch (SQLException e) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return users;
    }

    public Users getUserFB(String idfb) {
        Users users = new Users();
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "select * from users where user_fbid = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idfb);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                users.setUserId(rs.getLong("user_id"));
                users.setUserName(rs.getString("user_name"));
                users.setUserPhone(rs.getString("user_phone"));
                users.setUserEmail(rs.getString("user_mail"));
                users.setUserSex(rs.getBoolean("user_sex"));
                users.setUserBirthday(rs.getDate("user_birthday"));
                users.setUserDollar(rs.getFloat("user_dollar"));
                break;
            }
            return users;
        } catch (SQLException e) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return users;
    }

    public boolean insertUserFB(Users users) {
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "insert into users(user_name,user_fbid)"
                    + " values(?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, users.getUserName());
            ps.setString(2, users.getUserFBId());
            ps.execute();
            ps.close();
            connection.close();
            return true;
        } catch (SQLException e) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public Users getUserGG(String idGG) {
        Users users = new Users();
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "select * from users where user_ggid = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, idGG);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                users.setUserId(rs.getLong("user_id"));
                users.setUserName(rs.getString("user_name"));
                users.setUserPhone(rs.getString("user_phone"));
                users.setUserEmail(rs.getString("user_mail"));
                users.setUserSex(rs.getBoolean("user_sex"));
                users.setUserBirthday(rs.getDate("user_birthday"));
                users.setUserDollar(rs.getFloat("user_dollar"));
                break;
            }
            return users;
        } catch (SQLException e) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return users;
    }

    public boolean insertUserGG(Users users) {
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "insert into users(user_name,user_mail,user_ggid)"
                    + " values(?,?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            if (users.getUserName() == null || users.getUserName().isEmpty()) {
                ps.setString(1, users.getUserEmail());
            } else {
                ps.setString(1, users.getUserName());
            }

            ps.setString(2, users.getUserEmail());
            ps.setString(3, users.getUserGGId());
            ps.execute();
            ps.close();
            connection.close();
            return true;
        } catch (SQLException e) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public Users getUserById(long id) {
        Users users = new Users();
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "select * from users where user_id = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                users.setUserId(rs.getLong("user_id"));
                users.setUserName(rs.getString("user_name"));
                users.setUserPhone(rs.getString("user_phone"));
                users.setUserEmail(rs.getString("user_mail"));
                users.setUserSex(rs.getBoolean("user_sex"));
                users.setUserBirthday(rs.getDate("user_birthday"));
                users.setUserDollar(rs.getFloat("user_dollar"));
                break;
            }
            return users;
        } catch (SQLException e) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return users;
    }

    public boolean resetPassword(String email, String newPassword) {
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "update users set user_pass = ? where user_mail = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(2, email);
            ps.setString(1, common.encryption(newPassword));
            ps.execute();
            ps.close();
            connection.close();
            return true;
        } catch (SQLException e) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public boolean insertDollar(long id, float value) {
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "update users set user_dollar = ? where user_id = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(2, id);
            ps.setFloat(1, value);
            ps.execute();
            ps.close();
            connection.close();
            return true;
        } catch (SQLException e) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public boolean updateUser(Users users) {
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "update users set user_name = ?, user_phone = ?, user_mail = ?, user_pass = ?,user_sex = ?, user_birthday = ?"
                    + " where user_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, users.getUserName());
            ps.setString(2, users.getUserPhone());
            ps.setString(3, users.getUserEmail());
            ps.setString(4, common.encryption(users.getUserPass()));
            ps.setBoolean(5, users.isUserSex());
            ps.setDate(6, new java.sql.Date(users.getUserBirthday().getTime()));
            ps.setLong(7, users.getUserId());
            ps.execute();
            ps.close();
            connection.close();
            return true;
        } catch (SQLException e) {
            Logger.getLogger(UsersDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    public boolean deleteUser(long id) {
        try {
            Connection connection = DBConnect.getConnection();
            String sql = "delete from users where user_id = ?";
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
        UsersDAO usersDAO = new UsersDAO();

        System.out.print(usersDAO.insertDollar(7, 50000));

    }
}
