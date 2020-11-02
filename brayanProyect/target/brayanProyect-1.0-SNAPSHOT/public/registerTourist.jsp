<%-- 
    Document   : registerTourist
    Created on : 31-oct-2020, 23:53:44
    Author     : Brayan Hernandez
--%>


<%@page import="java.sql.*"%>
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="WSP.citiesList"%>
<!DOCTYPE html>
<html lang="en">

    <head>

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registro de turistas</title>
        <style>
            .options {
                color: black;
                background: gray;
                border: 1px solid black;
                border-radius: 2px;
            }
            #options{
                margin-top: 30px;
            }
        </style>
    </head>

    <body style="text-align: center; background: yellow">
        <header>
            <div style="background: black; border-radius: 20px">
                <a style="font-size: 36pt; color: yellow;"href="../index.jsp">CENTRO DE CONTROL DE TURISMO</a>
            </div>
        </header>
        <div style="border: 5px solid black; padding: 50px; border-radius: 20px; height: 350px; margin-top: 10px ">
            <div id="regTurista" style="text-align: center;">
                <h2>Registro de turistas</h2>
                <form action="registerTourist.jsp" method="post">
                    <center>
                        <table>
                            <tr>
                                <td>Nombre completo:</td>
                                <td><input type="text" name="fullName" required="true"></td>
                            </tr>
                            <tr>
                                <td>Fecha de Nacimiento(mm/dd/yyyy):</td>
                                <td><input type="text" name="birthDate" required="true" placeholder="mm/dd/yyyy" pattern="^(((0?[1-9]|1[012])/(0?[1-9]|1\d|2[0-8])|(0?[13456789]|1[012])/(29|30)|(0?[13578]|1[02])/31)/(19|[2-9]\d)\d{2}|0?2/29/((19|[2-9]\d)(0[48]|[2468][048]|[13579][26])|(([2468][048]|[3579][26])00)))$"></td>
                            </tr>
                            <tr>
                                <td>Número de identificación :</td>
                                <td><input type="text" name="numID" required="true"></td>
                            </tr>
                            <tr>
                                <td>Tipo de identificación:</td>
                                <td><input type="text" name="typeID" required="true" maxlength="2" placeholder="CC/RC/TI/PA/CE"></td>
                            </tr>
                            <tr>
                                <td>Frecuencia de viaje(meses):</td>
                                <td><input type="number" name="travelFrec" required="true" min="0" max="36"></td>
                            </tr>
                            <tr>
                                <td>Presupuesto de viaje: </td>
                                <td><input type="number" name="travelBudget" required="true" min="0"></td>
                            </tr>
                            <tr>
                                <td>Destino: </td>
                                <td><select name="destination" >
                                        <%
                                            // Usamos el metodo consumeCitiesList del WebService citiesList 
                                            // Para obtener la lista de ciudades y ponerlas como opciones
                                            // en el formulario
                                            citiesList selectCity = new citiesList();
                                            out.print(selectCity.consumeCitiesList(false));
                                        %>                                            
                                    </select></td>
                            </tr>
                            <tr>
                                <td>Marque si usa tarjeta de credito:</td>
                                <td><input type="checkbox" name="credUse"></td>
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
                //Inicializamos los parametros para la base de datos
                Connection con = null;               
                // Definimos una variable para determinar si se diligencio el formulario
                String Nombre = request.getParameter("fullName");                
                if (Nombre != null) {
                    // Asignamos las variables obtenidas en el formulario
                    String Fecha_Nacimiento = request.getParameter("birthDate");
                    String id = request.getParameter("numID");
                    String tipo_id = request.getParameter("typeID");
                    int Frecuencia_viaje = Integer.parseInt(request.getParameter("travelFrec"));
                    double Presupuesto_viaje = Double.parseDouble(request.getParameter("travelBudget"));
                    String Destino = request.getParameter("destination");
                    Boolean Tcredito = (request.getParameter("credUse") != null) ? true : false;
                    // Nos conectamos a la base de datos usando jbdc Driver
                    try {
                        Class.forName("com.mysql.jdbc.Driver");                        
                        con = DriverManager.getConnection("jdbc:mysql://localhost/projectdb?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&user=admin&password=admin123");
                        // Establecemos la consulta de inserción
                        PreparedStatement ps = con.prepareStatement("INSERT INTO `tourist`(`Nombre`, `Fecha_Nacimiento`, `id`, `tipo_id`, `Frecuencia_viaje`,`Presupuesto_viaje`, `Destino`, `Tcredito`)"
                                + " VALUES (?,?,?,?,?,?,?,?);");
                        ps.setString(1, Nombre);
                        ps.setString(2, Fecha_Nacimiento);
                        ps.setString(3, id);
                        ps.setString(4, tipo_id);
                        ps.setInt(5, Frecuencia_viaje);
                        ps.setDouble(6, Presupuesto_viaje);
                        ps.setString(7, Destino);
                        ps.setBoolean(8, Tcredito);
                        ps.execute();
                        // Redireccionamos a la pagina principal de turistas
                        request.getRequestDispatcher("../public/mainTourist.jsp").forward(request, response);
                        response.sendRedirect("../public/mainTourist.jsp");
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
