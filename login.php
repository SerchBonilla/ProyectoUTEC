<?php
    include('conexion.php');

    if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["email"]) && isset($_POST["password"])) {

        $email = $_POST["email"];
        $password = $_POST["password"];


        $sql = "CALL SP_ValidarUsuario(:email, :password)";
        $stmt = $conexion->prepare($sql);
        $stmt->bindParam(':email', $email, PDO::PARAM_STR);
        $stmt->bindParam(':password', $password, PDO::PARAM_STR);
        $stmt->execute();


        $result = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($result) {
        
        header("Location: menu.php");
        exit();
    } else {
        
        echo "Error. Correo o contraseña incorrectos.";
    }
}


require ("login.html");
?>;