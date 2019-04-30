<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %> 
<%@ page import="java.util.*" %> 
<%@ page import="org.apache.commons.fileupload.*" %> 
<%@ page import="org.apache.commons.fileupload.disk.*" %> 
<%@ page import="org.apache.commons.fileupload.servlet.*" %> 
<%@ page import="org.apache.commons.io.*" %> 
<%@ page import="java.io.*" %> 
<%
FileItemFactory factory = new DiskFileItemFactory();
ServletFileUpload upload = new ServletFileUpload(factory);
String email=null;
String dirUpload = getServletContext().getRealPath(getServletContext().getInitParameter("dir_user_registrados"));
// req es la HttpServletRequest que recibimos del formulario.
// Los items obtenidos serán cada uno de los campos del formulario,
// tanto campos normales como ficheros subidos.
List items = upload.parseRequest(request);
// Se recorren todos los items, que son de tipo FileItem
for (Object item : items) {
    FileItem uploaded = (FileItem) item;
    // Hay que comprobar si es un campo de formulario. Si no lo es, se guarda el fichero
    // subido donde nos interese
    if (!uploaded.isFormField()) {
        // No es campo de formulario, guardamos el fichero en algún sitio
        if (uploaded.getSize()>0 && email!=null) {    
            // Creación del directorio del usurio sino existe
            File directorio = new File(dirUpload+"/"+email);
            if (!directorio.exists()) {
                directorio.mkdir();
            }
            String extension = uploaded.getName().substring(uploaded.getName().lastIndexOf("."));
            File fichero = new File(dirUpload+"/"+email, uploaded.getName());
            File renombrar = new File(dirUpload+"/"+email+"/avatar"+extension);
            // Si existe un avatar se elimina para subir el nuevo
            if (renombrar.exists()) {
                renombrar.delete();
            }
        // No es campo de formulario, guardamos el fichero en algún sitio
        uploaded.write(fichero);
        fichero.renameTo(renombrar);
            %>
            <script type="text/javascript">              
                alert("Avatar subido correctamente!")
            </script>
            <%
        }
        else {
            %>
            <script type="text/javascript">
                alert("No se ha seleccionado el avatar!")
            </script>
            <%
        }    
    }
    else {
        // es un campo de formulario, podemos obtener clave y valor
        String key = uploaded.getFieldName();
        if (key.compareTo("email")==0) {
            email = uploaded.getString();
        }
    }
}
%>
<script language="javascript" type="text/javascript">
    location.href="index_subir_avatar.jsp";
</script>