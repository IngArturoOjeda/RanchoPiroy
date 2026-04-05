*=====================================================================
* generar_config.prg
* Ejecutar UNA SOLA VEZ desde el IDE de FoxPro para crear piroy.cfg
* con la cadena de conexion encriptada.
*
* Pasos:
*   1. Modificar los parametros de conexion en la seccion marcada
*   2. Ejecutar DO generar_config en la ventana de comandos
*   3. Verificar que se creo piroy.cfg en la carpeta del proyecto
*   4. NO versionar piroy.cfg en Git (ya esta en .gitignore)
*=====================================================================

IF NOT "CIPHER50.FLL" $ SET("Library")
    SET LIBRARY TO CIPHER50.FLL ADDITIVE
ENDIF

*-- === MODIFICAR ESTOS VALORES ANTES DE EJECUTAR ==================
lcServer   = ".\"               && Ej: ".\", "192.168.100.49", "MISERVIDOR"
lcDatabase = "piroy"
lcUID      = "PiroyApp"
lcPWD      = "PiroyApp"         && Cambiar por la password real
*-- =================================================================

lcConexion = "Driver={SQL Server};Server=" + lcServer + ;
             ";trusted_connection=No" + ;
             ";uid=" + lcUID + ;
             ";pwd=" + lcPWD + ;
             ";Database=" + lcDatabase

* Encriptar y convertir a HEX para evitar problemas con bytes CR/LF en el archivo
lcEncriptada = STRCONV(Encrypt(lcConexion, "SPSPSP"), 15)

lcArchivo = ADDBS(SYS(5)+SYS(2003)) + "piroy.cfg"

LOCAL lnHandle
lnHandle = FCREATE(lcArchivo)
IF lnHandle > 0
    FPUTS(lnHandle, "# Configuracion de conexion RanchoPiroy")
    FPUTS(lnHandle, "# Generado: " + DTOC(DATE()) + " " + TIME())
    FPUTS(lnHandle, "# NO VERSIONAR ESTE ARCHIVO (ver .gitignore)")
    FPUTS(lnHandle, "CONEXION_E=" + lcEncriptada)
    FCLOSE(lnHandle)
    MESSAGEBOX("piroy.cfg generado correctamente en:" + CHR(13) + lcArchivo, ;
               64, "Configuracion generada")
ELSE
    MESSAGEBOX("Error al crear piroy.cfg en:" + CHR(13) + lcArchivo, ;
               16, "Error")
ENDIF
