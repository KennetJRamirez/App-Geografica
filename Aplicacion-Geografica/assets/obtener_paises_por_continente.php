<?php
include 'conexion.php';
$conexion = new Conexion();
$conn = $conexion->getConexion();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $continente = $_POST['continente'];

    $sql = "SELECT p.*, c.nombre AS nombre_continente FROM pais p
            INNER JOIN continente c ON p.id_continente = c.id_continente
            WHERE c.nombre = :continente";

    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':continente', $continente, PDO::PARAM_STR);
    $stmt->execute();

    if ($stmt->rowCount() > 0) {
        $paises = $stmt->fetchAll(PDO::FETCH_ASSOC);

        foreach ($paises as $pais) {
            echo '<div class="card">';
            echo '<div class="card-body">';
            echo '<h5 class="card-title">' . $pais['nombre'] . '</h5>';
            echo '<p class="card-text">Capital: ' . $pais['capital'] . '</p>';
            echo '<p class="card-text">Extensión: ' . $pais['extension'] . '</p>';
            echo '<p class="card-text">Idioma Oficial: ' . $pais['idioma_oficial'] . '</p>';
            echo '<p class="card-text">Continente: ' . $pais['nombre_continente'] . '</p>';
            echo '</div>';
            echo '</div>';
        }
    } else {
        echo 'No se encontraron países en el continente ' . $continente;
    }
} else {
    echo 'Método de solicitud no válido';
}
?>