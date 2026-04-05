*====================================
* generar_permisos.prg
*====================================

LOCAL lcArchivo, lnHandle

lcArchivo = "permisos.prg"

conectar()

SQLEXEC(gncone, ;
"SELECT nombre_permiso FROM seguridad.permisos ORDER BY nombre_permiso", ;
"curPerm")

desconectar()

lnHandle = FCREATE(lcArchivo)

=FPUTS(lnHandle,"*====================================")
=FPUTS(lnHandle,"* permisos.prg")
=FPUTS(lnHandle,"* Generado automáticamente")
=FPUTS(lnHandle,"*====================================")
=FPUTS(lnHandle,"")

SELECT curPerm
SCAN

    lcPermiso = ALLTRIM(nombre_permiso)

    =FPUTS(lnHandle,"PUBLIC PERM_"+lcPermiso)
    =FPUTS(lnHandle,"PERM_"+lcPermiso+' = "'+lcPermiso+'"')
    =FPUTS(lnHandle,"")

ENDSCAN

=FCLOSE(lnHandle)

MESSAGEBOX("permisos.prg generado correctamente")