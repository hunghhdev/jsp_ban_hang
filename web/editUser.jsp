<%@page import="model.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cập nhật thông tin</title>
        <link rel="stylesheet" type="text/css" href="css/login.css">
        <%
            Users users = (Users) session.getAttribute("user");
            if (users == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <br /><br /><br /><br /><br /><br />
            <div id="registerTab" class="container modal-content">
                <p style="align-content: center; color: red">${param.message}</p>
            <div id="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li id="tabRegister" class="active">
                        <a href="#registerTab" data-toggle="tab">Cập nhật thông tin</a>
                    </li>
                </ul>
            </div>
            <form id="frmRegister" class="form-horizontal" 
                  action="editUserController"
                  method="post">
                <div class="form-group">
                    <label class="col-md-3" for="w-reg-fullname">Họ tên</label>
                    <div class="col-md-9">
                        <input id="w-reg-fullname" 
                               class="form-control" 
                               type="text" 
                               name="CustomerName"
                               placeholder="Nhập họ tên" 
                               tabindex="1"
                               value="<%= users.getUserName()%>"
                               required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3" for="w-reg-phone">SĐT</label>
                    <div class="col-md-9">
                        <input id="w-reg-phone" 
                               class="form-control" 
                               type="text" 
                               name="CustomerPhone1"
                               placeholder="Nhập số điện thoại" 
                               tabindex="2"
                               maxlength="10"
                               value="<%= users.getUserPhone() %>"
                               required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3" for="w-reg-email">Email</label>
                    <div class="col-md-9">
                        <input id="w-reg-email" 
                               class="form-control" 
                               type="email" 
                               name="CustomerEmail"
                               placeholder="Nhập email" 
                               tabindex="3"
                               value="<%= users.getUserEmail()%>"
                               required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3" for="w-reg-password">Mật khẩu</label>
                    <div class="col-md-9">
                        <input id="w-reg-password" 
                               class="form-control" 
                               type="password" 
                               name="CustomerPassword"
                               placeholder="Mật khẩu từ 6 đến 32 ký tự" 
                               tabindex="4"
                               min="6"
                               required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3" for="w-reg-password">Giới tính</label>
                    <div class="col-md-9" style="">
                        <span style="margin-right: 20px; ">
                            <input id="female" 
                                   type="radio" 
                                   name="w-reg-gender"
                                   value="0"
                                   checked>
                            <label for="female">
                                Nữ
                            </label>
                        </span>
                        <span>
                            <input id="male" 
                                   type="radio" 
                                   name="w-reg-gender" value="1">
                            <label for="male">
                                Nam
                            </label>
                        </span>
                    </div>
                    <input name="CustomerGender" id="CustomerGender" type="hidden">
                </div>
                <div class="form-group">
                    <label class="col-md-3" for="w-reg-birthday">Ngày sinh</label>
                    <div class="col-md-9">
                        <input id="w-reg-birthday" 
                               class="form-control" 
                               type="date" 
                               name="CustomerBirthday"
                               placeholder="Nhập ngày sinh theo định dạng mm/dd/yy" 
                               tabindex="5"
                               value="<%= users.getUserBirthday()%>"
                               required>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-offset-3 col-md-9">
                        <input class="form-control btn btn-default" 
                               type="submit"
                               style="background-color: #ffff00;" 
                               tabindex="6"
                               value="Xác nhận">
                    </div>
                </div>
            </form>

        </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
