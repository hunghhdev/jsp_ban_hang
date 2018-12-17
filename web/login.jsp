<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Login</title>
        <link rel="stylesheet" type="text/css" href="css/login.css">
        <%
            if (session.getAttribute("user") != null) {
                response.sendRedirect("index.jsp");
            }
        %>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>

            <div id="login-content" style="margin-left: 150px">
                <div class="container">
                    <div id="modalLogin" class="" role="dialog">
                        <div class="modal-content">
                            <div id="nav-tabs-custom">
                                <ul class="nav nav-tabs">
                                    <li id="tabLogin" class="active">
                                        <a href="#loginTab" data-toggle="tab">Đăng nhập</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="tab-content">
                                <p style="align-content: center; color: red">${param.message}</p>
                            <div id="loginTab" class="tab-pane fade in active">
                                <form id="frmLogin" class="form-horizontal"
                                      action="LoginController"
                                      method="post">
                                    <div class="form-group">
                                        <label class="col-md-3" for="w-email" tabindex="1">Email/ SĐT</label>
                                        <div class="col-md-9">
                                            <input id="w-email" type="text" 
                                                   class="form-control col-md-9"
                                                   placeholder="Nhập số điện thoại hoặc Email" 
                                                   name="phoneMail"
                                                   required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-md-3" for="w-pass" tabindex="2">Mật Khẩu</label>
                                        <div class="col-md-9">
                                            <input id="w-pass" 
                                                   type="password" 
                                                   class="form-control col-md-9"
                                                   name="pass"
                                                   placeholder="Mật khẩu từ 6 đến 32 ký tự" 
                                                   required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-md-offset-3 col-md-9">
                                            <p style="font-size: 11px;">Quên mật khẩu? Nhấn vào
                                                <span onclick="location.href='resetPassword.jsp'"
                                                      style="color: blue; cursor: pointer; padding-top: 5px">đây</span>
                                            </p>
                                        </div>
                                        <div class="col-md-offset-3 col-md-9">
                                            <input type="submit" 
                                                   id="btnLogin" 
                                                   class="btn login form-control col-md-9"
                                                   tabindex="3"
                                                   value="Đăng nhập" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-md-offset-3 col-md-9  group-login" style="margin-top: 20px">
                                            <button type="button" id="btnFacebookLogin" class=" btn form-control col-md-9"
                                                    onclick="location.href = 'https://www.facebook.com/dialog/oauth?client_id=1111495145565142&redirect_uri=https://localhost:8443/GOM-NB/login-facebook'" tabindex="4">
                                                <i class="fab fa-facebook-f fa-lg"></i>Đăng nhập bằng Facebook
                                            </button>
                                            <button type="button" id="btnGoogleLogin" class="btn form-control col-md-9"
                                                    onclick="location.href='https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=https://localhost:8443/GOM-NB/login-google&response_type=code&client_id=480987340761-49kq3abph4d02uosnk80luredhabcgeh.apps.googleusercontent.com&approval_prompt=force'" tabindex="5">
                                                <i class="fab fa-google-plus-square fa-lg"></i>Đăng nhập bằng Google
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" ></jsp:include>
    </body>
</html>
