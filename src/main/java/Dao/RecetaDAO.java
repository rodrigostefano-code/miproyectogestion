package Dao;

import java.sql.*;
import java.util.*;
import modelo.Receta;
import utils.Conexion;

public class RecetaDAO {
public String obtenerRecetasPorDNI(String dni) {
    StringBuilder recetas = new StringBuilder();
    String sql = 
        "SELECT p.nombre AS nombrePaciente, p.apellido AS apellidoPaciente, " +
        "       r.fecha, r.indicaciones " +
        "FROM paciente p " +
        "JOIN receta r ON p.id = r.id " +
        "WHERE p.dni = ?";

    try (Connection conn = Conexion.getConexion();
         PreparedStatement pst = conn.prepareStatement(sql)) {

        pst.setString(1, dni);
        ResultSet rs = pst.executeQuery();

        while (rs.next()) {
            String nombrePaciente = rs.getString("nombrePaciente");
            String apellidoPaciente = rs.getString("apellidoPaciente");
            String fecha = rs.getString("fecha");
            String indicaciones = rs.getString("indicaciones");

            recetas.append("Paciente: ")
                   .append(nombrePaciente).append(" ")
                   .append(apellidoPaciente).append("\n");
            recetas.append("Fecha: ").append(fecha).append("\n");
            recetas.append("Indicaciones: ").append(indicaciones).append("\n");
            recetas.append("--------------------------\n");
        }
        rs.close();

    } catch (SQLException e) {
        e.printStackTrace();
        return "Error al buscar recetas: " + e.getMessage();
    }

    if (recetas.length() == 0) {
        return "No se encontraron recetas para el DNI: " + dni;
    }

    return recetas.toString();
}


}
