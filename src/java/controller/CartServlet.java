package controller;

import UtilCommon.StringCommon;
import dao.ProductDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Cart;
import model.Item;
import model.Product;

public class CartServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();
    StringCommon common = new StringCommon();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int quantity = 0;
        Cart cart = ((Cart) session.getAttribute("cart"));
        String command = request.getParameter("command");
        String productId = request.getParameter("productID");
        Item item = cart.getCartItems(Long.parseLong(productId));
        String productSize = request.getParameter("productSize");
        String quantityNew = request.getParameter("quantityNew");
        if (common.isNullOrEmpty(productSize)) {

        }
        try {
            Long idProduct = Long.parseLong(productId);
            Product product = productDAO.getProductById(idProduct);
            if (!common.isNullOrEmpty(quantityNew) && command.equals("plusCheckOut")) {
                quantity = cart.getCartItems().get(idProduct).getQuantity();
            } else if (common.isNullOrEmpty(quantityNew) && command.equals("plusCheckOut")) {
                quantity = Integer.parseInt(quantityNew);
            }
            switch (command) {
                case "plus":
                    if (cart.getCartItems().containsKey(idProduct)) {
                        cart.plusToCart(idProduct, new Item(product, cart.getCartItems().get(idProduct).getQuantity(), productSize));
                    } else {
                        cart.plusToCart(idProduct, new Item(product, 1, productSize));
                    }
                    break;
                case "plusCheckOut":
                    item.setQuantity(quantity);
                    if (cart.getCartItems().containsKey(idProduct)) {
                        cart.newQuantity(idProduct, item);
                    }
                    cart.totalCart();
                    session.setAttribute("cart", cart);
                    response.sendRedirect("cart.jsp");
                    return;
                case "remove":
                    cart.removeToCart(idProduct);
                    break;
                case "removeCheckout":
                    cart.removeToCart(idProduct);
                    session.setAttribute("cart", cart);
                    response.sendRedirect("cart.jsp");
                    return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp");
        }
        session.setAttribute("cart", cart);
        response.sendRedirect("index.jsp");
    }

}
