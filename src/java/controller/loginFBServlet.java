/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import UtilCommon.RestFB;
import com.restfb.types.User;
import dao.UsersDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Users;

public class loginFBServlet extends HttpServlet {

    UsersDAO usersDAO = new UsersDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");

        if (code == null || code.isEmpty()) {
            RequestDispatcher dis = request.getRequestDispatcher("login.jsp");
            dis.forward(request, response);
        } else {
            String accessToken = RestFB.getToken(code);
            User user = RestFB.getUserInfo(accessToken);
            Users users = usersDAO.getUserFB(user.getId());
            if (users.getUserName() == null) {
                Users u = new Users();
                u.setUserFBId(user.getId());
                u.setUserName(user.getName());
                usersDAO.insertUserFB(u);
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("user", u);
                response.sendRedirect("index.jsp");
                return;
            }
            if (users.getUserName() != null) {
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("user", users);
                response.sendRedirect("index.jsp");
                return;
            }
            RequestDispatcher dis = request.getRequestDispatcher("index.jsp");
            dis.forward(request, response);
        }
    }

}
