<?php
include 'assets/conexion.php';
$conexion = new Conexion();
$conn = $conexion->getConexion();
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Sistema Geografico</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <a class="navbar-brand" href="#">Sistema Geografico</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="paisesDropdown" role="button" data-toggle="dropdown">Paises</a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="paisesDropdown">
                        <a class="dropdown-item" href="javascript:void(0)" id="filtroPorContinente">Por continente</a>
                        <a class="dropdown-item" href="javascript:void(0)" id="filtroA-Z">A - Z</a>
                    </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="javascript:void(0)" id="filtroPorCategoria">Accidentes Geográficos</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="container mt-4" id="continentesSelect" style="display: none;">
        <select class="custom-select" id="selectContinente">
            <option value="" selected>Selecciona un continente</option>
            <?php
            $sql = "SELECT nombre FROM continente";
            $result = $conn->query($sql);
            if ($result->rowCount() > 0) {
                while ($row = $result->fetch()) {
                    echo '<option value="' . $row["nombre"] . '">' . $row["nombre"] . '</option>';
                }
            }
            ?>
        </select>
    </div>

    <div class="container mt-4" id="filtroAZ" style="display: none;">
        <div class="btn-group d-flex justify-content-center" role="group">
            <?php
            foreach (range('A', 'Z') as $letra) {
                echo '<button type="button" class="btn btn-secondary letra" data-letra="' . $letra . '">' . $letra . '</button>';
            }
            ?>
        </div>
    </div>

    <div class="container mt-4" id="resultado">
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        $('#filtroPorContinente').on('click', function() {
            $('#continentesSelect').toggle();
            $('#filtroAZ').hide();
            $('#resultado').empty();
        });

        $('#selectContinente').change(function() {
            var continenteSeleccionado = $(this).val();
            // Oculta otros filtros
            $('#filtroAZ').hide();
            $('#resultado').empty();

            $.ajax({
                url: 'assets/obtener_paises_por_continente.php',
                type: 'POST',
                data: { continente: continenteSeleccionado },
                success: function(data) {
                    console.log('Solicitud exitosa:', data); // Mensaje de depuración
                    $('#resultado').html(data);
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.log('Error en la solicitud:', textStatus, errorThrown);
                    $('#resultado').html('<p>Error al cargar los países del continente ' + continenteSeleccionado + '</p>');
                }
            });
        });

        $('#filtroA-Z').on('click', function() {
            $('#filtroAZ').toggle();
            $('#continentesSelect').hide();
            $('#resultado').empty();
        });

        $('.letra').on('click', function() {
            var letra = $(this).data('letra');
            // Oculta otros filtros
            $('#continentesSelect').hide();
            $('#filtroAZ').hide();
            $('#resultado').empty();

            $.ajax({
                url: 'assets/obtener_paises_por_letra.php',
                type: 'POST',
                data: { letra: letra },
                success: function(data) {
                    console.log('Solicitud exitosa:', data);
                    $('#resultado').html(data);
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.log('Error en la solicitud:', textStatus, errorThrown);
                    $('#resultado').html('<p>Error al cargar los países que comienzan con la letra ' + letra + '</p>');
                }
            });
        });

        $('#filtroPorCategoria').on('click', function() {
            $('#continentesSelect').hide();
            $('#filtroAZ').hide();
            $('#resultado').empty();

            $.ajax({
                url: 'assets/obtener_accidentes_geograficos.php',
                type: 'GET',
                success: function(data) {
                    console.log('Solicitud exitosa:', data);
                    $('#resultado').html(data);
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.log('Error en la solicitud:', textStatus, errorThrown);
                    $('#resultado').html('<p>Error al cargar los Accidentes Geográficos</p>');
                }
            });
        });
    </script>
</body>
</html>