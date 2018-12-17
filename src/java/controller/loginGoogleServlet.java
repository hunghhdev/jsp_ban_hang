package controller;

import UtilCommon.GoogleUtils;
import dao.UsersDAO;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.GooglePojo;
import model.Users;

public class loginGoogleServlet extends HttpServlet {

    UsersDAO usersDAO = new UsersDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        if (code == null || code.isEmpty()) {
            RequestDispatcher dis = request.getRequestDispatcher("login.jsp");
            dis.forward(request, response);
        } else {
            String accessToken = GoogleUtils.getToken(code);
            GooglePojo googlePojo = GoogleUtils.getUserInfo(accessToken);
            Users users = usersDAO.getUserGG(googlePojo.getId());
            request.setAttribute("id", googlePojo.getId());
            request.setAttribute("name", googlePojo.getName());
            request.setAttribute("email", googlePojo.getEmail());
            if (users.getUserName() == null) {
                Users u = new Users();
                u.setUserGGId(googlePojo.getId());
                u.setUserName(googlePojo.getName());
                u.setUserEmail(googlePojo.getEmail());
                usersDAO.insertUserGG(u);
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
            RequestDispatcher diss = request.getRequestDispatcher("index.jsp");
            diss.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
