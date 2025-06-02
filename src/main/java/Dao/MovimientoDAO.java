
package Dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.swing.table.DefaultTableModel;
import utils.Conexion;


public class MovimientoDAO {
     public DefaultTableModel listarMovimientos() {
        DefaultTableModel modelo = new DefaultTableModel();
        String[] columnas = {"ID", "Tipo", "Descripción", "Fecha", "Cantidad", "ID_Producto"}; // Ajusta según tus columnas reales
        modelo.setColumnIdentifiers(columnas);

        String sql = "SELECT * FROM movimientos";

        try (Connection conn = Conexion.getConexion();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Object[] fila = new Object[columnas.length];
                for (int i = 0; i < columnas.length; i++) {
                    fila[i] = rs.getObject(i + 1);
                }
                modelo.addRow(fila);
            }

        } catch (Exception e) {
            System.out.println("Error al listar movimientos: " + e.getMessage());
        }

        return modelo;
    }
}
