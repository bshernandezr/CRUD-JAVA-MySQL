<%-- 
    Document   : registerCity
    Created on : 31-oct-2020, 23:53:30
    Author     : Brayan Hernandez
--%>

<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="WSP.citiesList"%>
<!DOCTYPE html>
<html lang="en">

    <head>        
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registro de viajes</title>
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
                <form action="addTRegister.jsp" method="post">
                    <center>
                        <table>
                            <tr>
                                <td>Ciudad : </td>
                                <td><select name="ciudadNid" >
                                        <%
                                            citiesList selectCity = new citiesList();
                                            out.print(selectCity.consumeCitiesList(true));
                                        %>                                            
                                    </select></td>
                            </tr>                           
                            <tr>
                                <td>Id turista:</td>
                                <td><input type="number" name="idRTourist" required="true" min="0"></td>
                            </tr>
                            <tr>
                                <td>Fecha:</td>
                                <td><input type="text" name="travelDate" required="true" placeholder="mm/dd/yyyy" pattern="^(((0?[1-9]|1[012])/(0?[1-9]|1\d|2[0-8])|(0?[13456789]|1[012])/(29|30)|(0?[13578]|1[02])/31)/(19|[2-9]\d)\d{2}|0?2/29/((19|[2-9]\d)(0[48]|[2468][048]|[13579][26])|(([2468][048]|[3579][26])00)))$"></td>
                            </tr> 
                            <tr>
                                <td></td>
                                <td><input type="submit" value="Agregar"></td>
                            </tr>
                        </table>
                    </center>
                </form>
            </div>
            <%
                // Inicializamos los parametros de la base de datos
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    // Nos conectamos a la base de datos usando jdbc Driver
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost/projectdb?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&user=admin&password=admin123");
                    // Definimos una variable para verificar si se diligencio el formulario
                    String flag = request.getParameter("idRTourist");
                    if (flag != null) {
                        ps = con.prepareStatement("SELECT * FROM tourist");
                        rs = ps.executeQuery();
                        LinkedList a = new LinkedList();
                        // Creamos una lista y la llenamos con la id de los turistas
                        while (rs.next()) {
                            a.push(rs.getString(3));
                        }
                        // Asignamos la variable correspondiente al ciudad y al ID codificado
                        String cityAid = request.getParameter("ciudadNid");
                        if (cityAid != null) {
                            // Preparamos una consulta de lectura
                            ps = con.prepareStatement("SELECT * FROM travelregister WHERE Ciudad=? AND Fecha=?");
                            // Decodificacmos cityAid usando split
                            String[] city = cityAid.split("--");
                            ps.setString(1, city[1]);
                            ps.setString(2, request.getParameter("travelDate"));
                            rs = ps.executeQuery();
                            // Realizamos la consulta usando el nombre de la ciudad y la fecha para determinar 
                            // la ocupación de turistas para un determinado dia y contamos los resultados
                            int numVis = 0;
                            while (rs.next()) {
                                numVis++;
                            }
                            // Realizamos la verificación de que el usuario este registrado en la base de datos usando el metodo contains
                            // de lo contrario enviamos un mensaje de alerta
                            String idT = request.getParameter("idRTourist");
                            if (!a.contains(idT)) {
                                out.println("<script>");
                                out.println("alert('Identificacion incorrecta. Por favor registre al turista" + cityAid + ".')");
                                out.println("</script>");
                            }
                            // Verificamos que el número de turistas para el mismo dia en la ciudad sea menor de 4
                            // de lo contrario enviamos un mensaje de alerta
                            if (numVis == 4) {
                                out.println("<script>");
                                out.println("alert('Ocupacion al máximo. Agende para otro dia.')");
                                out.println("</script>");
                            }
                            // Realizamos una consulta para verificar que no se este registrando un usuario el 
                            // el mismo dia y ciudad mas de una vez.
                            ps = con.prepareStatement("SELECT * FROM travelregister WHERE IdTurista=? AND Fecha=? AND Ciudad=?");
                            ps.setString(1, request.getParameter("idRTourist"));
                            ps.setString(2, request.getParameter("travelDate"));
                            ps.setString(3, city[1]);
                            rs = ps.executeQuery();
                            int rep = 0;
                            while (rs.next()) {
                                rep++;
                            }
                            // En caso de que el usuario ya este registrado para el mismo dia y ciudad se envia una alerta
                            if (rep != 0) {
                                out.println("<script>");
                                out.println("alert('El turista ya tiene agendado un viaje para ese dia')");
                                out.println("</script>");
                            }
                            // Verificamos que se cumplan los requisitos para acceder a la base de datos
                            if ((numVis != 4) && (a.contains(idT)) && (rep == 0)) {
                                // Preparamos la consulta de insercion
                                ps = con.prepareStatement("INSERT INTO `travelregister`(`Ciudad`, `IdTurista`, `Fecha`, `idCiudad`)"
                                        + " VALUES (?,?,?,?);");
                                ps.setString(1, city[1]);
                                ps.setString(2, request.getParameter("idRTourist"));
                                ps.setString(3, request.getParameter("travelDate"));
                                ps.setInt(4, Integer.parseInt(city[0]));
                                ps.execute();
                                // redireccionamos a la pagina principal de registro de viajes
                                request.getRequestDispatcher("../public/travelRegister.jsp").forward(request, response);
                                response.sendRedirect("../public/travelRegister.jsp");
                            }
                        } else {
                            // Se puede dar el caso de que se eliminen todas las ciudades y no se pueda registrar un viaje,
                            // en este caso se da un mensaje de alerta.
                            out.println("<script>");
                            out.println("alert('Debe registrar ciudades para poder registrar un viaje, Por favor vuelva a la página principal')");
                            out.println("</script>");
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