<%@page import="model.Item"%>
<%@page import="java.util.Map"%>
<%@page import="model.Cart"%>
<%@page import="model.Users"%>
<%@page import="dao.FashionDAO" %>
<%@page import="model.Fashion" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" href="css/style.css" type="text/css" media="all"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link rel="stylesheet" href="css/bootstrap.min.css"/>
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="css/all.css" type="text/css">
        <link rel="stylesheet" href="css/webheaderstyle.css" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="css/slick/slick.css"/>
        <link rel="stylesheet" type="text/css" href="css/slick/slick-theme.css"/>
        <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css"/>
        <script type="text/javascript" src="css/slick/slick.min.js"></script>
    </head>
    <body>
        <%
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }
            FashionDAO fashionDAO = new FashionDAO();
            Users users = null;
            if (session.getAttribute("user") != null) {
                users = (Users) session.getAttribute("user");
            }
        %>
        <div class="header">
            <div class="header-top" style="background: #ffffff">
                <div class="container">
                    <!-- <div class="row"> -->
                    <div class="header-top-in">
                        <span class="logo">
                            <a href="index.jsp"><img src="images/logo_gumac.jpg" alt=" " width="147px"></a>
                        </span>
                    </div>
                    <div class="header-top-right">
                        <ul class="navi-level-1 nav">
                            <li class="search-form">
                                <div name="box-search" class="box_search">
                                    <span class="search">
                                        <input id="txtSearch" type="text" name="text-search" style="width: 330px !important"
                                               placeholder="Nhập nội dung tìm kiếm.." >
                                    </span>
                                </div>
                            </li>

                            <li class="">
                                <a href="recharge.jsp">
                                    <img src="images/phone-number.png" alt="GUMAC" title="GUMAC" width="25px">
                                    <span class="">NẠP TÀI KHOẢN</span>
                                </a>

                            </li>
                            <li class="">
                                <a href="purchaseHistory.jsp">
                                    <img src="images/theodoidonhang.png" alt="GUMAC" title="GUMAC" width="25px">
                                    <span class="">Lịch sử mua hàng</span>
                                </a>
                            </li>
                            <li id="icon-login">
                                <% if (users != null) {%>
                                <a href="#">
                                    <img src="images/dangnhap.png" width="25px">
                                    <span><%= users.getUserName()%></span>
                                </a>
                                <ul class="navi-level-2 form-group">
                                    <li class="bottom">
                                        Số dư: <fmt:formatNumber pattern="#,##0" value="<%= users.getUserDollar()%>" /> đ
                                    </li>
                                    <li>
                                        <button class="btm btn-info" onclick="location.href = 'recharge.jsp'" >nạp tiền</button>
                                    </li>
                                    <li>
                                        <button class="btm btn-info" onclick="location.href = 'editUser.jsp'" >Chỉnh sửa thông tin</button>
                                    </li>
                                    <li>
                                        <button class="btn login form-control" onclick="location.href = 'logout.jsp'">Đăng
                                            xuất
                                        </button>
                                    </li>
                                </ul>
                                <% } else { %>
                                <a href="login.jsp" onclick="">
                                    <img src="images/dangnhap.png" alt="GUMAC" title="GUMAC" width="25px"><span class="">Đăng nhập</span>
                                </a>
                                <ul class="navi-level-2 form-group">
                                    <li id="aaa">
                                        <button class="btn login form-control aaa" onclick="location.href = 'login.jsp'">Đăng
                                            nhập
                                        </button>
                                    </li>
                                    <li>
                                        <button class="btn login form-control" onclick="location.href = 'registration.jsp'">Tạo tài
                                            khoản
                                        </button>
                                    </li>
                                    <li>
                                        <button class="btn fb form-control" onclick="location.href = 'https://www.facebook.com/dialog/oauth?client_id=1111495145565142&redirect_uri=https://localhost:8443/GOM-NB/login-facebook'">
                                            <i class="fab fa-facebook-f"> | Đăng nhập bằng Facebook</i>
                                        </button>
                                    </li>
                                    <li>
                                        <button class="btn gplus form-control" onclick="location.href = 'https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=https://localhost:8443/GOM-NB/login-google&response_type=code&client_id=480987340761-49kq3abph4d02uosnk80luredhabcgeh.apps.googleusercontent.com&approval_prompt=force'">
                                            <i class="fab fa-google-plus-square">| Đăng nhập bằng Google</i>
                                        </button>
                                    </li>
                                </ul>
                                <% }%>
                            </li>
                            <li class="icon-cart-header">
                                <a class="user_cart" href="#">
                                    <img width="25px" 
                                         src="images/giohang.png" > Giỏ hàng
                                    <span class="cart_num"><%= cart.countItem()%></span>
                                </a>
                                <div id="info-icon-cart">

                                    <style>
                                        #info-icon-cart .top-cart-header .list-gif {
                                            display: none !important;
                                        }

                                        .list-gif li label {
                                            font-weight: normal;
                                        }
                                    </style>

                                    <div class="cart_contain smallscroll_header">
                                        <% for (Map.Entry<Long, Item> list : cart.getCartItems().entrySet()) {%>
                                        <div class="cart_item">
                                            <div class="row">
                                                <div class="col-xs-3">
                                                    <div class="cart_item_img">
                                                        <img src="<%=list.getValue().getProduct().getProductImg()%>"
                                                             width="100%" 
                                                             alt="<%=list.getValue().getProduct().getProductName()%>">
                                                        <span class="cart_item_quantity">
                                                            <%=list.getValue().getQuantity()%>
                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="col-xs-9">
                                                    <p class="cart_item_name"><%=list.getValue().getProduct().getProductName()%></p>
                                                    <p class="cart_item_standard">Màu: <%=list.getValue().getProduct().getProductColor()%></p>
                                                    <p class="cart_item_standard">Size: <%=list.getValue().getSize()%></p>
                                                    <p class="cart_item_price">
                                                        <fmt:formatNumber pattern="#,##0" value="<%= list.getValue().getProduct().getProductPrice()%>" />  đ
                                                    </p>
                                                    <a class="cart_item_del pull-right" 
                                                       style="padding:0 !important;" 
                                                       href="CartServlet?command=remove&productID=<%=list.getValue().getProduct().getProductID()%>">
                                                        <img width="25px"  
                                                             src="images/thungrac.png" >
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <%}%>
                                    </div>

                                    <div style="padding:0 15px 15px 15px;">
                                        <% if (cart.getCartItems().size() != 0) {%>
                                        <a class="addToCart_btn" 
                                           href="cart.jsp" 
                                           style="padding:8px 10px !important; font-size: 18px !important;">Xác nhận đơn hàng</a>
                                        <%} else {%>
                                        giỏ hàng trống
                                        <%}%>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="clearfix" style="clear: both;"></div>
            <div class="header-bottom">
                <div class="container">
                    <div class="hidden-xs">
                        <div class="contentRight">
                            <div class="navHome" id="cssmenu" itemtype="http://schema.org/SiteNavigationElement" itemscope="">
                                <ul>
                                    <li class="had-sub">
                                        <a href="fashion.jsp?fashion=1">
                                            <img
                                                title=""
                                                class="menu-image"
                                                alt=""
                                                src="images/thoitrang.png"
                                                data-src="images/thoitrang.png"
                                                data-hover="images/thoitrang.png"><span>Thời Trang</span> </a>
                                        <ul class="level2">
                                            <% for (Fashion fashion : fashionDAO.getListFashion()) {%>
                                            <li class="had-sub-2 col-sm-6 pull-left">
                                                <a href="fashion.jsp?fashion=<%=fashion.getFashionId()%>" 
                                                   onMouseOver="this.style.background = '#FFFFFF'"><%= fashion.getFashionName()%>
                                                    <span class="pull-right">
                                                        <i class="fa fa-caret-right" aria-hidden="true"></i>
                                                    </span>
                                                </a>
                                            </li>
                                            <%
                                                }
                                            %>
                                        </ul>
                                    </li>
                                    <li>
                                        <a href="showroom.jsp">
                                            <img title=""
                                                 class="menu-image"
                                                 alt=""
                                                 src="images/showroom.png"
                                                 data-src="images/showroom.png"
                                                 data-hover="images/showroom.png">
                                            <span>Showroom</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="introduce.jsp">
                                            <img title=""
                                                 class="menu-image"
                                                 alt=""
                                                 src="images/gioithieu.png"
                                                 data-src="images/gioithieu.png"
                                                 data-hover="images/gioithieu.png">
                                            <span>Giới thiệu</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="purchaseHistory.jsp">
                                            <img title=""
                                                 class="menu-image"
                                                 alt=""
                                                 src="images/lookbook.png"
                                                 data-src="images/lookbook.png"
                                                 data-hover="images/lookbook.png">
                                            <span>LookBook</span>
                                        </a>
                                    </li>
                                    <SCRIPT>
                                        $(document).ready(function () {
                                            $("#cssmenu ul li").hover(
                                                    function () {
                                                        var img = $(this).find("img.menu-image").attr("data-hover");
                                                        $(this).find("img.menu-image").attr("src", img);
                                                    }, function () {
                                                var img = $(this).find("img.menu-image").attr("data-src");
                                                $(this).find("img.menu-image").attr("src", img);
                                            }
                                            );
                                        });
                                    </SCRIPT>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <DIV class="clear"></DIV>
                </div>
            </div>
        </div>
        <div class="clearfix" style="clear: both"></div>
        <br /> <br />
    </body>
    <script type="text/javascript">
        $('#txtSearch').keypress(function (event) {
            if (event.keyCode == 13) {
                var textSearch = $("#txtSearch").val();
                location.href = "search.jsp?txt-search="+textSearch;
            }
        });
    </script>
</html>
