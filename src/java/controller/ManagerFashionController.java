package controller;

import UtilCommon.StringCommon;
import dao.FashionDAO;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Fashion;

public class ManagerFashionController extends HttpServlet {

    FashionDAO fashionDAO = new FashionDAO();
    StringCommon common = new StringCommon();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String command = request.getParameter("command");
        String fashion = request.getParameter("fashion");

        String url = "", error = "";

        try {
            if (error.length() == 0) {
                switch (command) {
                    case "insert":
                        fashionDAO.insertFashion(new Fashion(fashion));
                        url = "admin/fashion.jsp";
                        response.sendRedirect(url);
                        return;
                    case "update":
                        fashionDAO.updateFashion(new Fashion(Long.parseLong(request.getParameter("id")),
                                fashion));
                        url = "admin/fashion.jsp";
                        response.sendRedirect(url);
                        return;
                    case "delete":
                        fashionDAO.deleteCategory(Long.parseLong(request.getParameter("id")));
                        url = "admin/fashion.jsp";
                        response.sendRedirect(url);
                        return;
                }
            } else {
                url = "/admin/insert_category.jsp";
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
