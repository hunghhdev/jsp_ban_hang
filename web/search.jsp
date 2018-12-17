<%@page import="model.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.ProductDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kết quả tìm kiếm</title>
    </head>
    <body>
        <%
            ProductDAO productDAO = new ProductDAO();
            String text = "";
            ArrayList<Product> list = new ArrayList<>();
            if (request.getParameter("txt-search") != null) {
                text = request.getParameter("txt-search");
            }
        %>
        <jsp:include page="header.jsp"></jsp:include>
            <br /><br /><br /><br /><br /><br />
            <div class="list-product">
                <div class="container">
                    <div id="main-column" >
                        <div class="clear-fix title-top-product">
                            <div class="title-product">
                                <span id="span-cate-title">Danh sách sản phẩm</span>
                            </div>				
                        </div>
                        <!-- ảnh quần áo -->
                        <div class="product-list">

                        <%
                            if (text == null || text.isEmpty()) {
                                list = productDAO.getAllListProduct();
                            } else {
                                list = productDAO.getSearchListProduct(text);
                            }
                            for (Product P : list) {
                        %>
                        <div class="item-product-list col-lg-3 col-md-4 col-sm-6 col-xs-6">
                            <div class="product-item">	
                                <div class="photo-item">	
                                    <a class="product-url" href="product.jsp?id=<%= P.getProductID()%>">
                                        <img src="<%= P.getProductImg()%>" 
                                             alt="<%= P.getProductName()%>" 
                                             title="<%= P.getProductName()%>" 
                                             width="100%">
                                    </a>
                                </div>
                                <div class="pro-infor">
                                    <h3 class="titleProduct">
                                        <a href="product.jsp?id=<%= P.getProductID()%>" class="product_url">
                                            <%= P.getProductName()%>
                                        </a>
                                    </h3>
                                    <div class="price">
                                        <span class="sale_price_list_gs">
                                            <fmt:formatNumber pattern="#,##0" value="<%= P.getProductPrice()%>" /> VND
                                        </span>              
                                    </div>
                                </div>					
                            </div>				
                        </div>
                        <%
                            }
                        %>

                        <div class="clearfix"></div>

                        <div class="btnLoadMoreContainer">
                            <div class="btnLoadDrop">
                                <div id="btnLoadMore" class="btn btnLoadMore" onclick="" >Xem thêm sản phẩm</div>					
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="clearfix" style="clear: both"></div>
            <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
