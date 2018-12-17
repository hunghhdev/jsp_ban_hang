package controller;

import UtilCommon.StringCommon;
import dao.ProductDAO;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Product;
import model.ProductSize;

public class managerProductServlet extends HttpServlet {

    ProductDAO productDAO = new ProductDAO();
    StringCommon common = new StringCommon();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        Product product = new Product();
        String command = request.getParameter("command");
        if (common.isNullOrEmpty(request.getParameter("productId"))) {
            product.setProductID(Long.parseLong(request.getParameter("productId")));
        }
        if (common.isNullOrEmpty(request.getParameter("fashionId"))) {
            product.setFashionID(Long.parseLong(request.getParameter("fashionId")));
        }
        if (common.isNullOrEmpty(request.getParameter("productName"))) {
            product.setProductName(request.getParameter("productName"));
        }
        if (common.isNullOrEmpty(request.getParameter("productColor"))) {
            product.setProductColor(request.getParameter("productColor"));
        }
        if (common.isNullOrEmpty(request.getParameter("fabricMaterial"))) {
            product.setFabricMaterial(request.getParameter("fabricMaterial"));
        }
        if (common.isNullOrEmpty(request.getParameter("productDetail"))) {
            product.setProductDetail(request.getParameter("productDetail"));
        }
        if (common.isNullOrEmpty(request.getParameter("productDes"))) {
            product.setProductDescription(request.getParameter("productDes"));
        }
        if (common.isNullOrEmpty(request.getParameter("productPrice"))) {
            product.setProductPrice(Double.parseDouble(request.getParameter("productPrice")));
        }
        if (common.isNullOrEmpty(request.getParameter("filename"))) {
            product.setProductImg("images/ao/" + request.getParameter("filename"));
        }
        ProductSize productSize = new ProductSize();
        productSize.setXs(Boolean.parseBoolean(request.getParameter("checkXS")));
        productSize.setS(Boolean.parseBoolean(request.getParameter("checkS")));
        productSize.setM(Boolean.parseBoolean(request.getParameter("checkM")));
        productSize.setL(Boolean.parseBoolean(request.getParameter("checkL")));
        productSize.setXl(Boolean.parseBoolean(request.getParameter("checkXL")));

        String url = "", error = "";
        try {
            if (error.length() == 0) {
                switch (command) {
                    case "insert":
                        if (productDAO.insertProduct(product)) {
                            productSize.setProductId(productDAO.getMaxId());
                            productDAO.insertProductSize(productSize);
                        }
                        url = "admin/index.jsp";
                        response.sendRedirect(url);
                        return;
                    case "update":
                        productDAO.upadteProduct(product);
                        productDAO.updateProductSize(productSize);
                        url = "admin/index.jsp";
                        response.sendRedirect(url);
                        return;
                    case "delete":
                        productDAO.deleteProductSize(Long.parseLong(request.getParameter("productId")));
                        productDAO.deleteProduct(Long.parseLong(request.getParameter("productId")));
                        url = "admin/index.jsp";
                        response.sendRedirect(url);
                        return;
                }
            } else {
                url = "/admin/index.jsp";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
    }

}
