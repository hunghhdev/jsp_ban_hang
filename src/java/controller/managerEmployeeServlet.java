package controller;

import UtilCommon.StringCommon;
import dao.AdminDAO;
import java.io.IOException;
import java.net.URLEncoder;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.adminBO;

public class managerEmployeeServlet extends HttpServlet {

    AdminDAO adminDAO = new AdminDAO();
    StringCommon common = new StringCommon();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String id = request.getParameter("ID");
        String command = request.getParameter("command");
        String name = request.getParameter("name");
        String mail = request.getParameter("mail");
        String password = request.getParameter("password");
        String postion = request.getParameter("postion");
        adminBO adminbo = (adminBO) session.getAttribute("adminBo");
        String url = "", error = "";
        adminBO bo = new adminBO();
        bo.setId(Long.parseLong(id));
        bo.setName(name);
        bo.setEmail(mail);
        bo.setPassword(password);
        if (common.isNullOrEmpty(postion)) {
            bo.setRole(Integer.parseInt(postion));
        }
        if (command.equals("update") || command.equals("insert")) {
            if (!common.isNullOrEmpty(name) || !common.isNullOrEmpty(mail) || !common.isNullOrEmpty(password)) {
                error = "Không được để trống";
                response.sendRedirect("admin/users.jsp?message=" + URLEncoder.encode(error, "UTF-8"));
                return;
            }
        }

        try {
            if (error.length() == 0) {
                switch (command) {
                    case "insert":
                        adminDAO.insertUser(bo);
                        url = "admin/users.jsp";
                        response.sendRedirect(url);
                        return;
                    case "update":
                        adminDAO.updateUser(bo);
                        url = "admin/users.jsp";
                        response.sendRedirect(url);
                        return;
                    case "delete":
                        if (adminbo.getId() == bo.getId()) {
                            error = "Không được tự cung :))";
                            response.sendRedirect("admin/users.jsp?message=" + URLEncoder.encode(error, "UTF-8"));
                            return;
                        }
                        adminDAO.deleteUser(bo.getId());
                        url = "admin/users.jsp";
                        response.sendRedirect(url);
                        return;
                }
            } else {
                url = "/admin/users.jsp";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
