<%-- 
    Document   : travelRegister
    Created on : 01-nov-2020, 21:48:40
    Author     : Brayan Hernandez
--%>


<%@page import="WSP.citiesList"%>
<%@page import="java.sql.*"%>
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="com.mysql.jdbc.Driver"%>

<!DOCTYPE html>
<html lang="en">

    <head>           
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Historial de viajes</title>
        <style>
            .options {
                color: black;
                background: gray;
                border: 1px solid black;
                border-radius: 2px;
            }            
            table tr td{
                min-width: 100px;
            }
        </style>
    </head>

    <body style="text-align: center; background: yellow">        
        <header>
            <div style="background: black; border-radius: 20px">
                <a style="font-size: 36pt; color: yellow;" href="../index.jsp">CENTRO DE CONTROL DE TURISMO</a>
            </div>
        </header>
        <div style="border: 5px solid black; padding: 30px; border-radius: 20px; min-height:380px ; margin-top: 10px">
            <div style="margin-bottom: 20px">                    
                <h2>Consultar historial Turista</h2>
                <form action="travelRegister.jsp" method="post">
                    Digite identificación:<input type="text" name="idTourist">
                    <input type="submit" value="Buscar">
                </form>
                <h2>Consultar historial Ciudad</h2>
                <form action="travelRegister.jsp" method="post">
                    Digite identificación:<input type="text" name="idCity">
                    <input type="submit" value="Buscar">
                </form>   
                <form style=" margin-top:10px ; margin-bottom: 10px " action="travelRegister.jsp" method="post">
                    Ver todos los registros: 
                    <button name="show" type="submit">Mostrar</button>
                </form> 
                <div>
                    <a class="options" href="addTRegister.jsp">Agregar nuevo registro</a>
                </div>

            </div>
            <center>
                <table>
                    <tr style="color: yellow; background: black;">
                        <td>Id Viaje</td>
                        <td>Id Destino</td>
                        <td>Ciudad</td>
                        <td>Id Turista</td>
                        <td>Fecha</td>                       
                    </tr>
                    <%
                        // Asignamos variables para verificar si se diligencio algun formulario
                        String flagC = request.getParameter("idCity");
                        String flagT = request.getParameter("idTourist");
                        String flagS = request.getParameter("show");
                        try {
                            // Instanciamos el webService citiesList()                              
                            citiesList fillR=new citiesList();                                                       
                            if (flagC != null) { 
                                //usamos el metodo fillTable para imprimir la tabla de Registro de viajes filtrando por idCiudad
                                out.println(fillR.fillTable("travelregister", "idCiudad", flagC));                                                               
                            } else if (flagT != null) {
                                //usamos el metodo fillTable para imprimir la tabla de Registro de viajes filtrando por idTurista
                                out.println(fillR.fillTable("travelregister", "idTurista", flagT));                                
                            } else if (flagS != null) {
                                //usamos el metodo fillTable para imprimir la tabla de Registro de viajes
                                out.println(fillR.fillTable("travelregister", null, null));                               
                            } else {
                                //usamos el metodo fillTable para imprimir la tabla de Registro de viajes 
                                out.println(fillR.fillTable("travelregister", null, null));
                            }                                                                             
                        } catch (Exception e) {
                            out.print("error mysql " + e);
                        }
                    %>
                </table>              
            </center>


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
