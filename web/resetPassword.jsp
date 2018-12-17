<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/login.css">
        <title>Reset Password</title>
        <%
            if (session.getAttribute("user") != null) {
                response.sendRedirect("index.jsp");
            }
        %>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <br /><br /><br /><br /><br /><br />
            <div class="container">
                <div id="registerTab" class="container modal-content">
                    <p style="align-content: center; color: red">${param.message}</p>
                <div id="nav-tabs-custom">
                    <ul class="nav nav-tabs">
                        <li id="tabRegister" class="active">
                            <a href="#registerTab" data-toggle="tab">Quê mật khẩu</a>
                        </li>
                    </ul>
                </div>
                <form id="frmResetPassword" 
                      class="form-horizontal" 
                      action="ResetPassword"
                      method="post">
                    <br />
                    <div class="form-group">
                        <label class="col-md-3" for="email">Địa chỉ email</label>
                        <div class="col-md-9">
                            <input id="email" 
                                   class="form-control" 
                                   type="text" 
                                   name="email"
                                   placeholder="abcd@gmail.com" 
                                   tabindex="1" 
                                   required>
                            <br />
                            <input type="submit" 
                                   id="btnLogin" 
                                   class="btn btn-green-web"
                                   tabindex="3"
                                   value="Gửi mật khẩu" />
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
