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
String cod_oferta=request.getParameter("cod_oferta");
String titulo=request.getParameter("titulo");
String descripcion=request.getParameter("descripcion");
String email=request.getParameter("email");
String cif=request.getParameter("cif");
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
        built_stmt1.append("select * from oferta where cod_oferta='+cod_oferta'");
        sentencia_sql= sentencia1.executeQuery(built_stmt1.toString());
        if (!sentencia_sql.next()) {       
            sentencia=conexion.createStatement();
            built_stmt.append("insert into oferta values ('"+cod_oferta+"','"+titulo+"','"+descripcion+"',NOW(),'"+email+"','1','"+cif+"')");
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
    location.href="index_anadir_ofertas.jsp";
</script>