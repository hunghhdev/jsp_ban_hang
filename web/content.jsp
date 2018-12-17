<%@page import="model.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ProductDAO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <title>content</title>
    </head>
    <body>
        <%
            ProductDAO productDAO = new ProductDAO();
            ArrayList<Product> list = productDAO.getAllListProductIndex();
        %>
        <div class="content-body">
            <div class="container">
                <div class="title-content">
                    <h3 class="top-title">[TOP MỚI NHẤT]</h3>
                    <h4 class="top-subtitle"><i>New Arrival</i></h4>
                </div>
                <% for (Product product : list) {%>
                <div class="item-product-list col-lg-3 col-md-4 col-sm-6 col-xs-6">
                    <div class="product-item">
                        <div class="photo-item">
                            <a class="product-url" href="product.jsp?id=<%= product.getProductID()%>">
                                <img src="<%= product.getProductImg()%>" 
                                     alt="<%= product.getProductName()%>" 
                                     title="<%= product.getProductName()%>" width="100%">
                            </a>
                        </div>
                        <div class="pro-infor">
                            <h3 class="titleProduct">
                                <a href="product.jsp?id=<%= product.getProductID()%>" class="product_url">
                                    <%= product.getProductName()%>
                                </a>
                            </h3>
                            <div class="price">
                                <span class="sale_price_list_gs">
                                    <fmt:formatNumber pattern="#,##0" value="<%= product.getProductPrice()%>" /> đ
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                <% }%>
            </div>
        </div>

        <div class="clearfix" style="clear: both"></div>
    </body>
</html>
