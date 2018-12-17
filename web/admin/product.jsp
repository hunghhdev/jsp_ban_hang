<%@page import="java.util.ArrayList"%>
<%@page import="dao.ProductDAO" %>
<%@page import="dao.FashionDAO" %>
<%@page import="model.Product" %>
<%@page import="model.Fashion" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <c:set var="root" value="${pageContext.request.contextPath}"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sản phẩm</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="vendor/jquery/jquery.min.js"></script>
    </head>
    <body>
        <%
            ProductDAO productDao = new ProductDAO();
            ArrayList<Product> productList = productDao.getAllListProduct();
            FashionDAO fashionDAO = new FashionDAO();
            ArrayList<Fashion> fashionList = fashionDAO.getListFashion();
        %>
        <div class="container-fluid">
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#insertData" onclick="addNew()">
                Thêm mới
            </button>
            <div class="card mb-3">
                <div class="card-header">
                    <i class="fas fa-table"></i>
                    Danh sách sản phẩm</div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                    <th style="width: 30px;">STT</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Danh mục</th>
                                    <th>Hình mẫu</th>
                                    <th style="text-align: right">Giá</th>
                                    <th style="width: 100px"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% int i = 0;
                                    for (Product product : productList) {
                                %>
                                <tr>
                                    <td style="text-align: center"><%=++i%></td>
                                    <td><%=product.getProductName()%></td>
                                    <td><%=fashionDAO.getFashionById(product.getFashionID()).getFashionName()%></td>
                                    <td style="text-align: center"><img src="${root}/<%=product.getProductImg()%>" width="100px" height="100px"/></td>
                                    <td style="text-align: right"><fmt:formatNumber pattern="#,##0" value="<%= product.getProductPrice()%>" /></td>
                                    <td><button id="btnEditProduct" name="btnEditProduct" 
                                                class="btn btn-info btnEditProduct" 
                                                my-ProductId="<%=product.getProductID()%>"
                                                my-FashionId="<%=product.getFashionID()%>"
                                                my-ProductName="<%=product.getProductName()%>"
                                                my-ProductPrice="<%=product.getProductPrice()%>"
                                                my-ProductDescription="<%=product.getProductDescription()%>"
                                                my-FabricMaterial="<%=product.getFabricMaterial()%>"
                                                my-ProductDetail="<%=product.getProductDetail()%>"
                                                my-ProductColor="<%=product.getProductColor()%>"
                                                size-xs="<%=product.getProductSize().isXs()%>"
                                                size-s="<%=product.getProductSize().isS()%>"
                                                size-m="<%=product.getProductSize().isM()%>"
                                                size-l="<%=product.getProductSize().isL()%>"
                                                size-xl="<%=product.getProductSize().isXl()%>"
                                                >Sửa</button> 
                                        <button class="btn btn-info" onclick="deleteProduct(<%=product.getProductID()%>)">Xóa</button></td>
                                </tr>
                                <%}%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="insertData" 
             tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Chi tiết sản phẩm</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="card-body">
                        <form>
                            <input hidden id="inputUpdateID" name="inputUpdateID" type="text" />  
                            <div class="form-group">
                                <label for="inputFashion">Thời trang</label>
                                <select class="form-control" id="inputFashionId" name="inputFashionId">
                                    <%for (Fashion fashion : fashionList) {%>
                                    <option value="<%=fashion.getFashionId()%>"><%=fashion.getFashionName()%></option>
                                    <%}%>
                                </select>
                            </div>
                            <div class="form-group">
                                <div class="form-label-group">
                                    <input type="text" id="inputProductName" name="inputProductName" 
                                           class="form-control" placeholder="Tên sản phẩm" required="required" autofocus="autofocus">
                                    <label for="inputProductName">Tên sản phẩm</label>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="form-label-group">
                                    <input type="text" id="inputProductColor" name="inputProductColor" class="form-control" placeholder="Màu sắc" required="required">
                                    <label for="inputProductColor">Màu sắc</label>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="form-label-group">
                                    <input type="text" id="inputFabricMaterial" name="inputFabricMaterial" class="form-control" placeholder="Chất liệu" required="required">
                                    <label for="inputFabricMaterial">Chất liệu</label>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="form-label-group">
                                    <input type="text" id="inputProductDetail" name="inputProductDetail" class="form-control" placeholder="Chi tiết" required="required">
                                    <label for="inputProductDetail">Chi tiết</label>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="form-label-group">
                                    <input type="text" id="inputProductDes" name="inputProductDes" class="form-control" placeholder="Mô tả" required="required">
                                    <label for="inputProductDes">Mô tả</label>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="form-label-group">
                                    <input type="number" id="inputProductPrice" name="inputProductPrice" class="form-control" placeholder="Giá" required="required">
                                    <label for="inputProductPrice">Giá</label>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="form-check">Size: 
                                    XS<input class="form-check-inline" type="checkbox" id="checkXS" name="checkXS" />  
                                    S<input class="form-check-inline" type="checkbox" id="checkS" name="checkS" /> 
                                    M<input class="form-check-inline" type="checkbox" id="checkM" name="checkM" />
                                    L<input class="form-check-inline" type="checkbox" id="checkSizeL" name="checkSizeL"/> 
                                    XL<input class="form-check-inline" type="checkbox" id="checkXL" name="checkXL" />
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="custom-file">
                                    <input type="file" id="file" name="file" class="custom-file-input" onchange="uploadImg()" >
                                    <label class="custom-file-label" for="inputProductImg">Chọn hình</label>
                                    <input type="text" id="filename" name="filename" hidden/>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="insertProduct()">Save changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            function addNew(){
                $("#inputUpdateID").val("");
                $("#inputFashionId").val("");
                $("#inputProductName").val("");
                $("#inputProductColor").val("");
                $("#inputFabricMaterial").val("");
                $("#inputProductDetail").val("");
                $("#inputProductPrice").val("");
                $("#inputProductDes").val("");
            }
            function deleteProduct(productId) {
                var command = "delete";
                var result = confirm("Xác nhận xóa hay không?" );
                if (result) {
                    $.ajax({
                        method: "POST",
                        url: "${root}/managerProductServlet",
                        data: {command: command, productId: productId}
                    }).done(function () {
                        alert("đã xóa thành công");
                        location.reload(5);
                    }).fail(function () {
                        alert("Có lỗi rồi");
                    });
                }
                return false;
            }
            function insertProduct() {
                var productId = document.getElementById("inputUpdateID").value;
                var fashionId = document.getElementById("inputFashionId").value;
                var productName = document.getElementById("inputProductName").value;
                var productColor = document.getElementById("inputProductColor").value;
                var fabricMaterial = document.getElementById("inputFabricMaterial").value;
                var productDetail = document.getElementById("inputProductDetail").value;
                var productDes = document.getElementById("inputProductDes").value;
                var productPrice = document.getElementById("inputProductPrice").value;
                var filename = document.getElementById("filename").value;
                var command;
                if (productId) {
                    command = "update";
                } else {
                    command = "insert";
                }
                var checkXS = document.getElementById("checkXS").checked;
                var checkS = document.getElementById("checkS").checked;
                var checkM = document.getElementById("checkM").checked;
                var checkL = document.getElementById("checkSizeL").checked;
                var checkXL = document.getElementById("checkXL").checked;

                $.ajax({
                    method: "POST",
                    url: "${root}/managerProductServlet",
                    data: {command: command, productId: productId, fashionId: fashionId, productName: productName,
                        productColor: productColor, fabricMaterial: fabricMaterial, productDetail: productDetail,
                        productDes: productDes, productPrice: productPrice, filename: filename,
                        checkXS: checkXS, checkS: checkS, checkM: checkM, checkL: checkL, checkXL: checkXL}
                }).done(function (response) {
                    location.reload();
                });
            }

            function uploadImg() {
                var file = document.querySelector("input[type=file]").files[0];
                var reader = new FileReader();
                $("#filename").val(file.name);
                reader.onloadend = function () {
                    $.ajax({
                        method: "POST",
                        url: "${root}/uploadImgServlet",
                        data: {fileUpload: reader.result, filename: file.name}
                    }).done(function (response) {
                        alert("đã tải hình ảnh") + response;
                    }).fail(function (xhr, status, errorThrown) {
                        alert("Có lỗi rồi") + xhr.responseText;
                    });
                };
                if (file) {
                    reader.readAsDataURL(file);
                }
            }
            $('.btnEditProduct').on('click', function (event) {
//                var isCheck = false;
//                var checkM = $(this).prop("size-m");
                $("#inputUpdateID").val($(this).attr("my-ProductId"));
                $("#inputFashionId").val($(this).attr("my-FashionId"));
                $("#inputProductName").val($(this).attr("my-ProductName"));
                $("#inputProductColor").val($(this).attr("my-ProductColor"));
                $("#inputFabricMaterial").val($(this).attr("my-FabricMaterial"));
                $("#inputProductDetail").val($(this).attr("my-ProductDetail"));
                $("#inputProductPrice").val($(this).attr("my-ProductPrice"));
                $("#inputProductDes").val($(this).attr("my-ProductDescription"));
//                $("#checkXS").attr('checked',$(this).attr("size-xs"));
//                $("#checkS").attr('checked',$(this).attr("size-s"));
//                $("#checkM").attr('checked', checkM != isCheck);
//                $("#checkSizeL").attr('checked',$(this).attr("size-l"));
//                $("#checkXL").attr('checked',$(this).attr("size-xl"));
                $('#insertData').modal();
            });
        </script>
    </body>
</html>
