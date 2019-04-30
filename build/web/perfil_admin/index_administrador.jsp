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

<title>Home Administrator</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	<a class="navbar-brand" href="index_administrador.jsp">Bolsa de Trabajo</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarNav">
		<ul class="navbar-nav">
    	<!-- Dropdown -->
			<li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">Usuarios </a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="usuarios/index_lista_usuarios.jsp">Lista Usuarios</a>
					<a class="dropdown-item" href="usuarios/index_activar_usuarios.jsp">Activar Usuarios</a>
					<a class="dropdown-item" href="usuarios/index_desactivar_usuarios.jsp">Desactivar Usuarios</a>
					<a class="dropdown-item" href="usuarios/index_eliminar_usuarios.jsp">Eliminar Usuarios</a>
					<a class="dropdown-item" href="usuarios/index_enviar_email_usuarios.jsp">Enviar Email</a>
				</div>
			</li>
			<li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">Ofertas </a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="ofertas/index_lista_ofertas.jsp">Lista Ofertas</a>
					<a class="dropdown-item" href="ofertas/index_anadir_ofertas.jsp">Añadir Ofertas</a>
				</div>
			</li>
			<li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">Noticias </a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="noticias/index_lista_noticias.jsp">Lista Noticias</a>
					<a class="dropdown-item" href="noticias/index_anadir_noticias.jsp">Añadir Noticias</a>
				</div>
			</li>
			<li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">Empresas </a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="empresas/index_lista_empresas.jsp">Lista Empresas</a>
					<a class="dropdown-item" href="empresas/index_anadir_empresas.jsp">Añadir Empresas</a>
					<a class="dropdown-item" href="empresas/index_enviar_email_empresas.jsp">Enviar Email</a>
				</div>
			</li>
			<li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">Sectores </a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="sectores/index_lista_sectores.jsp">Lista Sectores</a>
					<a class="dropdown-item" href="sectores/index_anadir_sectores.jsp">Añadir Sectores</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link" href="documentos/index_documentos.jsp" id="navbardrop">Documentos </a>
			</li>
		</ul>
		<ul class="navbar-nav ml-auto">
			<li class="nav-item dropdown">
			<a class="nav-link dropdown-toggle" href="perfil/index_perfil.jsp" id="navbardrop" data-toggle="dropdown"><i class="fa fa-user"></i> <%=nombre%></a>
				<div class="dropdown-menu">
					<a class="dropdown-item" href="perfil/index_ver_perfil.jsp"><i class="fa fa-user-o"></i> Perfil</a>
					<a class="dropdown-item" href="perfil/index_modificar_perfil.jsp"><i class="fa fa-user-secret"></i> Modificar Perfil</a>
					<a class="dropdown-item" href="perfil/index_subir_avatar.jsp"><i class="fa fa-image"></i> Subir Avatar</a>
				</div>
			</li>
			<li class="nav-item"><a class="nav-link" href="../index.jsp"><i class="fa fa-sign-out"></i> Cerrar Sesión</a></li>
		</ul>
	</div>
</nav>
<div class="container">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <h2 class="text-center">Hola <%=nombre%>, Bienvenido al Área de Administración</h2>
            <hr>
        </div>
    </div>
</div>
<!-- Optional JavaScript -->

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</body>
</html>