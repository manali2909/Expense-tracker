
import java.sql.Connection;
import java.sql.DriverManager;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author DELL
 */
public class DataBase implements dbProp{
    static Connection conn = null;

    public static Connection getConnection() {

            if(conn==null){
            try {
                Class.forName("com.mysql.jdbc.Driver"); 
                conn = (Connection)DriverManager.getConnection(URL, USER_NAME, PASSWORD);
            }
            catch (Exception e) {
                e.printStackTrace();
            }
            }
        
        return conn;
    }
}
