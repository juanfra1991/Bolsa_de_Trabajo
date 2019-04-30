<%@page import="java.lang.*,java.util.*,java.sql.*"%>
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
String cod_noticia=request.getParameter("cod_noticia");
//**************************************************
try {
    Class.forName("com.mysql.jdbc.Driver");
    urljdbc = getServletContext().getInitParameter("urljdbc"); 
    loginjdbc = getServletContext().getInitParameter("loginjdbc"); 
    passwordjdbc = getServletContext().getInitParameter("passwordjdbc"); 
    conexion = DriverManager.getConnection(urljdbc,loginjdbc,passwordjdbc);
    sentencia=conexion.createStatement(ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);
    built_stmt.append("select * from noticia where cod_noticia='"+cod_noticia+"'");
    sentencia_sql= sentencia.executeQuery(built_stmt.toString());
    if (sentencia_sql.next()) {  
        out.println("No esta disponible"); // Devuelve 6 caracteres
    }
    else {
        out.println("Si esta disponible");
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