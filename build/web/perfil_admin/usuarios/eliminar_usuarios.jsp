<%@page import="java.lang.*,java.util.*,java.sql.*"%>
<%
String urljdbc; 
String loginjdbc; 
String passwordjdbc; 
//********************************
Connection conexion=null;
//*********************************
Statement sentencia=null;
//*********************************
String [] codigo_delete=request.getParameterValues("codigo");
if (codigo_delete!=null) {
    try {
        Class.forName("com.mysql.jdbc.Driver");
        urljdbc = getServletContext().getInitParameter("urljdbc"); 
        loginjdbc = getServletContext().getInitParameter("loginjdbc"); 
        passwordjdbc = getServletContext().getInitParameter("passwordjdbc"); 
        conexion = DriverManager.getConnection(urljdbc,loginjdbc,passwordjdbc);
        //************************************
        sentencia=conexion.createStatement();
        for (int i=0;i<codigo_delete.length;i++) {    
            sentencia.execute("delete from usuario where email='"+codigo_delete[i]+"'");
        }  
        //************************************
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
}      
%>
<script language="javascript" type="text/javascript">
    location.href="index_eliminar_usuarios.jsp";
</script>