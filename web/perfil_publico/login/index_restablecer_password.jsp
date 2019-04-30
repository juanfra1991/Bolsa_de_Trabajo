<%@page contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<title>Home Restablecer Password</title>

<script type="text/javascript">  
function Valida(form) { 
    if (form.email_valido.value == 'ok') {
        return true;
    } 
    else {
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
        peticion_http.open("POST", "check_email_registrado.jsp", true);
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
                if ($(".mensaje").hasClass('alert-success') || $(".mensaje").hasClass('alert-warning')) {
                    $(".mensaje").removeClass('alert-success');
                    $(".mensaje").removeClass('alert-warning');
                }
            $(".mensaje").addClass('alert-danger').toggleClass('hide').addClass('show').html("<button type='button' class='close' data-dismiss='alert'>&times;</button><strong>Aviso!</strong> El E-Mail '"+email+"' no está registrado");
                document.getElementById("email_valido").value="no_ok";
            }
            else {
                document.getElementById("form").submit();
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
    <a class="navbar-brand" href="index_restablecer_password.jsp">Bolsa de Trabajo</a>
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
            <li class="nav-item"><a class="nav-link" href="../registro/formulario_registro.jsp"><i class="fa fa-user"></i> Regístrate</a></li>
        </ul>
    </div>
</nav>
<div class="container">
    <form class="form-horizontal" name="form" id="form" role="form" method="POST" action="update_password.jsp" onSubmit="return Valida(this);">
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <h2 class="text-center"">Restablecer Password</h2>
                <hr>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3 field-label-responsive"></div>
            <div class="col-md-6">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-at"></i></div>
                        <input type="text" name="email" class="form-control" id="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" placeholder="E-Mail *" required autofocus>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" align="center" style="padding-top: 1rem">
        <div class="col-md-3"></div>
            <div class="col-md-6">
                <button type="submit" class="btn btn-success" id="comprobar"><i class="fa fa-undo"></i> Restablecer</button>
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

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</body>
</html>