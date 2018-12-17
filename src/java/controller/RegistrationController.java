package controller;

import UtilCommon.StringCommon;
import dao.UsersDAO;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Users;

public class RegistrationController extends HttpServlet {

    String message = "";
    StringCommon common = new StringCommon();
    UsersDAO usersDAO = new UsersDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String url = request.getRequestURI();
            String name = request.getParameter("CustomerName");
            String phone = request.getParameter("CustomerPhone1");
            String email = request.getParameter("CustomerEmail");
            String pass = request.getParameter("CustomerPassword");
            String gender = request.getParameter("w-reg-gender");
            String birthday = request.getParameter("CustomerBirthday");
            if (name.isEmpty() || phone.isEmpty() || email.isEmpty()
                    || pass.isEmpty() || gender.isEmpty() || birthday.isEmpty()) {
                message = "Có giá trị trống";
                response.sendRedirect("registration.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
                return;
            }
            if (!common.isNumber(phone)) {
                message = "Số điện thoại không phù hợp";
                response.sendRedirect("registration.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
                return;
            }
            if (!usersDAO.checkEmail(email)) {
                message = "Email đã tồn tại";
                response.sendRedirect("registration.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
                return;
            }
            if (!usersDAO.checkPhonenumber(name)) {
                message = "Số điện thoại đã tồn tại";
                response.sendRedirect("registration.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
                return;
            }
            Users users = new Users();
            users.setUserName(name);
            users.setUserEmail(email);
            users.setUserPhone(phone);
            users.setUserPass(pass);
            if (gender.equals("1")) {
                users.setUserSex(true);
            } else {
                users.setUserSex(false);
            }
            users.setUserBirthday(new SimpleDateFormat("yyyy-MM-dd").parse(birthday));
            if (usersDAO.insertUser(users)) {
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("user", users);
                response.sendRedirect("index.jsp");
                return;
            }

            message = "Có lỗi xảy ra";
            response.sendRedirect("registration.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
        } catch (ParseException ex) {
            Logger.getLogger(RegistrationController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
