*==================================
* seguridad.prg
*==================================

*------------------------------------
SET STEP ON
FUNCTION CargarPermisos(tcUsuario)
*------------------------------------
 IF USED("curPermisos")
    USE IN curPermisos
 ENDIF
 *MESSAGEBOX('El codigo de usuario: '+STR(tcUsuario))
  conectar() 
   IF SQLEXEC(gncone,'execute seguridad.sp_permisos_usuario ?tcUsuario','curPermisos') < 0
      MESSAGEBOX("Error cargando permisos")
      RETURN .F.
   ENDIF    
  desconectar() 

    ? "Permisos cargados:", RECCOUNT("curPermisos")
    
    IF NOT USED("curPermisos")
        MESSAGEBOX("Permisos no cargadosSSSSSSSSS")
        RETURN .F.
    ENDIF
    
    SELECT curPermisos
    INDEX ON UPPER(ALLTRIM(nombre_permiso)) TAG permiso
    SET ORDER TO permiso 
    
    *DISPLAY STATUS
    RETURN .T.
ENDFUNC

FUNCTION TienePermiso(tcPermiso)
SET STEP ON
    IF NOT USED("curPermisos")
        MESSAGEBOX("Permisos no cargados")
        RETURN .F.
    ENDIF
    
*!*	    ? "SET EXACT:", SET("EXACT")
*!*	    ? "CURSOR:", USED("curPermisos")
*!*	    ? "REGISTROS:", IIF(USED("curPermisos"), RECCOUNT("curPermisos"), 0)
    LOCAL llRetorno, lnAreaActual

    lnAreaActual = SELECT()
    llRetorno = .F.
   
    IF USED("curPermisos")
        SELECT curPermisos

         llRetorno = SEEK(UPPER(ALLTRIM(tcPermiso)),"curPermisos","permiso")

       * llRetorno = FOUND()
       
        SELECT (lnAreaActual)
       
    ENDIF

    RETURN llRetorno
    

