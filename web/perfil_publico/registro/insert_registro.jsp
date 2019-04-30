<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.*"%>
<%@page import="org.apache.commons.lang3.RandomStringUtils"%>
<%@page import="java.lang.*,java.util.*,java.sql.*,java.io.*"%>
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
    conexion.setAutoCommit(false);

    sentencia=conexion.createStatement();
    String cadena = RandomStringUtils.randomAlphanumeric(40);

    built_stmt.append("insert into usuario values ('"+email+"',AES_ENCRYPT('"+password+"','0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'),'"+nombre+"','"+apellido+"',STR_TO_DATE('"+fecha_nacimiento+"','%d/%m/%Y'),NOW(),'2','0','"+cod_sector+"')");
    sentencia.execute(built_stmt.toString());

    built_stmt1.append("insert into activador values ('"+email+"', '"+cadena+"', NOW())");
    sentencia.execute(built_stmt1.toString());

    sentencia.close();
    conexion.commit();
    estado=0;
   	/**************************************************  
    Paso 2.- Crear Carpeta Personal
    <context-param>
    <param-name>dir_user_registrados</param-name>
    <param-value>/dir_users</param-value>
    </context-param>
    import java.io.*;
   	**************************************************/
   	try {
        String dirUpload = getServletContext().getRealPath( getServletContext().getInitParameter("dir_user_registrados")); 
        File directorio_raiz_user=new File(dirUpload+"/"+email);
        if (!directorio_raiz_user.exists()) {
            directorio_raiz_user.mkdir();
        }
   	}  
    catch (Exception error) {
        out.print( error.getMessage());
   	}
   //**************************************************  
   // Paso 3.- Enviar Correo de Activación
   //**************************************************  
   Statement sentencia2=null;
   ResultSet sentencia_sql2=null;
   sentencia2=conexion.createStatement(ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);
   sentencia_sql2=sentencia2.executeQuery("select * from activador where email='"+email+"'");
   sentencia_sql2.next();
    try {
        Properties props = System.getProperties();
        // Definir las características del servidor de correo
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.setProperty("mail.smtp.starttls.enable", "true");
        props.setProperty("mail.smtp.port","587");
        props.setProperty("mail.smtp.auth", "true");
        // Obtener la sesión
        Session s = Session.getDefaultInstance(props);
        // Creación del mensaje
        MimeMessage message = new MimeMessage(s);
        message.setFrom(new InternetAddress("bolsatrabajodaw@gmail.com"));
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
        message.setSubject("Proceso de Activación");
        StringBuffer texto = new StringBuffer();
        texto.append("Haz clic en el siguiente enlace para activar tu cuenta:"+"\n");
        texto.append("http://35.180.41.53:8090/BolsaTrabajo_DAW/perfil_publico/registro/activar.jsp?email="+email+"&code="+sentencia_sql2.getString(2)+"");
        message.setText(texto.toString());
        // Envio del mensaje de correo electrónico
        Transport t = s.getTransport("smtp");
        t.connect("bolsatrabajodaw@gmail.com","juanfrayjuanma");
        t.sendMessage(message,message.getAllRecipients());
        //Cerramos la conexion
        t.close();
    }
    catch (Exception la) {
        out.print("Error al enviar mensaje:" + la.getMessage());
        la.printStackTrace();
    }
}
catch (ClassNotFoundException error1) {
    out.println("ClassNotFoundException: No se puede localizar el Controlador de ORACLE:" + error1.getMessage());
}
catch (SQLException error2) {
    out.println("Error en la sentencia sql que se ha intentado ejecutar (Posible error léxico y/o sintáctico): " + error2.getMessage());
    conexion.rollback();
}
catch (Exception error3) {
    out.println("Se ha producido un error indeterminado: " + error3.getMessage());
}
finally {
    try {
        if (conexion != null)
            conexion.close();                
    }
    catch (Exception error3) {
        out.println("Se ha producido una excepción finally " + error3.getMessage());
    }
}
%> 
<script language="javascript" type="text/javascript">
    location.href="../../index.jsp";
</script>