<%@page import="model.adminBO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Danh sách sản phẩm</title>
    </head>
    <body id="page-top">
        <%
            adminBO admin = (adminBO) session.getAttribute("adminBo");
            if (admin == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <jsp:include page="header.jsp"></jsp:include>
            <div id="wrapper">
            <jsp:include page="menu.jsp" />
            <div id="content-wrapper">
                <jsp:include page="product.jsp" />
                <jsp:include page="footer.jsp"/>
            </div>
        </div>
        <jsp:include page="importJS.jsp"></jsp:include>
    </body>
</html>
