<%@page import="model.Cart"%>
<%@page import="model.Fashion"%>
<%@page import="dao.FashionDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Product"%>
<%@page import="dao.ProductDAO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/webfilterproductstyle.css" type="text/css" />
        <link rel="stylesheet" href="css/webproductdetailstyle.css" type="text/css" />
        <link rel="stylesheet" href="css/webproductliststyle.css" type="text/css" />
        <script src="js/xzoom.min.js" type="text/javascript"></script>
        <%
            Cart cart = ((Cart) session.getAttribute("cart"));
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }
            ProductDAO productDAO = new ProductDAO();
            FashionDAO fashionDAO = new FashionDAO();
            Product product = new Product();
            String productId = "";
            if (request.getParameter("id") != null) {
                productId = request.getParameter("id");
                product = productDAO.getProductById(Long.parseLong(productId));
            }
            if (productId == null || productId.isEmpty()) {
                response.sendRedirect("index.jsp");
            }
            if (product == null) {
                response.sendRedirect("index.jsp");
            }
            Fashion fashion = fashionDAO.getFashionById(product.getFashionID());
        %>
        <title><%= product.getProductName()%></title>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <br /> <br /> <br/> <br /> <br />
            <div class="productDetail">
                <div class="singleProduct">
                    <div class="container">
                        <div class="top-detail">
                            <div class="col-md-12 col-sm-12">
                                <div class="filterProduct clearfix">
                                    <h5 class="pro_title breadcrumbwrap" itemprop="breadcrumb">
                                        <a class="breadcrumbitem" href="index.jsp">home</a>                                         
                                        <span><i class="fa fa-caret-right" aria-hidden="true"></i></span>                
                                        <a class="breadcrumbitem" href=""><%= fashion.getFashionName()%></a>               
                                    <span><i class="fa fa-caret-right" aria-hidden="true"></i></span>  
                                    <a class="breadcrumbitem" href=""><%= product.getProductName()%></a>          
                                </h5>
                            </div>
                        </div>
                        <div class="clearfix" style="clear: both;"></div>
                        <div class="sharefb-pc"></div>
                        <div class="clearfix" style="clear: both;"></div>
                        <div id="singleProductImg" class="col-md-9 col-sm-9 no-padding-xs">
                            <div id="MS10869" itemscope="" itemtype="http://schema.org/Product">
                                <div class="col-md-7 col-sm-7">
                                    <div class="img_singleProduct">
                                        <div class="large-5 column" >
                                            <div class="xzoom-container">
                                                <div id="xzoom-img" class="col-sm-10" style="padding:0;">
                                                    <img id="xzoom-default" 
                                                         class="xzoom" 
                                                         src="<%= product.getProductImg()%>" 
                                                         xoriginal="<%= product.getProductImg()%>" 
                                                         alt="" 
                                                         title="" 
                                                         height="487px"
                                                         width="350px"
                                                         style="width: 100%;">
                                                </div>
                                                <div id="xzoom-thumbs" class="xzoom-thumbs col-sm-2 pull-left" >

                                                </div>
                                                <script>
                                                    $(document).ready(function () {
                                                        $('#zoom-id').zoom();
                                                    });
                                                </script>
                                            </div>
                                            <div class="large-7 column"></div>
                                        </div>
                                    </div>							
                                </div>
                                <div class="col-md-5 col-sm-5 no-padding">
                                    <div class="detail-singleProduct">
                                        <br />
                                        <div class="box_top">
                                            <h2><%= product.getProductName()%></h2>
                                            <table class="price">
                                                <tbody>
                                                    <tr>
                                                        <td class="newPrice">
                                                            <span class="newPrice_content">
                                                                <span id="price_12" class="price2">
                                                                    <fmt:formatNumber pattern="#,##0" value="<%= product.getProductPrice()%>" /> 
                                                                </span>
                                                                <span>VNĐ</span>
                                                            </span>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>

                                            <div class="intro_detail">
                                                <p>- Mã sản phẩm: <%= product.getProductID()%></p>
                                                <p>- Giá bán: <fmt:formatNumber pattern="#,##0" value="<%= product.getProductPrice()%>" /></p>
                                                <p>- Chất liệu vải: <%= product.getFabricMaterial()%></p>
                                                <p>- Màu sắc: <%= product.getProductColor()%></p>
                                                <p>- Chi tiết sản phẩm: <%= product.getProductDetail()%></p>
                                                <p>- Size: <% if (product.getProductSize().isXs()) {%>XS <%}%>
                                                    <% if (product.getProductSize().isS()) {%>- S <%}%>
                                                    <% if (product.getProductSize().isM()) {%>- M <%}%>
                                                    <% if (product.getProductSize().isL()) {%>- L <%}%>
                                                    <% if (product.getProductSize().isXl()) {%>- XL <%}%>
                                                </p>
                                                <% if (!product.getProductDescription().isEmpty()) {%>
                                                <p>- <%= product.getProductDescription()%></p>
                                                <% }%>
                                            </div>
                                            <form action="POST">
                                                <div class="classlist">
                                                    <ul class="clearfix">
                                                        <li name="content_id2">
                                                            <label class="lb_size_gs" title="XS">
                                                                <input id="xs" 
                                                                       name="productSize" 
                                                                       value="XS" 
                                                                       type="radio" 
                                                                       title="XS" 
                                                                       checked>
                                                                <span class="box_mausac">
                                                                    XS
                                                                </span>
                                                            </label>
                                                            <label class="lb_size_gs" title="S">
                                                                <input id="s" name="productSize" value="S" type="radio" title="S">
                                                                <span class="box_mausac">
                                                                    S
                                                                </span>
                                                            </label>
                                                            <label class="lb_size_gs" title="M">
                                                                <input id="m" name="productSize" value="M" type="radio" title="M">
                                                                <span class="box_mausac">
                                                                    M
                                                                </span>
                                                            </label>
                                                            <label class="lb_size_gs" title="L">
                                                                <input id="l" name="productSize" value="L" type="radio" title="L">
                                                                <span class="box_mausac">
                                                                    L
                                                                </span>
                                                            </label>
                                                            <label class="lb_size_gs" title="XL">
                                                                <input id="xl" name="productSize" value="XL" type="radio" title="XL">
                                                                <span class="box_mausac">
                                                                    XL
                                                                </span>
                                                            </label>
                                                        </li>
                                                    </ul>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-3 col-sm-3">
                            <div style="overflow: auto; margin: 20px 0; ">
                                <div class="ship_change">
                                    <div class="ship_change_item">
                                        <span>
                                            Miễn phí ship đơn hàng trên 500k (Điều kiện cùng một cửa hàng)
                                        </span>
                                    </div>
                                    <div class="clearfix" style="clear:both"></div>
                                    <div class="ship_change_item">
                                        <span>
                                            Giao hàng toàn quốc. Miễn phí đổi hàng 7 ngày
                                        </span>
                                    </div>
                                    <div class="clearfix" style="clear:both"></div>
                                    <div class="ship_change_item">
                                        <span>
                                            Thanh toán khi nhận hàng Miễn Phí
                                        </span>
                                    </div>
                                    <br />
                                </div>
                                <div class="free_ship_change">
                                    <span class="btn-xs btn-normal">Miễn phí (Free)</span>
                                </div>
                            </div>
                            <script type="text/javascript">
                                function checkSize() {
                                    var radioValue = $("input[name='productSize']:checked").val();
                                    if (radioValue) {
                                        location.href = 'CartServlet?command=plus&productID=<%=product.getProductID()%>&productSize=' + radioValue;
                                    }
                                }
                            </script>
                            <div class="left_content">
                                <div class="cartin">
                                    <div class="cartin_btn">
                                        <div id="cartbtn_default">
                                            <a class="addToCart_btn">Mua ngay</a>
                                            <div class="addmorecart_content">
                                                <a class="green_addtocart_btn" onclick="checkSize()">
                                                    <img style="padding:5px 0;" width="20px" src="images/thungrac.png" alt="GUMAC" title="GUMAC" />
                                                    Thêm vào giỏ hàng
                                                </a>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div class="attention" id="cartbtn_dynamic"></div>
                                <div class="help_dt">
                                    <style>
                                        /*fix text wrapping*/
                                        ul.nav.nav-tabs.txtUpper.clearfix.js-productInfoTab {
                                            white-space: nowrap;
                                        }

                                        span.nav-subTxt {
                                            white-space: nowrap;
                                        }

                                        a.sel-cat-brands {
                                            white-space: nowrap;
                                        }

                                        span.js-nav-hd {
                                            white-space: nowrap;
                                        }

                                        .b-shoppingBag__viewBag.lfloat {
                                            white-space: nowrap;
                                        }
                                    </style>
                                    <p style="margin-bottom: 10px; font-size: 18px;" class="strong">BẠN CẦN HỖ TRỢ</p>
                                    <p style="margin-bottom: 10px;">HÃY LIÊN HỆ: 0972.333.444</p>
                                    <p style="font-size:13px;color:#929292">
                                        Thời gian làm việc: 08h:00 - 17h00 <br />(Từ thứ 2 - đến thứ 7)<br>
                                    </p>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="clearfix" style="clear: both"></div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
