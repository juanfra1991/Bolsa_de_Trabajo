<%@page contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
<%@page import="java.lang.*,java.util.*,java.sql.*"%>
<%@page import="java.io.*"%>
<%@page import="java.awt.*"%>
<%@page import="java.awt.image.*"%>
<%@page import="javax.imageio.ImageIO"%>
<!DOCTYPE html>
<html>
<%
String error=request.getParameter("error");
%>
<head>
<!-- datepicker -->
<!--  jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.11.3.min.js"></script>

<!-- Isolated Version of Bootstrap, not needed if your site already uses Bootstrap -->
<link rel="stylesheet" href="https://formden.com/static/cdn/bootstrap-iso.css" />

<!-- Bootstrap Date-Picker Plugin -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css"/>
<!-- datepicker -->

<!-- Required meta tags -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<title>Home Registro</title>
	
<script type="text/javascript">  
function Valida(form) { 
    if (form.email_valido.value == 'ok') {
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
var email = document.getElementById("email").value;
var no_vacio = document.forms["form"]["email"].value;
    if (no_vacio == "") {
        if ($(".mensaje").hasClass('alert-success') || $(".mensaje").hasClass('alert-danger')) {
            $(".mensaje").removeClass('alert-success');
            $(".mensaje").removeClass('alert-danger');
        }
        $(".mensaje").addClass('alert-warning').toggleClass('hide').addClass('show').html("<button type='button' class='close' data-dismiss='alert'>&times;</button><strong>Aviso!</strong> El campo 'E-Mail' no puede estar vacío");
        return false;
    }
peticion_http = inicializa_xhr();
	if (peticion_http) {
		peticion_http.onreadystatechange = procesaRespuesta;
		peticion_http.open("POST", "check_email.jsp", true);
		peticion_http.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		peticion_http.send("email="+email);
	}
}

function procesaRespuesta() {
	if (peticion_http.readyState == READY_STATE_COMPLETE) {
		if (peticion_http.status == 200) {
			var email = document.getElementById("email").value;
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
                $(".mensaje").addClass('alert-success').toggleClass('hide').addClass('show').html("<button type='button' class='close' data-dismiss='alert'>&times;</button><strong>Aviso!</strong> El E-Mail '"+email+"' si está disponible");
                    document.getElementById("email_valido").value="ok";
            }
            else {
                if ($(".mensaje").hasClass('alert-success') || $(".mensaje").hasClass('alert-warning')) {
                    $(".mensaje").removeClass('alert-success');
                    $(".mensaje").removeClass('alert-warning');
                }
            $(".mensaje").addClass('alert-danger').toggleClass('hide').addClass('show').html("<button type='button' class='close' data-dismiss='alert'>&times;</button><strong>Aviso!</strong> El E-Mail '"+email+"' no está disponible");
                document.getElementById("email_valido").value="no_ok";
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
<nav class="navbar navbar-expand-lg navbar-dark bg-info text-white">
    <a class="navbar-brand" href="formulario_registro.jsp">Bolsa de Trabajo</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" href="../../index.jsp">Inicio </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="../faq/index_faq.jsp">FAQ </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="../contacto/index_contacto.jsp">Contacto </a>
            </li>
        </ul>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item"><a class="nav-link" href="../login/login.jsp"><i class="fa fa-sign-in"></i> Login</a></li>
            <li class="nav-item active"><a class="nav-link" href="formulario_registro.jsp"><i class="fa fa-user"></i> Regístrate</a></li>
        </ul>
    </div>
</nav>
<div class="container">
    <form class="form-horizontal" name="form" id="form" role="form" method="POST" action="insert_registro.jsp" onSubmit="return Valida(this) && validarPasswd()">
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <h2 class="text-center">Registro</h2>
                <hr>
            </div>
        </div>
		<div class="row">
            <div class="col-md-3 field-label-responsive"></div>
			<div class="col-md-6">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
						<div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-at"></i></div>
						<input type="text" name="email" class="form-control" id="email" placeholder="E-mail *" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" required autofocus>
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
                            <i class="fa fa-key"></i>
                        </div>
                        <input type="password" name="password" class="form-control" id="password" placeholder="Password *" required>
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
                            <i class="fa fa-repeat"></i>
                        </div>
                        <input type="password" name="password-confirm" class="form-control" id="password-confirm" placeholder="Confirmar Password *" required>
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
                        <input type="text" name="nombre" class="form-control" id="nombre" placeholder="Nombre *">
                    </div>
                </div>
            </div>
        </div>
		<div class="row">
            <div class="col-md-3 field-label-responsive"></div>
            <div class="col-md-6">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-user-o"></i></div>
                        <input type="text" name="apellido" class="form-control" id="apellido" placeholder="Apellidos">
                    </div>
                </div>
            </div>
        </div>
		<div class="row">
            <div class="col-md-3 field-label-responsive"></div>
            <div class="col-md-6">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-birthday-cake"></i></div>
                        <input type="text" name="fecha_nacimiento" class="form-control" id="fecha_nacimiento" placeholder="Fecha de Nacimiento">
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
                <button type="submit" class="btn btn-success"><i class="fa fa-user-plus"></i> Registrarse</button>
				<button type="button" class="btn btn-info" id="comprobar" role="button"><i class="fa fa-check"></i> Disponibilidad</button>
				<button type="reset" class="btn btn-secondary" name="reset" id="reset" role="button"><i class="fa fa-eraser"></i> Limpiar</button>
				<a href="../../index.jsp" class="btn btn-danger" role="button"><i class="fa fa-sign-out"></i> Salir</a>
            </div>
        </div>
        <div align='center' style='padding-top: 1rem'>
            <input type="hidden" name="email_valido" id="email_valido" value="no_ok">
            <div class='alert alert-warning alert-dismissible fade hide mensaje'></div>
        </div>
    </form>
</div>
<!-- Optional JavaScript -->

<!-- Check Password -->
<script type="text/javascript">
function validarPasswd() {

    var p1 = document.getElementById("password").value;
    var p2 = document.getElementById("password-confirm").value;
    var espacios = false;
    var cont = 0;
    // Este bucle recorre la cadena para comprobar
    // que no todo son espacios
    while (!espacios && (cont < p1.length)) {
        if (p1.charAt(cont) == " ")
            espacios = true;
        cont++;
    }

    if (espacios) {
    $(".mensaje").addClass('alert-warning').toggleClass('hide').addClass('show').html("<button type='button' class='close' data-dismiss='alert'>&times;</button><strong>Aviso!</strong> La contraseña no puede contener espacios en blanco");
        return false;
    }

    if (p1 != p2) {
    $(".mensaje").addClass('alert-warning').toggleClass('hide').addClass('show').html("<button type='button' class='close' data-dismiss='alert'>&times;</button><strong>Aviso!</strong> Las contraseñas deben ser iguales");
        return false;
    } 

    else {
    if ($(".mensaje").hasClass('alert-warning') || $(".mensaje").hasClass('alert-danger')) {
            $(".mensaje").removeClass('alert-warning');
            $(".mensaje").removeClass('alert-danger');
        }
        $(".mensaje").toggleClass('hide').addClass('show').addClass('alert-success').html("<button type='button' class='close' data-dismiss='alert'>&times;</button><strong>Éxito!</strong> Registro Completado");
        return true;
    }
}
</script>
<!-- jQuery datepicker-->
<script>
    $('#fecha_nacimiento').datepicker({
    format: "dd/mm/yyyy",
    weekStart: 1,
    todayBtn: "linked",
    language: "es",
    autoclose: true,
    todayHighlight: true
	});
</script>
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<!-- Include Date Range Picker -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css"/>
</body>
</html>