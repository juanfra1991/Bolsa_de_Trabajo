<%@page import="java.io.*,java.lang.*,java.util.*,java.sql.*"%>
<%
String file=request.getParameter("documento");
String dirFicheros = getServletContext().getRealPath( getServletContext().getInitParameter("dirdownloadFile"));        
try {
    FileInputStream archivo =new FileInputStream(dirFicheros+"/"+file);         
    int longitud = archivo.available();
    byte[] datos = new byte[longitud];
    archivo.read(datos);
    archivo.close();
    response.setContentType("application/octet-stream");
    response.setHeader("Content-Disposition","attachment;filename="+file);
    ServletOutputStream ouputStream = response.getOutputStream();
    ouputStream.write(datos);
    ouputStream.flush();
    ouputStream.close();
}
catch (Exception e) {
    e.printStackTrace();
}
%>
<script language="javascript" type="text/javascript">
    href.location=history.back();
</script>