/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MyConnection;

/**
 *
 * @author Stel
 */
import java.net.URL;
import java.sql.*;

public class MyConnection {

    public static Connection getConnection(String username, String password) {
        Connection con = null;
        String urlStr = null;
        try {
            //Load the Driver Class Now
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            urlStr = "jdbc:mysql://russet.wccnet.edu/" + username + "?user=" + username + "&password=" + password;
            System.out.println("Connecting to : " + urlStr);
            con = DriverManager.getConnection(urlStr);
        } catch (SQLException ex) {
            System.err.println("SQLException(" + urlStr + "): " + ex);
        } catch (Exception ex) {
            System.err.println("Exception(" + urlStr + "): " + ex);
        }
        return con;
    }
}
