package modelo;

public class Receta {
    private int id;
    private int idPaciente;
    private int idMedico;
    private String fecha;
    private String indicaciones;

    public Receta() {}

    public Receta(int id, int idPaciente, int idMedico, String fecha, String indicaciones) {
        this.id = id;
        this.idPaciente = idPaciente;
        this.idMedico = idMedico;
        this.fecha = fecha;
        this.indicaciones = indicaciones;
    }

    // Getters y Setters
}
