<%@page import="model.Item"%>
<%@page import="java.util.Map"%>
<%@page import="model.Users"%>
<%@page import="dao.FashionDAO"%>
<%@page import="model.Cart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thanh toán</title>
        <link rel="stylesheet" href="css/bootstrap.min.css"/>
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="css/webheaderstyle.css" type="text/css"/>
        <link rel="stylesheet" href="css/cart.css" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css"/>
    </head>
    <body>
        <%
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }
            Users users = null;
            if (session.getAttribute("user") != null) {
                users = (Users) session.getAttribute("user");
            } else {
                response.sendRedirect("login.jsp");
            }
        %>
        <div>
            <div id="one_maincolumn" class="main_column">
                <div id="undercolumn">
                    <div id="undercolumn_cart">
                        <div class="clearfix"></div>

                        <form>
                            <div style="overflow:auto;">
                                <div class="col-md-7">
                                    <!-- Customer Cart -->
                                    <div class="customer_cart">
                                        <div class="cart_header">
                                            <a href="index.jsp">
                                                <img style="padding:5px 0;" 
                                                     width="220px" 
                                                     src="images/logo_gumac.jpg"
                                                     >
                                            </a>
                                        </div>
                                        <div class="cart_breadcrumb" style="margin:20px 0;">
                                            <span><i class="fa fa-caret-right" aria-hidden="true"></i></span>  Thông tin đơn hàng
                                        </div>
                                        <div style="margin: 30px 0; display:none;">
                                            <p style="color:#f00;font-weight:bold; padding: 15px;border:1px solid #f00;">
                                                LƯU Ý: CHƯƠNG TRÌNH MUA 1 TẶNG 1 CHỈ ÁP DỤNG CHO MUA HÀNG TRỰC TIẾP TẠI CỬA HÀNG. KHÔNG ÁP DỤNG CHO KHÁCH MUA HÀNG ONLINE.
                                            </p>
                                        </div>
                                        <div class="cus_info_new">
                                            <div class="mypage_tt">
                                                <h4>Thông tin giao hàng</h4>
                                            </div>
                                            <div class="clear"></div>

                                            <div>
                                                <div class="row">
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <input value="<% if (users != null)%><%=users.getUserName()%>" 
                                                                   type="text" 
                                                                   placeholder="Họ & Tên" 
                                                                   name="w-fullname" id="w-fullname" 
                                                                   maxlength="160" style="width: 250px" >
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <input value="<% if (users != null)%><%=users.getUserEmail()%>" 
                                                                   type="text" 
                                                                   placeholder="Email" 
                                                                   name="w-email" 
                                                                   id="w-email" style="width: 250px" >
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">

                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <input type="text" 
                                                                   placeholder="Điện thoại" 
                                                                   name="w-phone" id="w-phone" 
                                                                   value="<% if (users != null)%><%=users.getUserPhone()%>" 
                                                                   maxlength="40"
                                                                   style="width: 250px">
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="form-group">
                                                            <input value="" 
                                                                   type="text" 
                                                                   placeholder="Địa chỉ" 
                                                                   name="w-address" id="w-address" 
                                                                   style="width: 250px">
                                                        </div>
                                                    </div>
                                                </div>



                                                <div class="form-group">
                                                    <div class="col-sm-6">
                                                        <label  for="w-payment">Cách thanh toán</label>
                                                        <select class="form-control" id="w-payment" name="w-payment" style="width: 235px">
                                                            <option value="live">Thanh toán khi nhận hàng</option>
                                                            <option value="accountPayment">Số dư</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <textarea style="width: 250px" placeholder="Ghi chú cho GUMAC" name="Note" id="Note"></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                            <br /> <br /> <br />
                                            <script type="text/javascript"></script>
                                            <div class="status_order">
                                                <p>
                                                    <label style="display:block;" class="">

                                                        ĐƠN HÀNG CỦA QUÝ KHÁCH SẼ ĐƯỢC TỰ ĐÔNG GỬI KHI HOÀN TẤT ĐƠN HÀNG,QUÝ KHÁCH VUI LÒNG KIỂM TRA LẠI THÔNG TIN ĐƠN HÀNG CHÍNH XÁC TRƯỚC KHI BẤM HOÀN TẤT.<br> XIN CÁM ƠN!
                                                        <span class="pull-right hidden">
                                                            <div class="icheckbox_minimal-orangecustom checked" aria-checked="false" aria-disabled="false" style="position: relative;"><input type="checkbox" id="ckbAdvice" class="minimal" name="chooseStatus" value="1" data-sub_id="104" checked="" style="position: absolute; opacity: 0;"><ins class="iCheck-helper" style="position: absolute; top: 0%; left: 0%; display: block; width: 100%; height: 100%; margin: 0px; padding: 0px; background: rgb(255, 255, 255); border: 0px; opacity: 0;"></ins></div>
                                                        </span>
                                                    </label>
                                                </p>

                                                <input type="hidden" name="StatusID" value="1">
                                                <input type="hidden" name="SubStatusID" value="104">
                                            </div>
                                            <div style="padding:0 15px 15px 600px;">
                                                <% if (cart.getCartItems().size() != 0) {%>
                                                <a onclick="checkOut()"
                                                        class="addToCart_btn btagree_gs btn-danger"
                                                        style="padding:8px 10px !important; font-size: 18px !important;">Xác nhận đơn hàng</a>
                                                <%}%>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                    <!-- End div Customer Cart -->
                                </div>

                                <div class="col-md-5 grey_cart" style="min-height: 758px;">
                                    <div id="list-cart-home" class="cart_items">
                                        <div id="item_in_cart">


                                            <style>
                                                #info-icon-cart .top-cart-header .list-gif {
                                                    display: none !important;
                                                }

                                                .list-gif li label {
                                                    font-weight: normal;
                                                }
                                            </style>

                                            <div>
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
                                                            <p>
                                                                <span class="pull-left" style="padding: 3px 5px 3px 0;">Số lượng</span>
                                                                <input id="quantityNew<%=list.getValue().getProduct().getProductID()%>" name="quantityNew<%=list.getValue().getProduct().getProductID()%>" min="1"
                                                                       onchange="changeQuantity(<%=list.getKey()%>)"
                                                                       type="number" value="<%=list.getValue().getQuantity()%>"/>
                                                            </p>
                                                            <a class="cart_item_del pull-right" style="padding:0 !important;" 
                                                               href="CartServlet?command=removeCheckout&productID=<%=list.getValue().getProduct().getProductID()%>">
                                                                <img width="25px"  
                                                                     src="images/thungrac.png" >
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <%}%>
                                            </div>

                                        </div>
                                        <div class="cart_item">


                                            <div class="attention">
                                                <b>Lưu ý: VCSN chỉ áp dụng cho đơn hàng giá niêm yết tối đa 2 triệu. Phần tiền dư sẽ được cộng vào nguyên giá.</b>
                                            </div>

                                        </div>

                                        <div class="cart_item">
                                            <div class="price_cart">
                                                <div class="price_title_cart">Tổng cộng</div>
                                                <div class="price_content_cart">
                                                    <div class="row-discount-cart-item row-payment-total">
                                                        <span class="payment"><fmt:formatNumber pattern="#,##0" value="<%=cart.totalCart()%>" /> đ</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>                                    
                                    </div>
                                    <div class="attention" style="margin-bottom:15px;">
                                        <b>Đơn hàng SP đã được kiểm tra kĩ trước khi đóng gói-niêm phong. Quý khách vui lòng thánh toán tiền trước khi nhận hàng</b>
                                    </div>                                 
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script type="text/javascript">
        function changeQuantity(productID) {
            var command = 'plusCheckOut';
            var quantityNew = document.getElementById("quantityNew" + productID).value;
            $.ajax({
                method: "POST",
                url: "CartServlet",
                data: {command: command, productID: productID, quantityNew: quantityNew}
            }).done(function (response) {
                location.reload();
            });
        }
        function checkOut() {
            var fullname = $("#w-fullname").val();
            var email = $("#w-email").val();
            var phone = $("#w-phone").val();
            var address = $("#w-address").val();
            var payment = $("#w-payment").val();
            var Note = $("#Note").val();
            $.ajax({
                method: "POST",
                url: "CheckOutServlet",
                data: {fullname: fullname, email: email, phone: phone, address: address, payment: payment, note: Note},
                success : function(responseText) {
                    if(responseText==="1"){
                        alert("Tài khoản của bạn không đủ tiền, chọn cách thanh toán khác");
                    }
                    if(responseText==="0"){
                        alert("Đơn hàng của bạn đang được xử lý, vui lòng kiểm tra lại mail");
                        location.href = "index.jsp";
                    }
                }
            });
        }
    </script>
</html>
