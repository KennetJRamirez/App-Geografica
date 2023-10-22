<?php
class Conexion {
    private $host = "localhost";
    private $usuario = "root";
    private $contrasena = "";
    private $base_de_datos = "sistema_g";
    private $conexion;

    public function __construct() {
        try {
            $dsn = "mysql:host={$this->host};dbname={$this->base_de_datos}";
            $this->conexion = new PDO($dsn, $this->usuario, $this->contrasena);
            $this->conexion->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            echo "Error de conexión: " . $e->getMessage();
        }
    }

    public function getConexion() {
        return $this->conexion;
    }
}
?>
