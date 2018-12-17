<%@page import="model.adminBO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <c:set var="root" value="${pageContext.request.contextPath}"/>
    </head>
    <body>
        <%
            adminBO admin = (adminBO) session.getAttribute("adminBo");
        %>
        <ul class="sidebar navbar-nav">
            <li class="nav-item active">
                <a class="nav-link" href="index.jsp">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Sản phẩm</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="fashion.jsp">
                    <i class="fas fa-fw fa-chart-area"></i>
                    <span>Danh mục</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="bill.jsp">
                    <i class="fas fa-money-bill"></i>
                    <span>Đơn hàng</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="customer.jsp">
                    <i class="fas fa-users"></i>
                    <span>Khách hàng</span></a>
            </li>
            <%if (admin.getRole()==9) {%>
            <li class="nav-item">
                <a class="nav-link" href="users.jsp">
                    <i class="fas fa-user-secret"></i>
                    <span>Quản lý nhân viên</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${root}/chartServlet">
                    <i class="fas fa-user"></i>
                    <span>Thống kê</span></a>
            </li>
            <%}%>
        </ul>
    </body>
</html>
