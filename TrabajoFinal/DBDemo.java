import java.sql.*;

public class DBDemo {
  public static void main(String[] args) throws SQLException, ClassNotFoundException {
    // Load the JDBC driver
    Class.forName("org.mariadb.jdbc.Driver");
    System.out.println("Driver loaded");

    // Try to connect
    Connection connection = DriverManager.getConnection
      ("jdbc:mariadb://localhost/DW", "root", "Nano01234");

    System.out.println("It works!");

    connection.close();
  }
}
