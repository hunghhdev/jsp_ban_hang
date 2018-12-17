<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Nạp tiền</title>
        <link rel="stylesheet" type="text/css" href="css/login.css" />
        <%
            if (session.getAttribute("user") == null) {
                response.sendRedirect("index.jsp");
            }
        %>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <br /><br /><br /><br /><br /><br />
            <div class="container modal-content">
                <p style="align-content: center; color: red">${param.message}</p>
            <div id="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li class="active">
                        <a href="#" data-toggle="tab">Nạp tiền vào tài khoản</a>
                    </li>
                </ul>
            </div>
            <form id="frmRegister" class="form-horizontal" 
                  action="RechargeController"
                  method="post">
                <br />
                <div class="form-group">
                    <label class="col-md-3" for="w-card">Loại thẻ</label>
                    <div class="col-md-9">
                        <select id="w-card" name="w-card">
                            <option value="viettel">Viettel</option>
                            <option value="mobifone">Mobifone</option>
                            <option value="vinaphone">Vinaphone</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3" for="w-card-grade">Mệnh giá</label>
                    <div class="col-md-9">
                        <select id="w-card-grade" name="w-card-grade">
                            <option value="20000">20.000</option>
                            <option value="50000">50.000</option>
                            <option value="100000">100.000</option>
                            <option value="200000">200.000</option>
                            <option value="500000">500.000</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3" for="w-card-serial">Serial</label>
                    <div class="col-md-9">
                        <input id="w-card-serial" 
                               class="form-control" 
                               type="text" 
                               name="w-card-serial"
                               placeholder="serial" 
                               tabindex="3" 
                               required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-md-3" for="w-card-number">Mã thẻ</label>
                    <div class="col-md-9">
                        <input id="w-card-number" 
                               class="form-control" 
                               type="text" 
                               name="w-card-number"
                               placeholder="Mã thẻ" 
                               tabindex="4"
                               min="6"
                               required>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-offset-3 col-md-9">
                        <input class="form-control btn btn-default" 
                               type="submit"
                               style="background-color: #ffff00;" 
                               tabindex="6"
                               value="xác nhận">
                    </div>
                </div>
            </form>

        </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
