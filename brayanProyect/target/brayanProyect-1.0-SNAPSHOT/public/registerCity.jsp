<%-- 
    Document   : registerCity
    Created on : 31-oct-2020, 23:53:30
    Author     : Brayan Hernandez
--%>

<%@page import="java.sql.*"%>
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.mysql.jdbc.Driver"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registro de ciudades</title>
    </head>

    <body style="text-align: center; background: yellow">
        <header>
            <div style="background: black; border-radius: 20px">
                <a style="font-size: 36pt; color: yellow;"href="../index.jsp">CENTRO DE CONTROL DE TURISMO</a>
            </div>
        </header>
        <div style="border: 5px solid black; padding: 50px; border-radius: 20px; height: 350px; margin-top: 10px ">
            <div id="regCiudad" style="text-align: center;">
                <h2>Registro de ciudades</h2>
                <form action="registerCity.jsp" method="post">
                    <center>
                        <table>                          
                            <tr>
                                <td>Nombre:</td>
                                <td><input type="text" name="cityName" required="true"></td>
                            </tr>
                            <tr>
                                <td>Cantidad de habitantes:</td>
                                <td><input type="number" name="cityPop" required="true" min="0"></td>
                            </tr>
                            <tr>
                                <td>Sitio más turistico:</td>
                                <td><input type="text" name="popLocation" required="true"></td>
                            </tr>
                            <tr>
                                <td>Hotel más reservado:</td>
                                <td><input type="text" name="hotel" required="true"></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td><input type="submit" value="Enviar"></td>
                            </tr>
                        </table>
                    </center>
                </form>
            </div>
            <%
                // Inicializamos los parametros para apertura base de datos MYSQL
                Connection con = null;
                // Definimos una variable para saber si el formulario fue diligenciado
                String Nombre = request.getParameter("cityName");
                if (Nombre != null) {
                    // Obtenemos y definimos las variables diligenciadas en el formulario
                    int Cantidad_habitantes = Integer.parseInt(request.getParameter("cityPop"));
                    String Sitio_turistico = request.getParameter("popLocation");
                    String Hotel_visitado = request.getParameter("hotel");
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        // Usamos jdbc driver para conectarnos a MYSQL                        
                        con = DriverManager.getConnection("jdbc:mysql://localhost/projectdb?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&user=admin&password=admin123");
                        // Preparamos una consulta de Inserción con los parámetros especificados
                        PreparedStatement ps = con.prepareStatement("INSERT INTO `cities`(`Nombre`, `Cantidad_habitantes`, `Sitio_turistico`, `Hotel_visitado`) "
                                + "VALUES (?,?,?,?);");
                        // Asignamos las variables que se diligenciaron en el formulario
                        ps.setString(1, Nombre);
                        ps.setInt(2, Cantidad_habitantes);
                        ps.setString(3, Sitio_turistico);
                        ps.setString(4, Hotel_visitado);
                        ps.execute();
                        // Redireccionamos a la pagina principal de visualización de Ciudades
                        request.getRequestDispatcher("../public/mainCity.jsp").forward(request, response);
                        response.sendRedirect("../public/mainCity.jsp");
                    } catch (Exception e) {
                        out.print("error mysql " + e);
                    }
                }
            %>
        </div>
        <footer>
            <div style="background: black; padding:10px; border-radius: 20px; margin-top: 15px">
                <h4 style="color: yellow">
                    Realizado por: Brayan Steeven Hernández Rodríguez
                </h4>
            </div>
        </footer>
    </body>

</html>
