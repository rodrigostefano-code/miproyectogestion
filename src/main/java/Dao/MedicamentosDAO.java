package Dao;


import java.sql.*;
import java.util.*;
import modelo.Medicamentos;
import utils.Conexion;

public class MedicamentosDAO {
 public List<Medicamentos> listarMedicamentos() {
    List<Medicamentos> lista = new ArrayList<>();
    String sql = "SELECT * FROM medicamentos";

    try (Connection con = Conexion.getConexion();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            Medicamentos m = new Medicamentos();
            m.setId(rs.getInt("id"));
            m.setNombre(rs.getString("nombre"));
            m.setDescripcion(rs.getString("descripcion"));
            m.setStock(rs.getInt("stock"));
            m.setPrecio(rs.getDouble("precio"));
            m.setIdCategoria(rs.getInt("idCategoria"));
            m.setFechaVencimiento(rs.getDate("fecha_vencimiento"));
            lista.add(m);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return lista;
}

    
    public boolean modificarCampos(Medicamentos m) {
    StringBuilder sql = new StringBuilder("UPDATE medicamentos SET ");
    List<Object> parametros = new ArrayList<>();

    if (m.getNombre() != null) {
        sql.append("nombre = ?, ");
        parametros.add(m.getNombre());
    }
    if (m.getDescripcion() != null) {
        sql.append("descripcion = ?, ");
        parametros.add(m.getDescripcion());
    }
    if (m.getStock() > 0) {
        sql.append("stock = ?, ");
        parametros.add(m.getStock());
    }
    if (m.getPrecio() > 0) {
        sql.append("precio = ?, ");
        parametros.add(m.getPrecio());
    }
    if (m.getIdCategoria() > 0) {
        sql.append("id_categoria = ?, ");
        parametros.add(m.getIdCategoria());
    }
    if (m.getFechaVencimiento() != null) {
        sql.append("fecha_vencimiento = ?, ");
        parametros.add(m.getFechaVencimiento());
    }

    // Remueve la última coma y espacio
    if (parametros.isEmpty()) {
        return false; // No hay nada que actualizar
    }
    sql.setLength(sql.length() - 2);

    sql.append(" WHERE id = ?");
    parametros.add(m.getId());

    try (Connection con = Conexion.getConexion();
         PreparedStatement ps = con.prepareStatement(sql.toString())) {

        for (int i = 0; i < parametros.size(); i++) {
            ps.setObject(i + 1, parametros.get(i));
        }

        int filas = ps.executeUpdate();
        return filas > 0;
    } catch (SQLException ex) {
        ex.printStackTrace();
        return false;
    }
}



    
    public boolean eliminarMedicamentoPorId(int id) {
    String sql = "DELETE FROM medicamentos WHERE id = ?";

    try (Connection conexion = Conexion.getConexion();
         PreparedStatement ps = conexion.prepareStatement(sql)) {

        ps.setInt(1, id);
        int filas = ps.executeUpdate();
        return filas > 0;

    } catch (SQLException e) {
        System.out.println("Error al eliminar el medicamento: " + e.getMessage());
        return false;
    }
}

 public boolean insertarMedicamento(Medicamentos med) {
        String sql = "INSERT INTO medicamentos (id, nombre, descripcion, stock, precio, fecha_vencimiento, idCategoria) VALUES (?, ?, ?, ?, ?, ?, ?)";

        // Obtener la conexión usando tu clase Conexion
        try (Connection conexion = Conexion.getConexion();
             PreparedStatement ps = conexion.prepareStatement(sql)) {

            ps.setInt(1, med.getId());
            ps.setString(2, med.getNombre());
            ps.setString(3, med.getDescripcion());
            ps.setInt(4, med.getStock());
            ps.setDouble(5, med.getPrecio());
            ps.setDate(6, med.getFechaVencimiento());
            ps.setInt(7, med.getIdCategoria());

            int res = ps.executeUpdate();
            return res > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }

  
  
 
 
 
 
 }  

   

    
}


   

