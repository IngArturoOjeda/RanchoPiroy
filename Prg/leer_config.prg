*=====================================================================
* leer_config.prg
* Lee y desencripta la cadena de conexion desde piroy.cfg
* Para generar piroy.cfg ejecutar: generar_config.prg
*=====================================================================
FUNCTION LeerConexion()
    LOCAL lcArchivo, lcLinea, lcConexionEnc, lcConexion, lnHandle

    lcArchivo = ADDBS(SYS(5)+SYS(2003)) + "piroy.cfg"

    IF NOT FILE(lcArchivo)
        MESSAGEBOX("Archivo de configuracion no encontrado." + CHR(13) + CHR(13) + ;
                   "Ruta esperada:" + CHR(13) + lcArchivo + CHR(13) + CHR(13) + ;
                   "Ejecute generar_config.prg para crearlo.", ;
                   16, "Error de configuracion")
        RETURN ""
    ENDIF

    lcConexionEnc = ""
    lnHandle = FOPEN(lcArchivo)
    IF lnHandle > 0
        lcLinea = FGETS(lnHandle)
        DO WHILE NOT FEOF(lnHandle) OR NOT EMPTY(lcLinea)
            lcLinea = ALLTRIM(lcLinea)
            IF LEFT(lcLinea, 11) = "CONEXION_E="
                lcConexionEnc = SUBSTR(lcLinea, 12)
                EXIT
            ENDIF
            lcLinea = FGETS(lnHandle)
        ENDDO
        FCLOSE(lnHandle)
    ELSE
        MESSAGEBOX("No se pudo abrir piroy.cfg", 16, "Error de configuracion")
        RETURN ""
    ENDIF

    IF EMPTY(lcConexionEnc)
        MESSAGEBOX("Formato invalido en piroy.cfg" + CHR(13) + ;
                   "No se encontro la clave CONEXION_E.", 16, "Error de configuracion")
        RETURN ""
    ENDIF

    IF NOT "CIPHER50.FLL" $ SET("Library")
        SET LIBRARY TO CIPHER50.FLL ADDITIVE
    ENDIF

    * Decodificar HEX y luego desencriptar
    lcConexion = Decrypt(STRCONV(lcConexionEnc, 16), "SPSPSP")

    IF EMPTY(lcConexion)
        MESSAGEBOX("Error al desencriptar la configuracion." + CHR(13) + ;
                   "El archivo piroy.cfg puede estar corrupto.", 16, "Error de configuracion")
        RETURN ""
    ENDIF

    RETURN lcConexion
ENDFUNC
