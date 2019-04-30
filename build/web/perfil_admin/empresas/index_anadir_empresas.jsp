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

<title>Home Añadir Empresas</title>

<script type="text/javascript">  
function Valida(form) { 
    if (form.empresa_valida.value == 'ok') {
    return true;
    } 
    else {
        if ($(".mensaje").hasClass('alert-success') || $(".mensaje").hasClass('alert-danger')) {
            $(".mensaje").removeClass('alert-success');
            $(".mensaje").removeClass('alert-danger');
        }
        $(".mensaje").toggleClass('hide').addClass('show').addClass('alert-warning').html("<button type='button' class='close' data-dismiss='alert'>&times;</button><strong>Aviso!</strong> Haz clic en 'Disponibilidad' para comprobar la disponibilidad");
        return false;
    }
}
</script>

<script type="text/javascript">
var READY_STATE_COMPLETE=4;
var peticion_http = null;

function inicializa_xhr() {
    if (window.XMLHttpRequest) {
        return new XMLHttpRequest(); 
    } 
    else if (window.ActiveXObject) {
        return new ActiveXObject("Microsoft.XMLHTTP"); 
    } 
}

function comprobar() {
var cif = document.getElementById("cif").value;
var no_vacio = document.forms["form"]["cif"].value;
    if (no_vacio == "") {
            if ($(".mensaje").hasClass('alert-success') || $(".mensaje").hasClass('alert-danger')) {
                $(".mensaje").removeClass('alert-success');
                $(".mensaje").removeClass('alert-danger');
            }
        $(".mensaje").addClass('alert-warning').toggleClass('hide').addClass('show').html("<button type='button' class='close' data-dismiss='alert'>&times;</button><strong>Aviso!</strong> El campo 'CIF' no puede estar vacío");
        return false;
    }
peticion_http = inicializa_xhr();
    if (peticion_http) {
        peticion_http.onreadystatechange = procesaRespuesta;
        peticion_http.open("POST", "check_empresa.jsp", true);
        peticion_http.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        peticion_http.send("cif="+cif);
    }
}

function procesaRespuesta() {
    if (peticion_http.readyState == READY_STATE_COMPLETE) {
        if (peticion_http.status == 200) {
            var cif = document.getElementById("cif").value;
            var respuesta= peticion_http.responseText;
            var estado_respuesta=respuesta.substring(1,3);

            /*substring(inicio, final), extrae una porción de una cadena de texto. 
            El segundo parámetro es opcional. Si solo se indica el parámetro inicio, 
            la función devuelve la parte de la cadena original correspondiente desde esa posición hasta el final:*/
            
            /*Si se indica el inicio y el final, se devuelve la parte de la cadena original 
            comprendida entre la posición inicial y la inmediatamente anterior a la posición final 
            (es decir, la posición inicio está incluida y la posición final no):*/

            if (estado_respuesta=="Si") {
                if ($(".mensaje").hasClass('alert-warning') || $(".mensaje").hasClass('alert-danger')) {
                    $(".mensaje").removeClass('alert-warning');
                    $(".mensaje").removeClass('alert-danger');
                }
                $(".mensaje").addClass('alert-success').toggleClass('hide').addClass('show').html("<button type='button' class='close' data-dismiss='alert'>&times;</button><strong>Aviso!</strong> El CIF '"+cif+"' está disponible");
                    document.getElementById("empresa_valida").value="ok";
            }
            else {
                if ($(".mensaje").hasClass('alert-success') || $(".mensaje").hasClass('alert-warning')) {
                    $(".mensaje").removeClass('alert-success');
                    $(".mensaje").removeClass('alert-warning');
                }
            $(".mensaje").addClass('alert-danger').toggleClass('hide').addClass('show').html("<button type='button' class='close' data-dismiss='alert'>&times;</button><strong>Aviso!</strong> El CIF '"+cif+"' no está disponible");
                document.getElementById("empresa_valida").value="no_ok";
            }
        }
    }
}

