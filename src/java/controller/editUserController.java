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

public class editUserController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setCharacterEncoding("utf-8");
            response.setCharacterEncoding("utf-8");
            String message = "";
            UsersDAO usersDAO = new UsersDAO();
            StringCommon common = new StringCommon();
            String name = request.getParameter("CustomerName");
            String phone = request.getParameter("CustomerPhone1");
            String email = request.getParameter("CustomerEmail");
            String pass = request.getParameter("CustomerPassword");
            String gender = request.getParameter("w-reg-gender");
            String birthday = request.getParameter("CustomerBirthday");
            Users users = (Users) request.getSession().getAttribute("user");
            if (name.isEmpty() || phone.isEmpty() || email.isEmpty()
                    || pass.isEmpty() || gender.isEmpty() || birthday.isEmpty()) {
                message = "Có giá trị trống";
                response.sendRedirect("editUser.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
                return;
            }
            if (!common.isNumber(phone)) {
                message = "Số điện thoại không phù hợp";
                response.sendRedirect("editUser.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
                return;
            }
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
            if (usersDAO.updateUser(users)) {
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("user", usersDAO.getUserById(users.getUserId()));
                response.sendRedirect("index.jsp");
                return;
            }
            message = "Có lỗi xảy ra";
            response.sendRedirect("editUser.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
        } catch (ParseException ex) {
            Logger.getLogger(editUserController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
