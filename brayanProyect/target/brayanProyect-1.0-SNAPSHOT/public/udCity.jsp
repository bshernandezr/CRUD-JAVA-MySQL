<%-- 
    Document   : udCity
    Created on : 31-oct-2020, 23:52:35
    Author     : Brayan Hernandez
--%>

<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<!DOCTYPE html>
<html lang="en">

    <head>    
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Editar/Eliminar Ciudades</title>
        <style>
            .options {
                color: black;
                background: gray;
                border: 1px solid black;
                border-radius: 2px;
            }
        </style>
    </head>

    <body style="text-align: center; background: yellow">
        <header>
            <div style="background: black; border-radius: 20px">
                <a style="font-size: 36pt; color: yellow;" href="../index.jsp">CENTRO DE CONTROL DE TURISMO</a>
            </div>
        </header>
        <div style="border: 5px solid black; padding: 50px; border-radius: 20px; height: 350px; margin-top: 10px">

            <center>
                <div>
                    <h2>Editar Ciudad</h2>
                    <form action="udCity.jsp" method="post">
                        Digite el número de identificación: <input type="number" name="idUpdateCity" required="true" min="0">
                        Seleccione la caracteristica que quiere editar:
                        <select name="filterCity" form="uCity" size="1">
                            <option value="Nombre">Nombre</option>
                            <option value="Cantidad_habitantes">Cantidad de Habitantes</option>
                            <option value="Sitio_turistico">Sitio más turistico</option>
                            <option value="Hotel_visitado">Hotel más visitado</option>
                        </select>
                        Valor nuevo: <input type="text" name="editDataCity" required="true">
                        <input type="submit" value="Actualizar">
                    </form>
                </div>

                <div style="margin-top: 30px;">
                    <h2>Eliminar Ciudad</h2>
                    <form id="dCity" action="udCity.jsp" method="post">
                        Digite el número de identificación: <input type="number" name="idDelCity" required="true" min="0">
                        <input type="submit" value="Eliminar">
                    </form>
                </div>
            </center>
            <%
                // Inicializamos parametros MYSQL
                Connection con = null;
                Statement st = null;
                ResultSet rs = null;
                try {
                    // Realizamos la conexión a MYSQL usando jbdc Driver
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost/projectdb?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&user=admin&password=admin123");
                    st = con.createStatement();
                    // Definimos dos variables para determinar si se diligenciaron los formularios
                    String flagD = request.getParameter("idDelCity");
                    String flagU = request.getParameter("idUpdateCity");
                    if (flagD != null) {
                        // Código para consulta de eliminación de fila en la tabla Ciudades
                        int idD = Integer.parseInt(flagD);
                        PreparedStatement ps = con.prepareStatement("DELETE FROM `cities` WHERE id=?");
                        ps.setInt(1, idD);
                        ps.execute();
                        request.getRequestDispatcher("../public/mainCity.jsp").forward(request, response);
                        response.sendRedirect("../public/mainCity.jsp");
                    }
                    if (flagU != null) {
                        // Código para consulta de eliminación de fila en la tabla Ciudades
                        int idU = Integer.parseInt(flagU);
                        String upC = request.getParameter("filterCity");
                        // Usamos un condicional if para saber que caracteristica se desea modificar
                        // ya que son de diferente tipo, se confirmara si se trata de la cantidad de habitantes
                        // ya que es el unico dato de tipo int que se puede modificar de lo contrario sera tipo
                        // string
                        if (upC == "Cantidad_habitantes") {
                            int dataUp = Integer.parseInt(request.getParameter("editDataCity"));
                            PreparedStatement ps = con.prepareStatement("UPDATE `cities` SET " + upC + "=? WHERE id=?");
                            ps.setInt(1, dataUp);
                            ps.setInt(2, idU);
                            ps.execute();
                        //Redireccionamos a la pagina principal de ciudades
                            request.getRequestDispatcher("../public/mainCity.jsp").forward(request, response);
                            response.sendRedirect("../public/mainCity.jsp");
                        } else {
                            String dataUp = request.getParameter("editDataCity");
                            PreparedStatement ps = con.prepareStatement("UPDATE `cities` SET " + upC + "=? WHERE id=?");
                            ps.setString(1, dataUp);
                            ps.setInt(2, idU);
                            ps.execute();
                        //Redireccionamos a la pagina principal de ciudades
                            request.getRequestDispatcher("../public/mainCity.jsp").forward(request, response);
                            response.sendRedirect("../public/mainCity.jsp");
                        }
                    }
                } catch (Exception e) {
                    out.print("error mysql " + e);
                }

            %>
            <%--
               String flagD = request.getParameter("idDelCity");
               if (flagD != null) {
                   
                   } catch (Exception e) {
                       out.print("error mysql " + e);
                   }                    
               }
            --%>



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