<%@page import="java.lang.*,java.util.*,java.sql.*"%>
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
//*****************************************
String cif=request.getParameter("cif");
String nombre=request.getParameter("nombre");
String email=request.getParameter("email");
String direccion=request.getParameter("direccion");
String cod_sector=request.getParameter("cod_sector");
//*************************************************
int estado=0;
//**************************************************
{    
    try {
        Class.forName("com.mysql.jdbc.Driver");
        urljdbc = getServletContext().getInitParameter("urljdbc"); 
        loginjdbc = getServletContext().getInitParameter("loginjdbc"); 
        passwordjdbc = getServletContext().getInitParameter("passwordjdbc"); 
        conexion = DriverManager.getConnection(urljdbc,loginjdbc,passwordjdbc);
        sentencia1=conexion.createStatement(ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);
        built_stmt1.append("select * from empresa where cif='+cif'");
        sentencia_sql= sentencia1.executeQuery(built_stmt1.toString());
        if (!sentencia_sql.next()) {       
            sentencia=conexion.createStatement();
            built_stmt.append("insert into empresa values ('"+cif+"','"+nombre+"','"+email+"','"+direccion+"','"+cod_sector+"')");
            sentencia.execute(built_stmt.toString());
            sentencia.close();
            estado=0;
        }
        else {
            estado=-1;
        }
        sentencia_sql.close();
        sentencia1.close();
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
    location.href="index_anadir_empresas.jsp";
</script>