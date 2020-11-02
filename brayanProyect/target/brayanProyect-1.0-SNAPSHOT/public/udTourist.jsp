<%-- 
    Document   : udTourist
    Created on : 31-oct-2020, 23:52:57
    Author     :Brayan Hernandez
--%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Editar/Eliminar Turista</title>
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
        <div style="border: 5px solid black; padding: 50px; border-radius: 20px; height: 350px; margin-top: 10px ">

            <center>
                <div>
                    <h2>Editar usuario</h2>
                    <form action="udTourist.jsp" method="post">
                        Digite el número de identificación: <input type="text" name="idUpdateTourist" required="true">
                        Seleccione la caracteristica que quiere editar:
                        <select name="filterTourist" form="uTourist" size="1">
                            <option value="Nombre">Nombre</option>
                            <option value="Presupuesto_viaje">Presupuesto</option>
                            <option value="Frecuencia_viaje">Frecuencia de viaje</option>
                            <option value="Destino">Destino</option>
                        </select>
                        Valor nuevo: <input type="text" name="editDataTourist" required="true">
                        <input type="submit" value="Actualizar">
                    </form>
                </div>
                <div style="margin-top: 30px;">
                    <h2>Eliminar usuario</h2>
                    <form action="udTourist.jsp" method="post">
                        Digite el número de identificación: <input type="text" name="idDelTourist" required="true">
                        <input type="submit" value="Eliminar">
                    </form>
                </div>
            </center>
            <%
                // Inicializamos los parametros para la base de datos
                Connection con = null;               
                try {
                    // Nos Conectamos a la base de datos usando jdbc Driver
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost/projectdb?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&user=admin&password=admin123");
                    // Definimos dos variables para verificar si se diligencio algun formulario
                    String flagD = request.getParameter("idDelTourist");
                    String flagU = request.getParameter("idUpdateTourist");
                    if (flagD != null) {
                        // Metodo para consulta de eliminar de una fila en la tabla de turistas
                        String idD = flagD;
                        PreparedStatement ps = con.prepareStatement("DELETE FROM `tourist` WHERE id=?");
                        ps.setString(1, idD);
                        ps.execute();
                        // Redireccionamos a la pagina principal de turistas
                        request.getRequestDispatcher("../public/mainTourist.jsp").forward(request, response);
                        response.sendRedirect("../public/mainTourist.jsp");
                    }
                    if (flagU != null) {
                        // Metodo para consulta de actualizar de una fila en la tabla de turistas
                        String idU = flagU;
                        String upT = request.getParameter("filterTourist");
                        PreparedStatement ps = con.prepareStatement("UPDATE `tourist` SET " + upT + "=? WHERE id=?");
                        // Verificamos que propiedad quiere editar el usuario y de acuerdo a esto establecemos 
                        // el codigo y el tipo de variables para realizar la consulta
                        if (upT == "Presupuesto_viaje" || upT == "Frecuencia_viaje") {
                            if (upT == "Presupuesto_viaje") {
                                double dataUp = Double.parseDouble(request.getParameter("editDataTourist"));
                                ps.setDouble(1, dataUp);
                            } else {
                                int dataUp = Integer.parseInt(request.getParameter("editDataTourist"));
                                ps.setInt(1, dataUp);
                            }
                            ps.setString(2, idU);
                            ps.execute();
                            // Redireccionamos a la pagina principal de turistas
                            request.getRequestDispatcher("../public/mainTourist.jsp").forward(request, response);
                            response.sendRedirect("../public/mainTourist.jsp");
                        } else {
                            String dataUp = request.getParameter("editDataTourist");
                            ps.setString(1, dataUp);
                            ps.setString(2, idU);
                            ps.execute();
                            // Redireccionamos a la pagina principal de turistas
                            request.getRequestDispatcher("../public/mainTourist.jsp").forward(request, response);
                            response.sendRedirect("../public/mainTourist.jsp");
                        }
                    }
                } catch (Exception e) {
                    out.print("error mysql " + e);
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