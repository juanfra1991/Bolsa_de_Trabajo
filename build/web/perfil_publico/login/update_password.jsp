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

    built_stmt.append("update usuario set password = AES_ENCRYPT('"+cadena+"','0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ') where email = '"+email+"'");
    sentencia.execute(built_stmt.toString());
    
    built_stmt1.append("insert into recuperador values ('"+email+"', AES_ENCRYPT('"+cadena+"','0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'), NOW())");
    sentencia.execute(built_stmt1.toString());

    sentencia.close();
    conexion.commit();
    estado=0;
    //**************************************************  
    // Paso 2.- Enviar Correo de Activacion
    //**************************************************  
    Statement sentencia2=null;
    ResultSet sentencia_sql2=null;
    sentencia2=conexion.createStatement(ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);
    sentencia_sql2=sentencia2.executeQuery("select email, cadena from recuperador where email='"+email+"' and cadena=AES_ENCRYPT('"+cadena+"','0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')");
    sentencia_sql2.next();
    try {
        Properties props = System.getProperties();
        // Definir las caracteristicas del servidor de correo
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.setProperty("mail.smtp.starttls.enable", "true");
        props.setProperty("mail.smtp.port","587");
        props.setProperty("mail.smtp.auth", "true");
        // Obtener la sesion
        Session s = Session.getDefaultInstance(props);
        // Creacion del mensaje
        MimeMessage message = new MimeMessage(s);
        message.setFrom(new InternetAddress("bolsatrabajodaw@gmail.com"));
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
        message.setSubject("Restablecer Contraseña");
        StringBuffer texto = new StringBuffer();
        texto.append("Hemos de restablecido tu contraseña "+sentencia_sql2.getString(1)+", recomendamos cambiarla en el proximo inicio de sesion: Contraseña: "+cadena+"");
        message.setText(texto.toString());
        // Envio del mensaje de correo electronico
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
    out.println("Error en la sentencia sql que se ha intentado ejecutar (Posible error lexico y/o sintactico): " + error2.getMessage());
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
        out.println("Se ha producido una excepcion finally " + error3.getMessage());
    }
}
%> 
<script language="javascript" type="text/javascript">
    location.href="../../index.jsp";
</script>