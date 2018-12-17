package dao;

import UtilCommon.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.Category;

public class CategoryDAO {
    public ArrayList<Category> getListCategorys() throws SQLException{
        Connection connection = DBConnect.getConnection();
        String sql = "SELECT * FROM category";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Category> list = new ArrayList<>();
        while (rs.next()) {            
            Category category = new Category();
            category.setCategoryID(rs.getInt("category_id"));
            category.setCategoryName(rs.getString("category_name"));
            list.add(category);
        }
        rs.close();
        ps.close();
        connection.close();
        return list;
    }
    
    public static void main(String[] args) throws SQLException {
        CategoryDAO categoryDAO = new CategoryDAO();
        for (Category category : categoryDAO.getListCategorys()) {
            System.out.println(category.getCategoryName());
        }
    }
}
