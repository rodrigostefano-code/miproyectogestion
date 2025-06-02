package modelo;

public class Medicos {
    private int id;
    private String nombre;
    private String especialidad;
    private String dni;

    public Medicos() {}

    public Medicos(int id, String nombre, String especialidad, String dni) {
        this.id = id;
        this.nombre = nombre;
        this.especialidad = especialidad;
        this.dni = dni;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getEspecialidad() { return especialidad; }
    public void setEspecialidad(String especialidad) { this.especialidad = especialidad; }

    public String getDni() { return dni; }
    public void setDni(String dni) { this.dni = dni; }
}
