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

<title>Home Contacto</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-info text-white">
    <a class="navbar-brand" href="index_contacto.jsp">Bolsa de Trabajo</a>
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
            <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">Buscador </a>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="../buscador/index_buscar_ofertas.jsp">Buscar Ofertas</a>
                    <a class="dropdown-item" href="../buscador/index_buscar_empresas.jsp">Buscar Empresas</a>
                    <a class="dropdown-item" href="../buscador/index_buscar_noticias.jsp">Buscar Noticias</a>
                </div>
            </li>
            <li class="nav-item dropdown active">
                <a class="nav-link" href="index_contacto.jsp">Contacto </a>
            </li>
        </ul>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="index_perfil.jsp" id="navbardrop" data-toggle="dropdown"><i class="fa fa-user"></i> <%=nombre%></a>
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
            <h2 class="text-center">Contacto</h2>
            <hr>
        </div>
    </div>
    <form class="form-horizontal" enctype="multipart/form-data" name="form" role="form" method="POST" action="contacto.jsp">
        <div class="row">
            <div class="col-md-3 field-label-responsive"></div>
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
            <div class="col-md-3 field-label-responsive"></div>
            <div class="col-md-6">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-comment"></i></div>
                        <input type="text" name="asunto" class="form-control" id="asunto" placeholder="Asunto *" required>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3 field-label-responsive"></div>
            <div class="col-md-6">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-comments"></i></div>
                        <textarea class="form-control" name="texto" id="texto" rows="3" placeholder="Mensaje"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3 field-label-responsive"></div>
            <div class="col-md-6">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-file"></i></div>
                        <input type="file" class="form-control" name="avatar" id="exampleInputFile" aria-describedby="fileHelp">
                    </div>
                </div>
            </div>
        </div>
        <div class="row" align="center" style="padding-top: 1rem">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <button type="submit" class="btn btn-primary"><i class="fa fa-send"></i> Enviar</button>
                <button type="reset" class="btn btn-secondary" name="reset" id="reset" role="button"><i class="fa fa-eraser"></i> Limpiar</button>
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