<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <c:set var="root" value="${pageContext.request.contextPath}"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cập nhật fashion</title>
    </head>
    <body id="page-top">
        <jsp:include page="header.jsp"></jsp:include>
            <div id="wrapper">
            <jsp:include page="menu.jsp" />
            <div id="content-wrapper">
                <div class="card-body">
                    <form action="${root}/ManagerFashionController" method="post">
                        <div class="form-group">
                            <div class="form-label-group">
                                <input type="text" id="inputFashion" name="inputFashion" class="form-control" placeholder="Tên danh mục" required="required">
                                <label for="inputFashion">Thời trang</label>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" onclick="location.href = 'fashion.jsp'">Close</button>
                            <button type="submit" class="btn btn-primary">Save changes</button>
                        </div>
                    </form>
                </div>

                <jsp:include page="footer.jsp"/>
            </div>
        </div>
        <jsp:include page="importJS.jsp"></jsp:include>
    </body>
</html>
