<?php
    $server = "127.0.0.1";
    $user   = "root";
    $pass   = "";

    try 
    {
        $conexion = new PDO("mysql:host=$server;dbname=practicaslibres", $user,$pass);
        $conexion->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
        echo "Conexion establecida";
    }
    catch(PDOException)
    {
        echo "Error de conexion".$error;
    }

?>;