<%@page import="java.lang.*,java.util.*,java.sql.*"%>
<%
HttpSession datossesion=request.getSession();
//********************************
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
String email=request.getParameter("email");
String password=request.getParameter("password");
String rec=request.getParameter("rec"); 
int error=-1;
//**************************************************
try {
	Class.forName("com.mysql.jdbc.Driver");
	urljdbc = getServletContext().getInitParameter("urljdbc"); 
	loginjdbc = getServletContext().getInitParameter("loginjdbc"); 
	passwordjdbc = getServletContext().getInitParameter("passwordjdbc"); 
	conexion = DriverManager.getConnection(urljdbc,loginjdbc,passwordjdbc);
	sentencia=conexion.createStatement(ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);
	built_stmt.append("select * from usuario where email='"+email+"' and password=AES_ENCRYPT('"+password+"','0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')");
	sentencia_sql= sentencia.executeQuery(built_stmt.toString());
	if (sentencia_sql.next()) {  
		if (Integer.valueOf(sentencia_sql.getString("activo")).intValue()==1) {    
			datossesion.setAttribute("email",sentencia_sql.getString("email"));
			datossesion.setAttribute("perfil",new Integer(sentencia_sql.getString("perfil")));
			datossesion.setAttribute("nombre",sentencia_sql.getString("nombre"));
			datossesion.setAttribute("apellido",sentencia_sql.getString("apellido"));
			datossesion.setAttribute("fecha_nacimiento",sentencia_sql.getString("fecha_nacimiento"));
			datossesion.setAttribute("password",sentencia_sql.getString("password"));
			datossesion.setAttribute("cod_sector",sentencia_sql.getString("cod_sector"));
			if(rec!=null) {
				Cookie miCookie=new Cookie("email",sentencia_sql.getString("email"));
				miCookie.setMaxAge(60*60*24*31);
				miCookie.setPath("/");
				response.addCookie(miCookie);
			}
			if (Integer.valueOf(sentencia_sql.getString("perfil")).intValue()==1) {
			%>
			<script language="javascript" type="text/javascript">
				location.href="../../perfil_admin/index_administrador.jsp"
			</script>
			<%
			}
				else {
				%>
				<script language="javascript" type="text/javascript">
					location.href="../../perfil_registrado/index_registrado.jsp"
				</script>
				<%
			}
		}
		else {
			error=1; // el usuario existe en el sistema activo=0
		}    
	}
	else {
	error=2; // el usuario no existe en el sistema
	}
	sentencia_sql.close();
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
<script language="javascript" type="text/javascript">
	location.href="../login/login.jsp?error=<%=error%>";
</script>