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

<title>Home Últimas Noticias</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-info text-white">
    <a class="navbar-brand" href="index_ultimas_noticias.jsp">Bolsa de Trabajo</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
        <!-- Dropdown -->
            <li class="nav-item dropdown">
                <a class="nav-link" href="../ofertas/index_ultimas_ofertas.jsp" id="navbardrop">Últimas Ofertas </a>
            </li>
            <li class="nav-item dropdown active">
                <a class="nav-link" href="index_ultimas_noticias.jsp" id="navbardrop">Últimas Noticias </a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link" href="../documentos/index_documentos.jsp" id="navbardrop">Documentos </a>
            </li>
            <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">Buscador </a>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="../buscador/index_buscar_ofertas.jsp">Buscar Ofertas</a>
                    <a class="dropdown-item" href="../buscador/index_buscar_empresas.jsp">Buscar Empresas</a>
                    <a class="dropdown-item" href="../buscador/index_buscar_noticias.jsp">Buscar Noticias</a>
                </div>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link" href="../contacto/index_contacto.jsp">Contacto </a>
            </li>
        </ul>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="../perfil/index_perfil.jsp" id="navbardrop" data-toggle="dropdown"><i class="fa fa-user"></i> <%=nombre%></a>
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
            <h2 class="text-center">Últimas Noticias</h2>
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
        sentencia_sql=sentencia.executeQuery("SET lc_time_names = 'es_ES'");            
        sentencia_sql=sentencia.executeQuery("select titulo, descripcion, DATE_FORMAT(fecha, '%W, %e de %M de %Y, %H:%i') from noticia order by fecha desc limit 10");
        while (sentencia_sql.next()) {
            //********************************************
            // Capa para noticias **********************
            //******************************************
            out.println("<h3>"+sentencia_sql.getString(1)+"</h3>");
            out.println("<p>"+sentencia_sql.getString(2)+"</p>");
            out.println("<p><i>"+sentencia_sql.getString(3).substring(0, 1).toUpperCase() +sentencia_sql.getString(3).substring(1).toLowerCase()+"</i></p>");
            out.println("<hr>");
            //********************************************
            //********************************************
        }
        sentencia_sql.close();
        sentencia.close();
    }
    catch (ClassNotFoundException error1) {
        out.println("Error ClassNotFoundException");
    }
    catch (SQLException error2) {
        out.println("Error en la sentencia sql que se ha intentado ejecutar (Posible error lexico y/o sintactico): "+error2.getMessage());
    }
    catch (Exception error3) { 
        out.println("Error Exception");
    }
    finally {
        try {
            if (conexion != null)
            conexion.close();
        }
        catch (Exception error3)
        {
            out.println("Error Exception Finally");
        }
    }
    %> 
</div>
<!-- Optional JavaScript -->

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</body>
</html>