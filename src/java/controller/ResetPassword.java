package controller;

import UtilCommon.StringCommon;
import dao.UsersDAO;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ResetPassword extends HttpServlet {

    static Properties mailServerProperties;
    static Session getMailSession;
    static MimeMessage generateMailMessage;
    UsersDAO usersDAO = new UsersDAO();
    StringCommon stringCommon = new StringCommon();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String message = "";
        String newPassword = stringCommon.ramdomString();
        if (email != null && !email.isEmpty()) {
            if (usersDAO.checkEmail(email)) {
                message = "Email không tồn tại";
                response.sendRedirect("resetPassword.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
                return;
            } else {
                usersDAO.resetPassword(email, newPassword);
                try {
                    generateAndSendEmail(email, newPassword);
                    message = "Mật khẩu mới đã được gửi đến email của bạn";
                    response.sendRedirect("resetPassword.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
                    return;
                } catch (MessagingException ex) {
                    message = "Không gửi được mail";
                    response.sendRedirect("resetPassword.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
                    Logger.getLogger(ResetPassword.class.getName()).log(Level.SEVERE, null, ex);
                    return;
                }
            }
        } else {
            message = "Có giá trị trống";
            response.sendRedirect("resetPassword.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
        }
    }

    public void generateAndSendEmail(String toMail, String newPassword) throws AddressException, MessagingException {
        System.setProperty("file.encoding","UTF-8");
        mailServerProperties = System.getProperties();
        mailServerProperties.put("mail.smtp.port", "587");
        mailServerProperties.put("mail.smtp.auth", "true");
        mailServerProperties.put("mail.smtp.starttls.enable", "true");
        getMailSession = Session.getDefaultInstance(mailServerProperties, null);
        generateMailMessage = new MimeMessage(getMailSession);
        generateMailMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(toMail));
        generateMailMessage.setSubject("reset password..");
        String emailBody = "this is new password: "+newPassword+ "<br><br> Regards, <br> Admin";
        generateMailMessage.setContent(emailBody, "text/html");
        Transport transport = getMailSession.getTransport("smtp");

        transport.connect("smtp.gmail.com", "ngocgom.16596@gmail.com", "yeuanhxm");
        transport.sendMessage(generateMailMessage, generateMailMessage.getAllRecipients());
        transport.close();
    }
}
