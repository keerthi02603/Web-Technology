package com.example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/bookstore";
    private static final String USER = "keerthi";
    private static final String PASSWORD = "Keerthi@123"; // Update with your DB password

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Ensure driver is loaded
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}

