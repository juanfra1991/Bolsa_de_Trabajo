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

<title>Home Buscar Empresas</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-info text-white">
    <a class="navbar-brand" href="index_buscar_empresas.jsp">Bolsa de Trabajo</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
        <!-- Dropdown -->
            <li class="nav-item dropdown">
                <a class="nav-link" href="../ofertas/index_ultimas_ofertas.jsp" id="navbardrop">Últimas Ofertas </a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link" href="../noticias/index_ultimas_noticias.jsp" id="navbardrop">Últimas Noticias </a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link" href="../documentos/index_documentos.jsp" id="navbardrop">Documentos </a>
            </li>
            <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle active" href="#" id="navbardrop" data-toggle="dropdown">Buscador </a>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="index_buscar_ofertas.jsp">Buscar Ofertas</a>
                    <a class="dropdown-item" href="index_buscar_empresas.jsp">Buscar Empresas</a>
                    <a class="dropdown-item" href="index_buscar_noticias.jsp">Buscar Noticias</a>
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
//************************************//
try {
    Class.forName("com.mysql.jdbc.Driver");
    urljdbc = getServletContext().getInitParameter("urljdbc"); 
    loginjdbc = getServletContext().getInitParameter("loginjdbc"); 
    passwordjdbc = getServletContext().getInitParameter("passwordjdbc"); 
    conexion = DriverManager.getConnection(urljdbc,loginjdbc,passwordjdbc);
    sentencia=conexion.createStatement(ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);
    sentencia_sql=sentencia.executeQuery("select * from empresa");
%>
<div class="container">
    <form class="form-horizontal" name="form" role="form">
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <h2 class="text-center">Busca Empresas</h2>
                <hr>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2 field-label-responsive">
            </div>
            <div class="col-md-8">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <input type="text" class="form-control" name="buscar" id="buscar" placeholder="Busqueda...">
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2 field-label-responsive"></div>
            <div class="col-md-8">
                <div class="form-group">
                    <div class="table-responsive">
                        <table id="tabla" class="table table-hover">
                            <thead class="thead-light">
                                <tr>
                                    <th>Nombre</th>
                                    <th>E-mail</th>   
                                </tr>
                            </thead>
                            <tbody>
                                <% while (sentencia_sql.next()) { %>
                                <tr style="display: none;">
                                    <td title="titulo"><%=sentencia_sql.getString(2)%></td>
                                    <td title="titulo"><%=sentencia_sql.getString(3)%></td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <%
    sentencia.close();
    }
        catch (ClassNotFoundException error1) {
            out.println("ClassNotFoundException: No se puede localizar el Controlador de ORACLE:" +error1.getMessage());
        }
        catch (SQLException error2) {
            out.println("Error en la sentencia sql que se ha intentado ejecutar (Posible error léxico y/o sintáctico): "+error2.getMessage());
        }
        catch (Exception error3) {
            out.println("Se ha producido un error indeterminado: "+error3.getMessage());
        }
    %>
</div>
<!-- Optional JavaScript -->

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="../../js/buscador.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</body>
</html>