package config;
import java.sql.*;

/** *
// * @author Filipe & Caio
 */
public class ConectaDB {
    
    public static Connection conectar() throws ClassNotFoundException{
        Connection conn = null;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/GPSforAgent","root","");        
        }
        catch(SQLException ex){
            System.out.println("Erro - SQL: " + ex);
        }
        return conn;
    }
}
