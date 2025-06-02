package Dao;

import java.sql.*;
import java.util.*;
import modelo.Paciente;
import utils.Conexion;

public class PacienteDAO {
    public boolean eliminarPorDNI(String dni) {
    String sql = "DELETE FROM paciente WHERE dni = ?";

    try (Connection conn = Conexion.getConexion();
         PreparedStatement pst = conn.prepareStatement(sql)) {

        pst.setString(1, dni);
        int filasAfectadas = pst.executeUpdate();
        return filasAfectadas > 0;

    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

    
    public List<Paciente> listarPacientes() {
    List<Paciente> lista = new ArrayList<>();
    String sql = "SELECT * FROM paciente";

    try (Connection conn = Conexion.getConexion();
         Statement stmt = conn.createStatement();
         ResultSet rs = stmt.executeQuery(sql)) {

        while (rs.next()) {
            int id = rs.getInt("id");
            String nombre = rs.getString("nombre");
            String apellido = rs.getString("apellido");
            String dni = rs.getString("dni");
            String direccion = rs.getString("direccion");
            String telefono = rs.getString("telefono");
            String correo = rs.getString("correo");

            Paciente p = new Paciente(id, nombre, dni, direccion, telefono, apellido, correo);
            lista.add(p);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return lista;
}

    
    public boolean agregarPaciente(Paciente paciente) {
    String sql = "INSERT INTO paciente (nombre, apellido, dni, direccion, telefono, correo) VALUES (?, ?, ?, ?, ?, ?)";

    try (Connection conn = Conexion.getConexion();
         PreparedStatement pst = conn.prepareStatement(sql)) {

        pst.setString(1, paciente.getNombre());
        pst.setString(2, paciente.getApellido());
        pst.setString(3, paciente.getDni());
        pst.setString(4, paciente.getDireccion());
        pst.setString(5, paciente.getTelefono());
        pst.setString(6, paciente.getCorreo());

        int filasAfectadas = pst.executeUpdate();
        return filasAfectadas > 0;

    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
   
    
   public String obtenerRecetasPorDNI(String dni) {
    StringBuilder recetas = new StringBuilder();
    String sql = 
        "SELECT p.nombre AS nombrePaciente, p.apellido AS apellidoPaciente, " +
        "       r.fecha, r.indicaciones " +
        "FROM paciente p " +
        "JOIN receta r ON p.id = r.id_paciente " +
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
