/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package WSP;

import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.text.StringEscapeUtils;

/**
 *
 * @author Brayan Hernandez
 */
// Este WebService nos permite consumir la lista de ciudades y rellenar las tablas consultando la base de datos
@WebService(serviceName = "citiesList")
public class citiesList {
    
    @WebMethod(operationName = "consumeCitiesList")
    public String consumeCitiesList(Boolean withID) {
        // Inicializamos los parametros de la base de datos
        Connection con = null;        
        ResultSet rs = null;
        String salida = "";
        try {
            // Nos conectamos a MYSQL usando JDCB driver
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost/projectdb?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&user=admin&password=admin123");
            PreparedStatement ps = con.prepareStatement("SELECT * FROM cities");
            rs = ps.executeQuery();
            while (rs.next()) {
                // Usamos el argumento del metodo para diferenciar el consumo de la lista de ciudades teniendo en cuenta
                // que para el registro de viajes usamos el id de la ciudad y el nombre de la ciudad, esto lo decodificamos
                // usando split('--')
                if (withID) {
                    salida = salida + "<option value='" + rs.getString(1) + "--" + rs.getString(2) + "'>" + rs.getString(2) + "</option>\n";                                      
                } else {
                    salida = salida + "<option value='" + rs.getString(2) + "'>" + rs.getString(2) + "</option>\n";
                }
            }
        } catch (Exception e) {
            salida="error mysql " + e;
        }
        return salida;
    }

    @WebMethod(operationName = "fillTable")
    public String fillTable(String table, String prop, String data) {
        // Inicializamos los parametros para la base de datos
        Connection con = null;        
        ResultSet rs = null;
        PreparedStatement ps = null;
        String salida = "";
        try {
            // Nos conectamos a la base de datos usando jdbc Driver
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost/projectdb?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&user=admin&password=admin123");
            // Teniendo en cuenta los tres argumentos de entrada podemos realizar 3 tipos de consulta para las paginas principales de lectura de datos
            // en el caso de que prop != null se procedera a establecer la caracteristica y realizar la consulta
            if (prop == null) {
                ps = con.prepareStatement("SELECT * FROM " + table + ";");                
            } else {
                if (prop == "idTurista") {
                    ps = con.prepareStatement("SELECT * FROM " + table + " WHERE idTurista=?");                    
                    ps.setString(1, data);
                } else {
                    ps = con.prepareStatement("SELECT * FROM " + table + " WHERE idCiudad=?");                    
                    ps.setInt(1, Integer.parseInt(data));
                }
                
            }
            rs = ps.executeQuery();
            // Usamos las propiedades de rs para conocer el numero de columnas de la consulta realizada
            int numcol = rs.getMetaData().getColumnCount(); 
            int a=1;
            while (rs.next()) {
                salida = salida + "<tr>\n";
                for (int i = 1; i <= numcol; i++) {
                    // En caso de que el contador llegue a 8 codificamos para mostrar si se usa o no tarjeta de credito, esto para la tabla de turistas
                    if (i == 8) {
                        String tcred = (rs.getBoolean(i)) ? "Si" : "No";
                        salida = salida + "<td>" + tcred + "</td>\n";
                    }
                    else{
                    salida = salida + "<td>" + StringEscapeUtils.escapeHtml4(rs.getString(i)) + "</td>\n";
                    }
                }
                salida = salida + "</tr>\n";
                a++;
            }
        } catch (Exception e) {
            salida="error mysql " + e;
        }
        return salida;
    }
    
}
