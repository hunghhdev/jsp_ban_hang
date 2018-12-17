<%@page import="model.Users"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thanh toán</title>
        <link rel="stylesheet" type="text/css" href="css/login.css">
        <%
            Users users = (Users) session.getAttribute("user");
            if (users == null) {
                response.sendRedirect("login.jsp");
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
                        <a href="#registerTab" data-toggle="tab">Thanh toán</a>
                    </li>
                </ul>
            </div>
            <form id="frmCheckout" class="form-horizontal" 
                  action="CheckOutServlet"
                  method="post">
                <div class="form-group">
                    <label class="col-md-3" for="w-fullname">Họ tên</label>
                    <div class="col-md-9">
                        <input id="w-fullname" 
                               class="form-control" 
                               type="text" 
                               name="w-fullname"
                               placeholder="Nhập họ tên" 
                               tabindex="1" 
                               value="<% if (users != null)%><%=users.getUserName()%>"
                               required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3" for="w-phone">SĐT</label>
                    <div class="col-md-9">
                        <input id="w-phone" 
                               class="form-control" 
                               type="text" 
                               name="w-phone"
                               placeholder="Nhập số điện thoại" 
                               tabindex="2"
                               maxlength="10"
                               value="<% if (users != null)%><%=users.getUserPhone()%>"
                               required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3" for="w-email">Email</label>
                    <div class="col-md-9">
                        <input id="w-email" 
                               class="form-control" 
                               type="email" 
                               name="w-email"
                               placeholder="Nhập email" 
                               tabindex="3" 
                               value="<% if (users != null)%><%=users.getUserEmail()%>"
                               required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3" for="w-address">Địa chỉ</label>
                    <div class="col-md-9">
                        <input id="w-address" 
                               class="form-control" 
                               type="text" 
                               name="w-address"
                               placeholder="Nhập địa chỉ" 
                               tabindex="3" 
                               value=""
                               required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3" for="w-payment">Cách thanh toán</label>
                    <div class="col-md-9">
                        <select name="w-payment">
                            <option value="live">Thanh toán khi nhận hàng</option>
                            <option value="accountPayment">Số dư</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3" for="w-note">Ghi chú</label>
                    <div class="col-md-9">
                        <input id="w-note" 
                               class="form-control" 
                               type="text" 
                               name="w-note"
                               placeholder="ghi chú" 
                               tabindex="3" 
                               value=""
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
