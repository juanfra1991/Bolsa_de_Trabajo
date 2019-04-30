<%@page import="org.apache.commons.lang3.RandomStringUtils"%>
<%@page import="java.lang.*,java.util.*,java.sql.*"%>
<%@page contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="refresh" content="6; URL=../../index.jsp">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<title>Activador</title>
    
<script type="text/javascript">
var seconds = 5; //número de segundos a contar
function secondPassed() {

var remainingSeconds = seconds % 60; //calcula los segundos
	//si los segundos usan sólo un dígito, añadimos un cero a la izq
  	if (remainingSeconds < 5) { 
    	remainingSeconds = "" + remainingSeconds; 
	} 
	document.getElementById('countdown').innerHTML = remainingSeconds; 
  	if (seconds == 0) { 
		clearInterval(countdownTimer); 
  	} 
  	else { 
		seconds--; 
  	} 
}
var countdownTimer = setInterval(secondPassed, 1000);
</script>
</head>
<body>
<%
String urljdbc; 
String loginjdbc; 
String passwordjdbc; 
//********************************
Connection conexion=null;
//*********************************
Statement sentencia=null;
//**********************************
ResultSet sentencia_sql=null;
//*********************************
StringBuffer built_stmt=new StringBuffer();
//*****************************************
String code=request.getParameter("code");
String email=request.getParameter("email");
//**************************************************
try {
	Class.forName("com.mysql.jdbc.Driver");
	urljdbc = getServletContext().getInitParameter("urljdbc"); 
	loginjdbc = getServletContext().getInitParameter("loginjdbc"); 
	passwordjdbc = getServletContext().getInitParameter("passwordjdbc"); 
	conexion = DriverManager.getConnection(urljdbc,loginjdbc,passwordjdbc);
	sentencia=conexion.createStatement(ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);
	built_stmt.append("select * from activador where email='"+email+"' and cadena='"+code+"'");
	sentencia_sql= sentencia.executeQuery(built_stmt.toString());
	sentencia_sql.next();
	if (sentencia_sql.getString(2).equals(code) && sentencia_sql.getString(1).equals(email)) {  
		sentencia.executeUpdate("update usuario set activo='1' where email='"+email+"'");
		sentencia.executeUpdate("delete from activador where email='"+email+"'");
		out.println("<div class='container-fluid'>");
        out.println("<h1>Se ha activado tu cuenta</h1>");    
    		out.println("<a href='../../index.jsp' class='btn btn-info' role='button'>Haz clic si no te redirige en <label id='countdown'></label> segundos</a>");
        out.println("</div>");
	}
	sentencia_sql.close();
	sentencia.close();  
}
catch (ClassNotFoundException error1) {
	out.println("ClassNotFoundException: No se puede localizar el Controlador de ORACLE:" +error1.getMessage());
}
catch (SQLException error2) {
	out.println("Código de verificacion erroneo");
}
catch (Exception error3) {
	out.println("Se ha producido un error indeterminado: "+error3.getMessage());
}
finally {
	try {
		if (conexion != null)
			conexion.close();                
	}
	catch (Exception error3) {
		out.println("Se ha producido una excepción finally "+ error3.getMessage());
	}
}
%>
<!-- Optional JavaScript -->

<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</body>
</html>