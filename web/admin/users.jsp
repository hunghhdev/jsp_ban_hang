<%@page import="dao.AdminDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.adminBO"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <c:set var="root" value="${pageContext.request.contextPath}"/>
        <title>Quản lý Nhân viên</title>
    </head>
    <body id="page-top">
        <%
            adminBO admin = (adminBO) session.getAttribute("adminBo");
            if (admin == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            if (admin.getRole() != 9) {
                response.sendRedirect("index.jsp");
                return;
            }
            AdminDAO adminDao = new AdminDAO();
            ArrayList<adminBO> arrayList = adminDao.getAllAdminList();
        %>
        <jsp:include page="header.jsp"></jsp:include>
            <div id="wrapper">
            <jsp:include page="menu.jsp" />
            <div id="content-wrapper">
                <!--content start-->
                <div class="container-fluid">
                    <p style="text-align: center; color: red;">${param.message}</p>
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">
                        Thêm mới
                    </button>
                    <div class="card mb-3">
                        <div class="card-header">
                            <i class="fas fa-table"></i>
                            Danh sách khách hàng</div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th style="width: 30px">STT</th>
                                            <th>Tên nhân viên</th>
                                            <th>Email</th>
                                            <th>Chức vụ</th>
                                            <th style="width: 100px"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% int i = 0;
                                            for (adminBO adminb : arrayList) {
                                        %>
                                        <tr>
                                            <td><%=++i%></td>
                                            <td><%=adminb.getName()%></td>
                                            <td><%=adminb.getEmail()%></td>
                                            <td><%if (adminb.getRole() == 9) {%>Quản lý<%}%>
                                                <%if (adminb.getRole() == 0) {%>Nhân viên<%}%></td>
                                            <td><button type="button"
                                                        class="btn btn-info btnEdit" 
                                                        data-toggle="modal" 
                                                        data-target="#modalUpdate"
                                                        my-id="<%=adminb.getId()%>"
                                                        my-name="<%=adminb.getName()%>"
                                                        my-email="<%=adminb.getEmail()%>"
                                                        my-role="<%=adminb.getRole()%>">Sửa</button> 
                                                <button type="button" class="btn btn-info btnDelete" my-id="<%=adminb.getId()%>">Xóa</button></td>
                                        </tr>
                                        <% }%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!--content end-->
                <jsp:include page="footer.jsp"/>
            </div>
        </div>
        <jsp:include page="importJS.jsp"></jsp:include>
            <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">Thêm nhân viên mới</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="card-body">
                            <form>
                                <div class="form-group">
                                    <div class="form-label-group">
                                        <input type="text" 
                                               id="inputName" 
                                               name="inputName" 
                                               class="form-control" 
                                               placeholder="Tên" 
                                               required>
                                        <label for="inputName">Tên nhân viên</label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="form-label-group">
                                        <input type="text" 
                                               id="inputEmail" 
                                               name="inputEmail" 
                                               class="form-control" 
                                               placeholder="Email" 
                                               required>
                                        <label for="inputEmail">Email</label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="form-label-group">
                                        <input type="text" 
                                               id="inputPassword" 
                                               name="inputPassword" 
                                               class="form-control" 
                                               placeholder="Mật khẩu" 
                                               required>
                                        <label for="inputPassword">Mật khẩu</label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputPostion">Chức vụ</label>
                                    <select class="form-control" id="inputPostion" name="inputPostion">
                                        <option value="0">Nhân viên</option>
                                        <option value="9">Quản lý</option>
                                    </select>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="button" class="btn btn-primary saveEmp">Save changes</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="modalUpdate" tabindex="-1" 
                 role="dialog" aria-labelledby="exampleModalCenterTitle" 
                 aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLongTitle">Cập nhật</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="card-body">
                            <form>
                                <input id="inputUpdateID" name="inputUpdateID" 
                                       class="form-control inputUpdateID" type="text" hidden  >
                                <div class="form-group">
                                    <div class="form-label-group">
                                        <input type="text" 
                                               id="inputNameUpdate" 
                                               name="inputNameUpdate" 
                                               class="form-control" 
                                               placeholder="Tên" 
                                               required>
                                        <label for="inputNameUpdate">Tên nhân viên</label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="form-label-group">
                                        <input type="text" 
                                               id="inputEmailUpdate" 
                                               name="inputEmailUpdate" 
                                               class="form-control" 
                                               placeholder="Email" 
                                               required>
                                        <label for="inputEmailUpdate">Email</label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="form-label-group">
                                        <input type="text" 
                                               id="inputPassword" 
                                               name="inputPassword" 
                                               class="form-control" 
                                               placeholder="Mật khẩu" 
                                               required>
                                        <label for="inputPassword">Mật khẩu</label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="inputPostionUpdate">Chức vụ</label>
                                    <select class="form-control" id="inputPostionUpdate" name="inputPostionUpdate">
                                        <option value="0">Nhân viên</option>
                                        <option value="9">Quản lý</option>
                                    </select>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                    <button type="button" class="btn btn-primary btnSaveEdit">Save changes</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <script type="text/javascript">
                $('.btnDelete').on('click',function (event){
                    var result = confirm("Xác nhận xóa hay không?" );
                    if (result) {
                        var ID = $(this).attr("my-id");
                        location.href = '${root}/managerEmployeeServlet?command=delete&ID=' + ID;
                    }
                    return false;
                });
                $('.saveEmp').on('click', function (event) {
                    var name = document.getElementById("inputName").value;
                    var mail = document.getElementById("inputEmail").value;
                    var password = document.getElementById("inputPassword").value;
                    var postion = document.getElementById("inputPostion").value;
                    location.href = '${root}/managerEmployeeServlet?command=insert&name=' + name + '&mail=' + mail + '&password=' + password + '&postion=' + postion;
                });
                $('.btnEdit').on('click', function (event) {
                    $("#inputUpdateID").val($(this).attr("my-id"));
                    $("#inputNameUpdate").val($(this).attr("my-name"));
                    $("#inputEmailUpdate").val($(this).attr("my-email"));
                    $("#inputPostionUpdate").val($(this).attr("my-role"));
                    $('#modalUpdate').modal();
                });
                $('.btnSaveEdit').on('click', function (event) {
                    var inputUpdateID = document.getElementById("inputUpdateID").value;
                    var name = document.getElementById("inputNameUpdate").value;
                    var mail = document.getElementById("inputEmailUpdate").value;
                    var password = document.getElementById("inputPostionUpdate").value;
                    var postion = document.getElementById("inputPostion").value;
                    location.href = '${root}/managerEmployeeServlet?command=update&name=' + name + '&mail=' + mail + '&password=' + password + '&postion=' + postion + '&ID=' + inputUpdateID;
                });
        </script>
    </body>
</html>
