<?php
include 'conexion.php'; 
$conexion = new Conexion();
$conn = $conexion->getConexion();

$sql = "SELECT * FROM accidente_geografico";
$result = $conn->query($sql);

if ($result->rowCount() > 0) {
    while ($row = $result->fetch()) {
        echo '<div class="card">';
        echo '<div class="card-body">';
        echo '<h5 class="card-title">' . $row["nombre"] . '</h5>';
        echo '<ul class="list-group list-group-flush">';

        if ($row["extension"] !== null) {
            echo '<li class="list-group-item">Extensión: ' . $row["extension"] . ' km²</li>';
        }

        if ($row["altura"] !== null) {
            echo '<li class="list-group-item">Altura: ' . $row["altura"] . ' metros</li>';
        }

        if ($row["ultima_erupcion"] !== null) {
            echo '<li class="list-group-item">Última erupción: ' . $row["ultima_erupcion"] . '</li>';
        }

        if ($row["caudal"] !== null) {
            echo '<li class="list-group-item">Caudal: ' . $row["caudal"] . '</li>';
        }

        if ($row["afluente"] !== null) {
            echo '<li class="list-group-item">Afluente: ' . $row["afluente"] . '</li>';
        }

        if ($row["origen"] !== null) {
            echo '<li class="list-group-item">Origen: ' . $row["origen"] . '</li>';
        }

        if ($row["desemboque"] !== null) {
            echo '<li class="list-group-item">Desemboque: ' . $row["desemboque"] . '</li>';
        }

        echo '</ul>';
        echo '</div>';
        echo '</div>';
    }
} else {
    echo 'No se encontraron elementos';
}
?>
