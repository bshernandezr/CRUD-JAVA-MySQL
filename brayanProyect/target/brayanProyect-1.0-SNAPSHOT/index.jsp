<%-- 
    Document   : index
    Created on : 31-oct-2020, 23:31:40
    Author     : Brayan Hernandez
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CRUD turismo</title>
</head>

<body style="text-align: center; background: yellow">
    <header>
        <div style="background: black; border-radius: 20px">
          <a style="font-size: 36pt; color: yellow" href="index.jsp">CENTRO DE CONTROL DE TURISMO</a> 
        </div>     
    </header>
        <div style="border: 5px solid black; padding: 50px; border-radius: 20px; height: 350px; margin-top: 10px ">
            <span style="display: block; text-align: left; float: left">
                <img src="https://static.hosteltur.com/app/public/uploads/img/articles/2018/01/01/L_5c1a9959f0738_ecoturismo-foto02.jpg" alt="Turismo"
                 width="400px" style="border-radius: 20px">
            </span> 
            <span style="display: block; text-align: left; float: left; padding-left: 100px">
                <h2 style="font-size: 24pt">Bienvenido</h2>
                <p><a style="font-size: 16pt" href="./public/mainTourist.jsp">Interfaz para control y/o registro turistas.</a></p>
                <p><a style="font-size: 16pt" href="./public/mainCity.jsp">Interfaz para control y/o registro ciudades</a></p>
                <p><a style="font-size: 16pt" href="./public/travelRegister.jsp">Registro de Viajes</a></p>
            </span>             
        </div>     
    <footer>
        <div style="background: black; padding:2px; border-radius: 20px; margin-top: 15px">
            <h4 style="color: yellow">
                Realizado por: Brayan Steeven Hernández Rodríguez
            </h4>            
        </div>
    </footer>
</body>

</html>