window.onload = function() {
    document.getElementById("comprobar").onclick = comprobar;
}
</script>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="index_anadir_empresas.jsp">Bolsa de Trabajo</a>
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
            <a class="nav-link dropdown-toggle active" href="#" id="navbardrop" data-toggle="dropdown">Empresas </a>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="index_lista_empresas.jsp">Lista Empresas</a>
                    <a class="dropdown-item" href="index_anadir_empresas.jsp">Añadir Empresas</a>
                    <a class="dropdown-item" href="index_enviar_email_empresas.jsp">Enviar E-mail</a>
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
            <h2 class="text-center">Añadir Empresas</h2>
            <hr>
        </div>
    </div>
    <form class="form-horizontal" name="form" id="form" role="form" method="POST" action="anadir_empresas.jsp" onSubmit="return Valida(this);">
        <div class="row">
            <div class="col-md-3 field-label-responsive"></div>
            <div class="col-md-6">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-key"></i></div>
                        <input type="text" name="cif" class="form-control" id="cif" maxlength="9" pattern="^([ABCDEFGHJKLMNPQRSUVW])(\d{7})([0-9A-J])$" placeholder="CIF *" required autofocus>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3 field-label-responsive"></div>
            <div class="col-md-6">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-user"></i></div>
                        <input type="text" name="nombre" class="form-control" id="nombre" placeholder="Nombre *" required>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3 field-label-responsive"></div>
            <div class="col-md-6">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-at"></i></div>
                        <input type="text" name="email" class="form-control" id="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" placeholder="E-mail *" required>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3 field-label-responsive"></div>
            <div class="col-md-6">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-street-view"></i></div>
                        <input type="text" name="direccion" class="form-control" id="direccion" placeholder="Dirección *" required>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3 field-label-responsive"></div>
            <div class="col-md-6">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem">
                            <i class="fa fa-building"></i>
                        </div>
                        <select name="cod_sector" class="form-control" id="cod_sector" required>
                            <option value="" disabled selected>Sector Profesional *</option>
                            <%
                            String urljdbc;
                            String loginjdbc;
                            String passwordjdbc;
                            Connection conexion=null;
                            Statement sentencia=null;
                            ResultSet sentencia_sql=null;
                            StringBuffer built_stmt=new StringBuffer();
                            //************************************//
                            try {
                                Class.forName("com.mysql.jdbc.Driver");
                                urljdbc = getServletContext().getInitParameter("urljdbc"); 
                                loginjdbc = getServletContext().getInitParameter("loginjdbc"); 
                                passwordjdbc = getServletContext().getInitParameter("passwordjdbc"); 
                                conexion = DriverManager.getConnection(urljdbc,loginjdbc,passwordjdbc);
                                sentencia=conexion.createStatement(ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);
                                sentencia_sql=sentencia.executeQuery("select * from sector_profesional order by nombre");            
                                // Bucle para recorrer el resultado del select
                                while(sentencia_sql.next()) {
                                    out.print("<option value=\""+sentencia_sql.getString(1)+"\">"+sentencia_sql.getString(2)+"</option>");
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
        <div class="row" align="center" style="padding-top: 1rem">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <button type="submit" class="btn btn-success"><i class="fa fa-user-plus"></i> Añadir</button>
                <button type="button" class="btn btn-info" id="comprobar" role="button"><i class="fa fa-check"></i> Disponibilidad</button>
                <button type="reset" class="btn btn-secondary" name="reset" id="reset" role="button"><i class="fa fa-eraser"></i> Limpiar</button>
            </div>
        </div>
        <div align='center' style='padding-top: 1rem'>
            <input type="hidden" name="empresa_valida" id="empresa_valida" value="no_ok">
            <div class='alert alert-warning alert-dismissible fade hide mensaje'></div>
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