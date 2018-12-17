package controller;

import dao.UsersDAO;
import java.io.IOException;
import java.net.URLEncoder;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Users;

public class LoginController extends HttpServlet {

    String message = "";
    UsersDAO usersDAO = new UsersDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String phoneOrMail = request.getParameter("phoneMail");
        String password = request.getParameter("pass");
        if (phoneOrMail.isEmpty() || password.isEmpty()) {
            message = "Có giá trị trống";
            response.sendRedirect("login.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
            return;
        }
        Users users = usersDAO.getUser(phoneOrMail, password);
        if (users.getUserEmail() == null) {
            message = "Tài khoản hoặc mật khẩu không chính xác";
            response.sendRedirect("login.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
            return;
        }
        HttpSession httpSession = request.getSession();
        httpSession.setAttribute("user", users);
        response.sendRedirect("index.jsp");
    }

}
