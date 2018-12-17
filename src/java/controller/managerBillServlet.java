package controller;

import dao.BillDAO;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class managerBillServlet extends HttpServlet {

    BillDAO billDAO = new BillDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String command = request.getParameter("command");
        int status = Integer.parseInt(request.getParameter("status"));
        long billId = Long.parseLong(request.getParameter("billID"));

        String url = "", error = "";

        try {
            if (error.length() == 0) {
                switch (command) {
                    case "submit":
                        billDAO.updateBillStatus(status,billId);
                        url = "admin/bill.jsp";
                        response.sendRedirect(url);
                        return;
                    case "cancel":
                        billDAO.updateBillStatus(status,billId);
                        url = "admin/bill.jsp";
                        response.sendRedirect(url);
                        return;
                }
            } else {
                url = "/admin/index.jsp";
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
