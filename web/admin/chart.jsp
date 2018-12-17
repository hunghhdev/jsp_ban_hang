<%@page import="model.adminBO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thống kê</title>
        <c:set var="root" value="${pageContext.request.contextPath}"/>
        <link href="${root}/admin/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom fonts for this template-->
        <link href="${root}/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

        <!-- Page level plugin CSS-->
        <link href="${root}/admin/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

        <!-- Custom styles for this template-->
        <link href="${root}/admin/css/sb-admin.css" rel="stylesheet">
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script type="text/javascript">
            //load the Google Visualization API and the chart
            google.load('visualization', '1', {'packages': ['columnchart']});

            //set callback
            google.setOnLoadCallback(createChart);

            //callback function
            function createChart() {
                //create data table object
                var dataTable = new google.visualization.DataTable();

                //define columns
                dataTable.addColumn('string', '');
                dataTable.addColumn('number', '');

                //define rows of data
                dataTable.addRows([<c:forEach var="item" items="${listItem}">['${item.name}',${item.value}],</c:forEach>]);

                //instantiate our chart object
                var chart = new google.visualization.ColumnChart(document.getElementById('chart'));

                //define options for visualization
                var options = {width: 1200, height: 600, is3D: true, title: 'Trạng thái đơn hàng'};

                //draw our chart
                chart.draw(dataTable, options);

            }
            </script>

        </head>

        <body> <%
                adminBO admin = (adminBO) session.getAttribute("adminBo");
                if (admin == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }
                if (admin.getRole() != 9) {
                    response.sendRedirect("index.jsp");
                    return;
                }
        %>
        <jsp:include page="header.jsp"></jsp:include>
            <div id="wrapper">
            <jsp:include page="menu.jsp" />
            <div id="content-wrapper">


                <div id="chart"></div>
                <jsp:include page="footer.jsp"/>
            </div>
        </div>
        <jsp:include page="importJS.jsp"></jsp:include>
    </body>
</html>
