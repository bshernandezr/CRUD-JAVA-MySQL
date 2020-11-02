<%-- 
    Document   : mainCity
    Created on : 31-oct-2020, 23:35:38
    Author     : Brayan Hernandez
--%>

<%@page import="java.sql.*"%>
<%@page import="org.apache.commons.text.StringEscapeUtils"%>
<%@page import="WSP.citiesList"%>
<!DOCTYPE html>
<html lang="en">

    <head>           
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ciudades</title>
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
                <a style="font-size: 36pt; color: yellow;" href="../index.jsp">CENTRO DE CONTROL DE TURISMO</a>
            </div>
        </header>
        <div style="border: 5px solid black; padding: 50px; border-radius: 20px; min-height:350px ; margin-top: 10px">

            <center>
                <table>
                    <tr style="color: yellow; background: black;">
                        <td>Id</td>
                        <td>Nombre</td>
                        <td>Cantidad de habitantes</td>
                        <td>Sitio más turistico</td>
                        <td>Hotel más reservado</td>                        
                    </tr>
                    <%
                        //Llamamos el web Service citiesList() para usar el metodo fillTable
                        //con ese método imprimimos todas las filas correspondiente a la tabla ciudades presentes en la base de datos
                        // para esto pasamos como argumento 
                        // "cities" que es en el nombre de la tabla, ver definición de método fillTable
                        // para saber que función tienen los otros dos argumentos.
                        try {                            
                            citiesList fillT=new citiesList();
                            out.println(fillT.fillTable("cities",null,null));
                        } catch (Exception e) {
                            out.print("error mysql " + e);
                        }
                        
                    %>
                </table>
                <div id="options">
                    <a class="options" href="registerCity.jsp">Agregar</a>
                    <a class="options" href="udCity.jsp">Editar o Eliminar</a>

                </div>
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
