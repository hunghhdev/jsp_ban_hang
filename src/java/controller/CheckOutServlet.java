package controller;

import UtilCommon.eMail;
import dao.BillDAO;
import dao.BillDetailDAO;
import dao.UsersDAO;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Bill;
import model.BillDetail;
import model.Cart;
import model.Item;
import model.Users;

public class CheckOutServlet extends HttpServlet {

    private final BillDAO billDAO = new BillDAO();
    private final BillDetailDAO billDetailDAO = new BillDetailDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        UsersDAO usersDAO = new UsersDAO();
        String payment = request.getParameter("payment");
        String address = request.getParameter("address");
        String note = request.getParameter("note");
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        Users users = (Users) session.getAttribute("user");
        try {
            if (payment.equals("accountPayment")) {
                float dollar = users.getUserDollar();
                if (dollar - (float) cart.totalCart() >= 0) {
                    dollar = dollar - (float) cart.totalCart();
                    usersDAO.insertDollar(users.getUserId(), dollar);
                } else{
                    response.getWriter().write("1");
                    return;
                }
            }
            long ID = new Date().getTime();
            Bill bill = new Bill();
            bill.setBillID(ID);
            bill.setAddress(address);
            bill.setPayment(payment);
            bill.setUserID(users.getUserId());
            bill.setDate(new Timestamp(new Date().getTime()));
            bill.setTotal(cart.totalCart());
            bill.setNote(note);
            billDAO.insertBill(bill);
            for (Map.Entry<Long, Item> list : cart.getCartItems().entrySet()) {
                billDetailDAO.insertBillDetail(new BillDetail(0, ID,
                        list.getValue().getProduct().getProductID(),
                        list.getValue().getProduct().getProductPrice(),
                        list.getValue().getQuantity()));
            }
            users = usersDAO.getUserById(users.getUserId());
            session.setAttribute("user", users);
            eMail sm = new eMail();
            sm.sendMail(users.getUserEmail(), "bill information ", "hello, " + users.getUserName()
                    + "\n total: " + cart.totalCart() + "\n We will contact you soon");

            cart = new Cart();
            session.setAttribute("cart", cart);
        } catch (Exception e) {
            e.printStackTrace();
        }
	response.getWriter().write("0");
    }

}
