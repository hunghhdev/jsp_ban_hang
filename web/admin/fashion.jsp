<%@page import="java.util.ArrayList"%>
<%@page import="dao.FashionDAO" %>
<%@page import="model.Fashion" %>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <c:set var="root" value="${pageContext.request.contextPath}"/>
        <title>Danh sách sản phẩm</title>
    </head>
    <body id="page-top">
        <% 
            FashionDAO fashionDAO = new FashionDAO();
            ArrayList<Fashion> listFashion = fashionDAO.getListFashion();
        %>
        <jsp:include page="header.jsp"></jsp:include>
            <div id="wrapper">
            <jsp:include page="menu.jsp" />
            <div id="content-wrapper">
                <div class="container-fluid">
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">
                        Thêm mới
                    </button>
                    <div class="card mb-3">
                        <div class="card-header">
                            <i class="fas fa-table"></i>
                            Danh sách</div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>STT</th>
                                            <th>Mã danh mục</th>
                                            <th>Danh mục</th>
                                            <th style="width: 100px"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% int i = 0;
                                            for (Fashion fashion : listFashion) {
                                        %>
                                        <tr>
                                            <td><%=++i%></td>
                                            <td><%=fashion.getFashionId()%></td>
                                            <td><%=fashion.getFashionName()%></td>
                                            <!--data-target="#updateData"--> 
                                            <td><button type="button"
                                                        class="btn btn-info btnEdit" 
                                                        data-toggle="modal" 
                                                        my-data="<%=fashion.getFashionName()%>"
                                                        my-id="<%=fashion.getFashionId()%>">Sửa</button> 
                                                <button type="button" class="btn btn-info" onclick="deleteFashion(<%=fashion.getFashionId()%>)">Xóa</button></td>
                                        </tr>
                                        <%}%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <jsp:include page="footer.jsp"/>
            </div>
        </div>
        <jsp:include page="importJS.jsp"></jsp:include>
            <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">Thêm danh mục</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="card-body">
                            <form>
                                <div class="form-group">
                                    <div class="form-label-group">
                                        <input type="text" id="inputFashion" name="inputFashion" class="form-control" placeholder="Màu sắc" required="required">
                                        <label for="inputFashion">Thời trang</label>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="button" class="btn btn-primary" onclick="insertFashion()">Save changes</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="updateData" 
                 tabindex="-1" role="dialog" 
                 aria-labelledby="updateDataCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="updateDataLongTitle">Sửa danh mục</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="card-body">
                            <form>
                                <div class="form-group">
                                    <div class="form-label-group">
                                        <input id="inputUpdateID" name="inputUpdateID" 
                                               class="form-control inputUpdateID" type="text" hidden  >
                                        <input type="text" id="inputUpdate" name="inputUpdate" 
                                               class="form-control .inputUpdate" 
                                               placeholder="Thời trang" required="required">
                                        <label for="inputUpdate">Thời trang</label>

                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="button" class="btn btn-primary" onclick="updateFashion()">Save changes</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <script type="text/javascript" charset="UTF-8">
                function deleteFashion(value) {
                    location.href = '${root}/ManagerFashionController?command=delete&id=' + value;
                }
                function insertFashion() {
                    var value = document.getElementById("inputFashion").value;
                    location.href = '${root}/ManagerFashionController?command=insert&fashion=' + value;
                }
                function updateFashion() {
                    var value = document.getElementById("inputUpdate").value;
                    var valueID = document.getElementById("inputUpdateID").value;
                    if (value) {
                        location.href = '${root}/ManagerFashionController?command=update&fashion=' + value + '&id=' + valueID;
                    }
                }
                $('.btnEdit').on('click', function (event) {
                    $("#inputUpdate").val($(this).attr("my-data"));
                    $("#inputUpdateID").val($(this).attr("my-id"));
                    $('#updateData').modal();
                });
        </script>
    </body>
</html>
