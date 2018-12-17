package controller;

import UtilCommon.StringCommon;
import dao.UsersDAO;
import java.io.IOException;
import java.net.URLEncoder;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.adminBO;

public class managerUserServlet extends HttpServlet {

    UsersDAO usersDAO = new UsersDAO();
    StringCommon common = new StringCommon();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = "", error = "";
        HttpSession session = request.getSession();
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String id = request.getParameter("ID");
        String command = request.getParameter("command");
        adminBO adminbo = (adminBO) session.getAttribute("adminBo");
        try {
            if (error.length() == 0) {
                switch (command) {
                    case "delete":
                        usersDAO.deleteUser(Long.parseLong(id));
                        url = "admin/customer.jsp";
                        response.sendRedirect(url);
                        return;
                }
            } else {
                url = "/admin/customer.jsp";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
    }
}
