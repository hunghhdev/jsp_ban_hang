<%@page import="model.Users"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.UsersDAO"%>
<%@page import="model.adminBO"%>
<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <c:set var="root" value="${pageContext.request.contextPath}"/>
        <title>Quản lý khách hàng</title>
    </head>
    <body id="page-top">
        <%
            adminBO admin = (adminBO) session.getAttribute("adminBo");
            if (admin == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            UsersDAO userDao = new UsersDAO();
            ArrayList<Users> arrayList = userDao.getAllUsersList();
        %>
        <jsp:include page="header.jsp"></jsp:include>
            <div id="wrapper">
            <jsp:include page="menu.jsp" />
            <div id="content-wrapper">
                <!--content start-->
                <div class="container-fluid">
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
                                            <th>Tên khách hàng</th>
                                            <th>Email</th>
                                            <th>Phone</th>
                                            <th>Ngày sinh</th>
                                            <th>Giới tính</th>
                                            <th>Số dư</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% int i = 0;
                                            for (Users user : arrayList) {
                                        %>
                                        <tr>
                                            <td><%=++i%></td>
                                            <td><%=user.getUserName()%></td>
                                            <td><%=user.getUserEmail()%></td>
                                            <td><%=user.getUserPhone()%></td>
                                            <td><%=user.getUserBirthday()%></td>
                                            <td><%if(user.isUserSex()) 
                                                {%>Nam<%} else if(!user.isUserSex()){%>Nữ<%}%></td>
                                            <td><fmt:formatNumber pattern="#,##0" value="<%=user.getUserDollar()%>"/></td>
                                            <td><button type="button" class="btn btn-info btnDelete" my-id="<%=user.getUserId()%>">Xóa</button></td></td>
                                        </tr>
                                        <% }%>
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
        </body>
        <script type="text/javascript">
            $('.btnDelete').on('click', function (event) {
                var result = confirm("Xác nhận xóa hay không?");
                if (result) {
                    var ID = $(this).attr("my-id");
                    var command = "delete";
//                    location.href = '${root}/managerUserServlet?command=delete&ID=' + ID;
                    $.ajax({
                        method: "POST",
                        url: "${root}/managerUserServlet",
                        data: {command: command, ID: ID}
                    }).done(function (){
                        location.reload();
                    });
                }
                return false;
            });
    </script>
</html>
