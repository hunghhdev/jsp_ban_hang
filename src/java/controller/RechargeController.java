package controller;

import dao.UsersDAO;
import java.io.IOException;
import java.net.URLEncoder;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Users;

public class RechargeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UsersDAO usersDAO = new UsersDAO();
        String message = "";
        String card = request.getParameter("w-card");
        String cardGrade = request.getParameter("w-card-grade");
        String cardSerial = request.getParameter("w-card-serial");
        String cardNumber = request.getParameter("w-card-number");
        Users users = (Users) request.getSession().getAttribute("user");
        if (card.isEmpty() || cardGrade.isEmpty() || cardSerial.isEmpty() || cardNumber.isEmpty()) {
            message = "Có giá trị không hợp lệ";
            response.sendRedirect("recharge.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
            return;
        }
        Users u = usersDAO.getUserById(users.getUserId());
        if (usersDAO.insertDollar(users.getUserId(), u.getUserDollar()+Float.parseFloat(cardGrade))) {
            message = "Nạp thành công";
            response.sendRedirect("recharge.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
            users = usersDAO.getUserById(users.getUserId());
            request.getSession().setAttribute("user", users);
            return;
        }
    }

}
