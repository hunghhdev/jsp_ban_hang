package controller;

import dao.AdminDAO;
import java.io.IOException;
import java.net.URLEncoder;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.adminBO;

public class AdminLoginController extends HttpServlet {

    AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String message = "";
        String email = request.getParameter("inputEmail");
        String password = request.getParameter("inputPassword");
        adminBO adminBo = adminDAO.getUser(email, password);
        if (adminBo.getEmail()== null) {
            response.getWriter().write("1");
            return;
        }
        HttpSession httpSession = request.getSession();
        httpSession.setAttribute("adminBo", adminBo);
        response.getWriter().write("0");
    }

}
