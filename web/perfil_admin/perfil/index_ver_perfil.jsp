<%@page contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
<%@page import="java.lang.*,java.util.*,java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.awt.*"%>
<%@page import="java.awt.image.*"%>
<%@page import="javax.imageio.ImageIO"%>
<%
HttpSession datossesion=request.getSession();
String email=(String)datossesion.getAttribute("email");
Integer perfil=(Integer)datossesion.getAttribute("perfil");
String password=(String)datossesion.getAttribute("password");
String nombre=(String)datossesion.getAttribute("nombre");
String apellido=(String)datossesion.getAttribute("apellido");
String fecha_nacimiento=(String)datossesion.getAttribute("fecha_nacimiento");
String cod_sector=(String)datossesion.getAttribute("cod_sector");

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

<title>Home Perfil</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="index_ver_perfil.jsp">Bolsa de Trabajo</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
        <!-- Dropdown -->
            <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">Usuarios </a>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="../usuarios/index_lista_usuarios.jsp">Lista Usuarios</a>
                    <a class="dropdown-item" href="../usuarios/index_activar_usuarios.jsp">Activar Usuarios</a>
                    <a class="dropdown-item" href="../usuarios/index_desactivar_usuarios.jsp">Desactivar Usuarios</a>
                    <a class="dropdown-item" href="../usuarios/index_eliminar_usuarios.jsp">Eliminar Usuarios</a>
                    <a class="dropdown-item" href="../usuarios/index_enviar_email_usuarios.jsp">Enviar E-mail</a>
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
            <a class="nav-link dropdown-toggle active" href="#" id="navbardrop" data-toggle="dropdown"><i class="fa fa-user"></i> <%=nombre%></a>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="index_ver_perfil.jsp"><i class="fa fa-user-o"></i> Perfil</a>
                    <a class="dropdown-item" href="index_modificar_perfil.jsp"><i class="fa fa-user-secret"></i> Modificar Perfil</a>
                    <a class="dropdown-item" href="index_subir_avatar.jsp"><i class="fa fa-image"></i> Subir Avatar</a>
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
            <h2 class="text-center">Perfil</h2>
            <hr>
        </div>
    </div>
<%
String dirUpload = getServletContext().getRealPath( getServletContext().getInitParameter("dir_user_registrados")); 
File imagen=new File(dirUpload+"/"+email+"/avatar.png");
    if (!imagen.exists()) {
%>
<%
    }
    else {
%>  
<div class="row" align="center">
    <div class="col-md-4"></div>
    <div class="col-md-4">
        <img class="img-thumbnail" alt="Avatar" width="160" height="160" src="../../dir_users/<%=email%>/avatar.png">
        <hr>
    </div>
</div>
<%
    }
%>
<%    
String urljdbc;
String loginjdbc;
String passwordjdbc;
Connection conexion=null;
Statement sentencia=null;
ResultSet sentencia_sql=null;
StringBuffer built_stmt=new StringBuffer();
Statement sentencia1=null;
ResultSet sentencia_sql1=null;
StringBuffer built_stmt1=new StringBuffer(); 
{
    Class.forName("com.mysql.jdbc.Driver");
    urljdbc = getServletContext().getInitParameter("urljdbc"); 
    loginjdbc = getServletContext().getInitParameter("loginjdbc"); 
    passwordjdbc = getServletContext().getInitParameter("passwordjdbc"); 
    conexion = DriverManager.getConnection(urljdbc,loginjdbc,passwordjdbc);
    sentencia=conexion.createStatement(ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);
    sentencia_sql=sentencia.executeQuery("select * from usuario where email='"+email+"'");            
    // Bucle para recorrer el resultado del select
    while (sentencia_sql.next()) {
        sentencia1=conexion.createStatement(ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);
        sentencia_sql1=sentencia1.executeQuery("select * from sector_profesional where cod_sector="+sentencia_sql.getString(9));  
        
        if (sentencia_sql1.next()) {
            sentencia_sql1.close();
            sentencia1.close();
        }
    }
    sentencia_sql.close();
    sentencia.close();
}
%>
    <form class="form-horizontal" name="form" role="form" method="POST" action="insert_registro.jsp" onSubmit="return Valida(this);">
        <div class="row">
            <div class="col-md-3 field-label-responsive">
                <label for="email">E-Mail</label>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-at"></i></div>
                        <input type="text" name="email" class="form-control" id="email" value="<%=email%>" autofocus readonly>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3 field-label-responsive">
                <label for="password">Password</label>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem">
                            <i class="fa fa-key"></i>
                        </div>
                        <input type="password" name="password" class="form-control" id="password" value="<%=password%>" readonly>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3 field-label-responsive">
                <label for="first_name">Nombre</label>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-user"></i></div>
                        <input type="text" name="nombre" class="form-control" id="nombre" value="<%=nombre%>" readonly>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3 field-label-responsive">
                <label for="last_name">Apellidos</label>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-user-o"></i></div>
                        <input type="text" name="apellido" class="form-control" id="apellido" value="<%=apellido%>" readonly>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3 field-label-responsive">
                <label for="date">Fecha de Nacimiento</label>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-birthday-cake"></i></div>
                        <input type="text" class="form-control" id="fecha_nacimiento" name="fecha_nacimiento" value="<%=fecha_nacimiento%>" readonly>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3 field-label-responsive">
                <label for="professional_sector">Sector Profesional</label>
            </div>
            <div class="col-md-6">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-building"></i></div>
                        <select name="cod_sector" class="form-control" id="cod_sector" value="<%=cod_sector%>" disabled readonly>
                        <%
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            urljdbc = getServletContext().getInitParameter("urljdbc"); 
                            loginjdbc = getServletContext().getInitParameter("loginjdbc"); 
                            passwordjdbc = getServletContext().getInitParameter("passwordjdbc"); 
                            conexion = DriverManager.getConnection(urljdbc,loginjdbc,passwordjdbc);
                            sentencia=conexion.createStatement(ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);
                            sentencia_sql=sentencia.executeQuery("select * from v_sector_email where email='"+email+"'");            
                            // Bucle para recorrer el resultado del select
                            while (sentencia_sql.next()) {
                                out.println("<option value=\""+sentencia_sql.getString(2)+"\">"+sentencia_sql.getString(3)+"</option>");
                            }
                            sentencia_sql.close();
                            sentencia.close();
                            conexion.close();
                        }
                        catch (SQLException error2) {

                        }
                        catch (Exception error3) {

                        }
                        %>
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
<!-- Optional JavaScript -->

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</body>
</html>