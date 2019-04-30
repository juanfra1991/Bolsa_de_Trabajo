<%@page import="java.lang.*,java.util.*,java.sql.*,java.io.*"%>
<%@page import="java.util.Properties,java.sql.*,javax.mail.*,javax.mail.internet.*,javax.mail.Transport,java.net.*"%>
<%@page import="java.security.MessageDigest"%>
<%
String urljdbc; 
String loginjdbc; 
String passwordjdbc; 
//********************************
Connection conexion=null;
//*********************************
Statement sentencia=null;
Statement sentencia1=null;
//**********************************
ResultSet sentencia_sql=null;
//*********************************
StringBuffer built_stmt=new StringBuffer();
StringBuffer built_stmt1=new StringBuffer();
StringBuffer correo=new StringBuffer();
//************************************************
String email=request.getParameter("email");
String password=request.getParameter("password");
String nombre=request.getParameter("nombre");
String apellido=request.getParameter("apellido");
String fecha_nacimiento=request.getParameter("fecha_nacimiento");
String cod_sector=request.getParameter("cod_sector");
//*************************************************
int estado=0;
//**************************************************   
try {
    Class.forName("com.mysql.jdbc.Driver");
    urljdbc = getServletContext().getInitParameter("urljdbc"); 
    loginjdbc = getServletContext().getInitParameter("loginjdbc"); 
    passwordjdbc = getServletContext().getInitParameter("passwordjdbc"); 
    conexion = DriverManager.getConnection(urljdbc,loginjdbc,passwordjdbc);
    sentencia=conexion.createStatement();

    built_stmt.append("update usuario set password=AES_ENCRYPT('"+password+"','0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'), nombre='"+nombre+"', apellido='"+apellido+"', fecha_nacimiento=STR_TO_DATE('"+fecha_nacimiento+"','%d/%m/%Y'), cod_sector='"+cod_sector+"' where email='"+email+"'");
    sentencia.execute(built_stmt.toString());
    sentencia.close();
    estado=0;
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
    location.href="index_modificar_perfil.jsp";
</script>