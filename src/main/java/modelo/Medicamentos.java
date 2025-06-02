package modelo;

public class Medicamentos {
    private int id;
    private String nombre;
    private String descripcion;
    private int stock;
    private double precio;
    private int idCategoria;
    private java.sql.Date fechaVencimiento;

    // getters y setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }

    public int getIdCategoria() { return idCategoria; }
    public void setIdCategoria(int idCategoria) { this.idCategoria = idCategoria; }

    public java.sql.Date getFechaVencimiento() { return fechaVencimiento; }
    public void setFechaVencimiento(java.sql.Date fechaVencimiento) { this.fechaVencimiento = fechaVencimiento; }
}
