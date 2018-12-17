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
import model.Product;
import model.ProductSize;

public class ProductDAO {

    StringCommon common = new StringCommon();

    public boolean deleteProduct(long category_id) {
        Connection connection = DBConnect.getConnection();
        String sql = "DELETE FROM product WHERE product_id = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, category_id);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean insertProduct(Product product) throws SQLException {
        Connection connection = DBConnect.getConnection();
        String sql = "INSERT INTO product(fashion,product_name,product_price,fabric_material,product_color,product_detail,product_des,product_img) "
                + "VALUES(?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, product.getFashionID());
            ps.setString(2, product.getProductName());
            ps.setDouble(3, product.getProductPrice());
            ps.setString(4, product.getFabricMaterial());
            ps.setString(5, product.getProductColor());
            ps.setString(6, product.getProductDetail());
            ps.setString(7, product.getProductDescription());
            ps.setString(8, product.getProductImg());

            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connection.close();
        }
        return false;
    }

    public boolean upadteProduct(Product product) throws SQLException {
        Connection connection = DBConnect.getConnection();
        String sql = "update product set fashion = ?, product_name = ?, product_price = ?, fabric_material = ?,"
                + "product_color = ?, product_detail = ?, product_des = ?, product_img = ? where product_id = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, product.getFashionID());
            ps.setString(2, product.getProductName());
            ps.setDouble(3, product.getProductPrice());
            ps.setString(4, product.getFabricMaterial());
            ps.setString(5, product.getProductColor());
            ps.setString(6, product.getProductDetail());
            ps.setString(7, product.getProductDescription());
            ps.setString(8, product.getProductImg());
            ps.setLong(9, product.getProductID());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connection.close();
        }
        return false;
    }

    public ArrayList<Product> getAllListProduct() {
        ArrayList<Product> list = new ArrayList<>();
        Connection connection = DBConnect.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "select * from product";
            ps = connection.prepareCall(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getLong("product_id"));
                product.setFashionID(rs.getLong("fashion"));
                product.setProductName(rs.getString("product_name"));
                product.setProductPrice(rs.getDouble("product_price"));
                product.setFabricMaterial(rs.getString("fabric_material"));
                product.setProductColor(rs.getString("product_color"));
                product.setProductDetail(rs.getString("product_detail"));
                product.setProductDescription(rs.getString("product_des"));
                product.setProductImg(rs.getString("product_img"));
                product.setProductSize(getProductSize(product.getProductID()));
                list.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return list;
    }

    public ArrayList<Product> getListProductByPages(long categoryID, int firstResult, int maxResult) throws SQLException {
        Connection connection = DBConnect.getConnection();
        String sql = "SELECT * FROM product WHERE category_id = '" + categoryID + "' limit ?,?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setInt(1, firstResult);
        ps.setInt(2, maxResult);
        ResultSet rs = ps.executeQuery();
        ArrayList<Product> list = new ArrayList<>();
        while (rs.next()) {
            Product product = new Product();
            product.setProductID(rs.getLong("product_id"));
            product.setProductName(rs.getString("product_name"));
            product.setProductImg(rs.getString("product_image"));
            product.setProductPrice(rs.getDouble("product_price"));
            product.setProductDescription(rs.getString("product_description"));
            list.add(product);
        }
        return list;
    }

    public ArrayList<Product> getAllListProductIndex() {
        ArrayList<Product> list = new ArrayList<>();
        Connection connection = DBConnect.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "select * from product order by product_id desc limit 8";
            ps = connection.prepareCall(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getLong("product_id"));
                product.setFashionID(rs.getLong("fashion"));
                product.setProductName(rs.getString("product_name"));
                product.setProductPrice(rs.getDouble("product_price"));
                product.setProductDescription(rs.getString("product_des"));
                product.setProductImg(rs.getString("product_img"));
                list.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return list;
    }

    public ArrayList<Product> getListProductByFashion(long fashion_id) {
        ArrayList<Product> list = new ArrayList<>();
        Connection connection = DBConnect.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "Select * from product where fashion = ?";
            ps = connection.prepareCall(sql);
            ps.setLong(1, fashion_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getLong("product_id"));
                product.setFashionID(rs.getLong("fashion"));
                product.setProductName(rs.getString("product_name"));
                product.setProductPrice(rs.getDouble("product_price"));
                product.setProductDescription(rs.getString("product_des"));
                product.setProductImg(rs.getString("product_img"));
                list.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return list;
    }

    public ArrayList<Product> getListProductBySale(long saleId) {
        ArrayList<Product> list = new ArrayList<>();
        Connection connection = DBConnect.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "Select * from product where sale = ?";
            ps = connection.prepareCall(sql);
            ps.setLong(1, saleId);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getLong("product_id"));
                product.setFashionID(rs.getLong("fashion"));
                product.setProductName(rs.getString("product_name"));
                product.setProductPrice(rs.getDouble("product_price"));
                product.setProductDescription(rs.getString("product_des"));
                product.setProductImg(rs.getString("product_img"));
                list.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return list;
    }

    public Product getProductById(long product_id) {
        Connection connection = DBConnect.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        Product product = new Product();
        try {
            String sql = "Select * from product where product_id = ?";
            ps = connection.prepareCall(sql);
            ps.setLong(1, product_id);
            rs = ps.executeQuery();
            while (rs.next()) {
                product.setProductID(rs.getLong("product_id"));
                product.setFashionID(rs.getLong("fashion"));
                product.setProductName(rs.getString("product_name"));
                product.setProductPrice(rs.getDouble("product_price"));
                product.setFabricMaterial(rs.getString("fabric_material"));
                product.setProductColor(rs.getString("product_color"));
                product.setProductDetail(rs.getString("product_detail"));
                product.setProductDescription(rs.getString("product_des"));
                product.setProductImg(rs.getString("product_img"));
                product.setProductSize(getProductSize(product.getProductID()));
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return product;
    }

    public ProductSize getProductSize(long productId) {
        Connection connection = DBConnect.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        ProductSize productSize = new ProductSize();
        try {
            String sql = "Select * from product_size where product_id = ?";
            ps = connection.prepareCall(sql);
            ps.setLong(1, productId);
            rs = ps.executeQuery();
            while (rs.next()) {
                productSize.setProductId(rs.getLong("product_id"));
                productSize.setXs(rs.getBoolean("XS"));
                productSize.setS(rs.getBoolean("S"));
                productSize.setM(rs.getBoolean("M"));
                productSize.setL(rs.getBoolean("L"));
                productSize.setXl(rs.getBoolean("XL"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return productSize;
    }

    public boolean insertProductSize(ProductSize productSize) throws SQLException {
        Connection connection = DBConnect.getConnection();
        String sql = "INSERT INTO product_size(product_id,XS,S,M,L,XL) VALUES(?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, productSize.getProductId());
            ps.setBoolean(2, productSize.isXs());
            ps.setBoolean(3, productSize.isS());
            ps.setBoolean(4, productSize.isM());
            ps.setBoolean(5, productSize.isL());
            ps.setBoolean(6, productSize.isXl());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connection.close();
        }
        return false;
    }

    public boolean updateProductSize(ProductSize productSize) throws SQLException {
        Connection connection = DBConnect.getConnection();
        String sql = "update product_size set XS = ? , S = ?, M = ?, L = ?, XL =? where product_id = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setBoolean(1, productSize.isXs());
            ps.setBoolean(2, productSize.isS());
            ps.setBoolean(3, productSize.isM());
            ps.setBoolean(4, productSize.isL());
            ps.setBoolean(5, productSize.isXl());
            ps.setLong(6, productSize.getProductId());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            connection.close();
        }
        return false;
    }

    public boolean deleteProductSize(long id) {
        Connection connection = DBConnect.getConnection();
        String sql = "DELETE FROM product_size WHERE product_id = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, id);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(CategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public long getMaxId() {
        Connection connection = DBConnect.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        long idMax = 0;
        try {
            String sql = "Select max(product_id) as maxId from product";
            ps = connection.prepareCall(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                idMax = rs.getLong("maxId");
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return idMax;
    }

    public ArrayList<Product> getSearchListProduct(String text) {
        ArrayList<Product> list = new ArrayList<>();
        Connection connection = DBConnect.getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String sql = "select * from product where product_name like '%"+text+"%' ";
            ps = connection.prepareCall(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getLong("product_id"));
                product.setFashionID(rs.getLong("fashion"));
                product.setProductName(rs.getString("product_name"));
                product.setProductPrice(rs.getDouble("product_price"));
                product.setFabricMaterial(rs.getString("fabric_material"));
                product.setProductColor(rs.getString("product_color"));
                product.setProductDetail(rs.getString("product_detail"));
                product.setProductDescription(rs.getString("product_des"));
                product.setProductImg(rs.getString("product_img"));
                product.setProductSize(getProductSize(product.getProductID()));
                list.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return list;
    }

    public static void main(String[] args) {
        ProductDAO productDAO = new ProductDAO();
        ArrayList<Product> list = productDAO.getSearchListProduct("ao");
//        ProductSize productSize = productDAO.getProductSize(1);
        for (Product product : list) {
            System.out.println(product.getProductName());
        }
//        System.out.println(productDAO.getMaxId());
    }
}
