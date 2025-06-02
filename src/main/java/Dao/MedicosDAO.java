package Dao;


import java.sql.*;
import java.util.*;
import modelo.Medicos;
import utils.Conexion;

public class MedicosDAO {
    public List<Medicos> listar() {
        List<Medicos> lista = new ArrayList<>();
        String sql = "SELECT * FROM medicos";

        try (Connection con = Conexion.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(new Medicos(
                    rs.getInt("id"),
                    rs.getString("nombre"),
                    rs.getString("especialidad"),
                    rs.getString("dni")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
