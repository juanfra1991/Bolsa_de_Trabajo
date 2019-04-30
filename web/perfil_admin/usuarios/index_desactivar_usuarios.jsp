<%@page contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
<%@page import="java.lang.*,java.util.*,java.sql.*"%>
<%
HttpSession datossesion=request.getSession();
String email=(String)datossesion.getAttribute("email");
String nombre=(String)datossesion.getAttribute("nombre");
Integer perfil=(Integer)datossesion.getAttribute("perfil");

if (email==null || perfil.intValue()==0) {
    datossesion.invalidate();
}
%>

<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- DataTable CSS -->
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap4.min.css">

<title>Home Desactivar Usuarios</title>

<script type="text/javascript">
function comprobar() {
    check = $(".btn.btn-info.comprobar").hasClass("active");
    if (!check) {
        $(".mensaje").toggleClass('hide').addClass('show');
        return false;
    }
        return true;
}
</script>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="index_desactivar_usuarios.jsp">Bolsa de Trabajo</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
        <!-- Dropdown -->
            <li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle active" href="#" id="navbardrop" data-toggle="dropdown">Usuarios </a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="index_lista_usuarios.jsp">Lista Usuarios</a>
					<a class="dropdown-item" href="index_activar_usuarios.jsp">Activar Usuarios</a>
					<a class="dropdown-item" href="index_desactivar_usuarios.jsp">Desactivar Usuarios</a>
					<a class="dropdown-item" href="index_eliminar_usuarios.jsp">Eliminar Usuarios</a>
					<a class="dropdown-item" href="index_enviar_email_usuarios.jsp">Enviar E-mail</a>
				</div>
			</li>
            <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">Ofertas </a>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="../ofertas/index_lista_ofertas.jsp">Lista Ofertas</a>
                    <a class="dropdown-item" href="../ofertas/index_anadir_ofertas.jsp">Añadir Ofertas</a>
                </div>
            </li>
            <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">Noticias </a>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="../noticias/index_lista_noticias.jsp">Lista Noticias</a>
                    <a class="dropdown-item" href="../noticias/index_anadir_noticias.jsp">Añadir Noticias</a>
                </div>
            </li>
            <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">Empresas </a>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="../empresas/index_lista_empresas.jsp">Lista Empresas</a>
                    <a class="dropdown-item" href="../empresas/index_anadir_empresas.jsp">Añadir Empresas</a>
                    <a class="dropdown-item" href="../empresas/index_enviar_email_empresas.jsp">Enviar E-mail</a>
                </div>
            </li>
            <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">Sectores </a>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="../sectores/index_lista_sectores.jsp">Lista Sectores</a>
                    <a class="dropdown-item" href="../sectores/index_anadir_sectores.jsp">Añadir Sectores</a>
                </div>
            </li>
            <li class="nav-item dropdown">
            <a class="nav-link" href="../documentos/index_documentos.jsp" id="navbardrop">Documentos </a>
            </li>
        </ul>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown"><i class="fa fa-user"></i> <%=nombre%></a>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="../perfil/index_ver_perfil.jsp"><i class="fa fa-user-o"></i> Perfil</a>
                    <a class="dropdown-item" href="../perfil/index_modificar_perfil.jsp"><i class="fa fa-user-secret"></i> Modificar Perfil</a>
                    <a class="dropdown-item" href="../perfil/index_subir_avatar.jsp"><i class="fa fa-image"></i> Subir Avatar</a>
                </div>
            </li>
            <li class="nav-item"><a class="nav-link" href="../../index.jsp"><i class="fa fa-sign-out"></i> Cerrar Sesión</a></li>
        </ul>
    </div>
</nav>
<div class="container">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <h2 class="text-center">Desactivar Usuarios</h2>
            <hr>
        </div>
    </div>
<%
String urljdbc;
String loginjdbc;
String passwordjdbc;
Connection conexion=null;
Statement sentencia=null;
ResultSet sentencia_sql=null;
//************************************//
try {
    Class.forName("com.mysql.jdbc.Driver");
    urljdbc = getServletContext().getInitParameter("urljdbc"); 
    loginjdbc = getServletContext().getInitParameter("loginjdbc"); 
    passwordjdbc = getServletContext().getInitParameter("passwordjdbc"); 
    conexion = DriverManager.getConnection(urljdbc,loginjdbc,passwordjdbc);
    sentencia=conexion.createStatement(ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);
    sentencia_sql=sentencia.executeQuery("select * from usuario where activo ='1' and perfil !='1'");             
    // Bucle para recorrer el resultado del select
        out.println("<form action='desactivar_usuarios.jsp' onsubmit='return comprobar();'>");
            out.println("<div class='table-responsive'>");
            out.println("<table id='dataTable' class='table table-hover'>");
                out.println("<thead class='thead-dark'>");
                    out.println("<tr>");
                        out.println("<th>Nombre y Apellidos</th>");
                        out.println("<th>E-mail</th>");
                    out.println("</tr>");
                out.println("</thead>");
                out.println("<tbody>");
            while (sentencia_sql.next()) {
                out.println("<tr>");
                    out.println("<td>");
                        out.println("<div class='btn-group-toggle' data-toggle='buttons'>");
                        out.println("<label class='btn btn-info comprobar'>"+sentencia_sql.getString(3)+ " " +sentencia_sql.getString(4)); 
                        out.println("<input type='checkbox' name='email' autocomplete='off' value='"+sentencia_sql.getString(1)+"'>");
                        out.println("</label>");
                        out.println("</div>");
                    out.println("</td>");
                    out.println("<td>"+sentencia_sql.getString(1)+"</td>");
                out.println("</tr>");
            }
                out.println("</tbody>");
            out.println("</table>");
            out.println("</div>");
            out.println("<div class='row' align='center' style='padding-top: 1rem'>");
            out.println("<div class='col-md-3'></div>");
            out.println("<div class='col-md-6'>");
                out.println("<button type='submit' class='btn btn-warning'><i class='fa fa-user-times'></i> Desactivar</button>");
            out.println("</div>");
            out.println("</div>");
            out.println("<div align='center' style='padding-top: 1rem'>");
                out.println("<div class='alert alert-warning alert-dismissible fade hide mensaje'>");
                    out.println("<button type='button' class='close' data-dismiss='alert'>&times;</button>");
                    out.println("<strong>Aviso!</strong> No has seleccionado ningún usuario");
                out.println("</div>");
            out.println("</div>");
        out.println("</form>");
    sentencia_sql.close();
    sentencia.close();
}
finally {
    if (conexion != null)
        conexion.close();
}
%>
</div>
<!-- Optional JavaScript -->

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<!-- DataTable JS -->
<script type="text/javascript">
    $(document).ready(function() {
        $('#dataTable').DataTable();
});
</script>
<script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap4.min.js"></script>
</body>
</html>