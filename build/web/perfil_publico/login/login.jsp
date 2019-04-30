<%@page contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
String error=request.getParameter("error");
%>
<head>
<!-- Required meta tags -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<title>Home Login</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-info text-white">
    <a class="navbar-brand" href="login.jsp">Bolsa de Trabajo</a>
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
            <li class="nav-item active"><a class="nav-link" href="login.jsp"><i class="fa fa-sign-in"></i> Login</a></li>
            <li class="nav-item"><a class="nav-link" href="../registro/formulario_registro.jsp"><i class="fa fa-user"></i> Regístrate</a></li>
        </ul>
    </div>
</nav>
<div class="container">
    <form class="form-horizontal" role="form" method="GET" action="comprobar.jsp">
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <h2 class="text-center"">Login</h2>
                <hr>
            </div>
        </div>
        <div class="row">
        	<div class="col-md-3 field-label-responsive"></div>
            <div class="col-md-6">
                <div class="form-group has-danger">
				<%
				String cookie=new String();
				int encontrado=-1;
				String email=new String();            
				Cookie [] todosLosCookies=request.getCookies();
				Cookie unCookie=null;
					if (todosLosCookies!=null) {
						for(int i=0;(i<todosLosCookies.length) && (encontrado==-1);i++) {
							unCookie=todosLosCookies[i];
							if (unCookie.getName().equals("email")) {
								encontrado=i;
							}
						}
					if(encontrado!=-1) {
					 	cookie=unCookie.getValue();
						}
					}
				%>
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-at"></i></div>
                        <input type="text" name="email" value="<%=cookie%>" class="form-control" id="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" placeholder="E-Mail *" required autofocus>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
        	<div class="col-md-3 field-label-responsive"></div>
            <div class="col-md-6">
                <div class="form-group">
                    <div class="input-group mb-2 mr-sm-2 mb-sm-0">
                        <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-key"></i></div>
                        <input type="password" name="password" class="form-control" id="password" placeholder="Password *" required>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" align="center" style="padding-top: 1rem">
		<div class="col-md-4"></div>
			<div class="col-md-4">
                <button type="submit" class="btn btn-success"><i class="fa fa-sign-in"></i> Login</button>
				<a href="../../index.jsp" class="btn btn-danger" role="button"><i class="fa fa-sign-out"></i> Salir</a>
				<a class="btn btn-link" href="index_restablecer_password.jsp">¿Has olvidado la contraseña?</a>
            </div>
        </div>
		<div align="center" style="padding-top: 1rem">
		<%            
			if (error!=null && Integer.parseInt(error)==1) {	
				out.println("<div class='alert alert-info alert-dismissible fade show'>");
					out.println("<button type='button' class='close' data-dismiss='alert'>&times;</button>");
					out.println("<strong>Aviso!</strong> El usuario no está activo");
				out.println("</div>");
			}
			else if (error!=null && Integer.parseInt(error)==2) {
				out.println("<div class='alert alert-danger alert-dismissible fade show'>");
					out.println("<button type='button' class='close' data-dismiss='alert'>&times;</button>");
					out.println("<strong>Error!</strong> El usuario no está registrado ó la contraseña es incorrecta");
				out.println("</div>");
			}
			else if (error!=null && Integer.parseInt(error)==3) {
				out.println("<div class='alert alert-danger alert-dismissible fade show'>");
					out.println("<button type='button' class='close' data-dismiss='alert'>&times;</button>");
					out.println("<strong>Alerta!</strong> No puedes acceder al área privada del perfil registrado");
				out.println("</div>");
			}
			else if (error!=null && Integer.parseInt(error)==4) {
				out.println("<div class='alert alert-danger alert-dismissible fade show'>");
					out.println("<button type='button' class='close' data-dismiss='alert'>&times;</button>");
					out.println("<strong>Alerta!</strong> No puedes acceder al área privada del perfil administración");
				out.println("</div>");
			}          
		%>
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