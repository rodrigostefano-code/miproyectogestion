/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package utils;

import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author Soldados
 */
public class NewMain {

    public static void main(String[] args) {
    try (Connection conn = Conexion.getConexion()) {
        if (conn != null) {
            System.out.println("✅ Conexión exitosa a la base de datos.");
        } else {
            System.out.println("❌ Falló la conexión.");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

    
}
