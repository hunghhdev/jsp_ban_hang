<%@page import="dao.BillDAO" %>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Bill" %>
<%@page import="model.adminBO" %>
<%@page import="dao.UsersDAO" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <c:set var="root" value="${pageContext.request.contextPath}"/>
        <title>Quản lý đơn hàng</title>
    </head>
    <body id="page-top">
        <%
            BillDAO billDao = new BillDAO();
            ArrayList<Bill> listBill = billDao.getListBill();
            adminBO admin = (adminBO) session.getAttribute("adminBo");
            if (admin == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            UsersDAO userDao = new UsersDAO();
        %>
        <jsp:include page="header.jsp"></jsp:include>
            <div id="wrapper">
            <jsp:include page="menu.jsp" />
            <div id="content-wrapper">
                <!--content start-->
                <div class="container-fluid">
                    <div class="card mb-3">
                        <div class="card-header">
                            <i class="fas fa-table"></i>
                            Danh sách đơn hàng</div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>Mã hàng hóa</th>
                                            <th>Khách hàng</th>
                                            <th>Tổng hóa đơn</th>
                                            <th>Thanh toán</th>
                                            <th>Địa chỉ giao hàng</th>
                                            <th>Ngày mua</th>
                                            <th>Ghi chú</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for(Bill bill :listBill){%>
                                        <tr>
                                            <td><%=bill.getBillID()%></td>
                                            <td><%=userDao.getUserById(bill.getUserID()).getUserName()%></td>
                                            <td><fmt:formatNumber pattern="#,##0" value="<%=bill.getTotal()%>"/></td>
                                            <td><%=bill.getPayment()%></td>
                                            <td><%=bill.getAddress()%></td>
                                            <td><%=bill.getDate()%></td>
                                            <td><%=bill.getNote()%></td>
                                            <td><%if (bill.getStatus()==1) {%>
                                                Đã xác nhận
                                                <%} else if(bill.getStatus()==2){%>
                                                Đã hủy
                                                <%} else if(bill.getStatus()==0){%>
                                                <button type="button" 
                                                        class="btn btn-success submit"
                                                        submit-bill="1"
                                                        submit-bill-id="<%=bill.getBillID()%>">Xác nhận</button> 
                                                <button type="button" 
                                                        class="btn btn-danger cancel"
                                                        cancel-bill="2"
                                                        cancel-bill-id="<%=bill.getBillID()%>">Hủy</button></td>
                                                <%}%>
                                        </tr>
                                        <%}%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!--content end-->
                <jsp:include page="footer.jsp"/>
            </div>
        </div>
        <jsp:include page="importJS.jsp"></jsp:include>
            <script type="text/javascript">
                $('.submit').on('click', function (event) {
                    var billID = $(this).attr("submit-bill-id");
                    var value = $(this).attr("submit-bill");
                    if (value) {
                        location.href = '${root}/managerBillServlet?command=submit&status=' + value+'&billID='+billID;
                    }
                });
                $('.cancel').on('click', function (event) {
                    var billID = $(this).attr("cancel-bill-id");
                    var value = $(this).attr("cancel-bill");
                    if (value) {
                        location.href = '${root}/managerBillServlet?command=cancel&status=' + value+'&billID='+billID;
                    }
                });
        </script>
    </body>
</html>
