PUBLIC caja_nro,fecape 
 usucaja = v_usu
 conectar()
 SQLEXEC(gncone, 'select * from aperturacaja where usuins=?usucaja and ape_cierre is null order by ape_fecha desc', 'controlcaja')
 desconectar()
* SET STEP ON
 IF RECCOUNT()>0
    caja_nro = caja_nro
    fecape = TTOD(ape_fecha)
    cierracursor('controlcaja')
    RETURN .T.
 ELSE
    MESSAGEBOX("No existe Caja Abierta", 016, "Mensaje del Sistema")
    RETURN .F.
 ENDIF
ENDFUNC
**
