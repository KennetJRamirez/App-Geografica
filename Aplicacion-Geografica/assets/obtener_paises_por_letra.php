<?php
include 'conexion.php';
$conexion = new Conexion();
$conn = $conexion->getConexion();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $letra = $_POST['letra'];
    
    $sql = "SELECT * FROM pais WHERE nombre LIKE '$letra%'";
    $result = $conn->query($sql);

    if ($result->rowCount() > 0) {
        $paises = $result->fetchAll(PDO::FETCH_ASSOC);

        foreach ($paises as $pais) {
            echo '<div class="card">';
            echo '<div class="card-body">';
            echo '<h5 class="card-title">' . $pais['nombre'] . '</h5>';
            echo '<p class="card-text">Capital: ' . $pais['capital'] . '</p>';
            echo '<p class="card-text">Extensión: ' . $pais['extension'] . '</p>';
            echo '<p class="card-text">Idioma Oficial: ' . $pais['idioma_oficial'] . '</p>';
            echo '</div>';
            echo '</div>';
        }
    } else {
        echo 'No se encontraron países que comiencen con la letra ' . $letra;
    }
} else {
    echo 'Método de solicitud no válido';
}
?>