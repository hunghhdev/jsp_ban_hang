<%@page import="dao.ProductDAO"%>
<%@page import="dao.BillDetailDAO"%>
<%@page import="model.BillDetail"%>
<%@page import="dao.BillDAO"%>
<%@page import="model.Users"%>
<%@page import="model.Bill"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lịch sử</title>
    </head>
    <body>
        <%
            BillDAO billDAO = new BillDAO();
            BillDetailDAO billDetailDAO = new BillDetailDAO();
            ProductDAO productDAO = new ProductDAO();
            Users users = (Users) session.getAttribute("user");
            if (session.getAttribute("user") == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            ArrayList<Bill> list = billDAO.getListBillByUserId(users.getUserId());
        %>
        <jsp:include page="header.jsp"></jsp:include>
            <div class="container">
                <div class="content_body" style="margin-top: 129px;">
                    <div class="title_top_product" style="text-align: left">
                        <i class="fas fa-table"></i>
                        Lịch sử mua hàng</div>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Mã đơn hàng</th>
                                <th>Tổng tiền</th>
                                <th>Sản phẩm</th>
                                <th>Ngày mua</th>
                                <th>Nơi nhận</th>
                                <th>Tình trạng</th>
                            </tr>
                        </thead>
                        <tbody>
                        <%for (Bill bill : list) {%>
                        <tr>
                            <td><%=bill.getBillID()%></td>
                            <td><fmt:formatNumber pattern="#,##0" value="<%=bill.getTotal()%>" /></td>
                            <td>
                                <ul>
                                    <%for (BillDetail billDetail : billDetailDAO.getBillDetailsByBillId(bill.getBillID())) {%>
                                    <li><a href="product.jsp?id=<%=billDetail.getBillID()%>">
                                            <%=productDAO.getProductById(billDetail.getProductID()).getProductName()%>
                                        </a> - Số lượng <%=billDetail.getQuantity()%>
                                    </li>
                                    <%}%>
                                </ul>

                            </td>
                            <td><%=bill.getDate()%></td>
                            <td><%=bill.getAddress()%></td>
                            <td>
                                <%if (bill.getStatus() == 1) {%>
                                Đã xác nhận
                                <%} else if (bill.getStatus() == 2) {%>
                                Đã hủy
                                <%} else if (bill.getStatus() == 0) {%>
                                Chưa xử lý
                                <%}%>
                            </td>

                        </tr>
                        <%}%>
                    </tbody>
                </table>
            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
