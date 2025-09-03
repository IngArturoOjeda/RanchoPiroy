 _SCREEN.caption = 'R.A.E.C. & ASO.'
 _SCREEN.closable = .F.
 _SCREEN.autocenter = .T.
* SET STEP ON
 IF FILE('C:\windows\system\acxso.dll')
    RESTORE FROM C:\windows\system\acxso.dll ADDITIVE
    IF ntrd='peneduro'
       DO principalrrhh
    ELSE
      * _SCREEN.picture = 'IMAGENES\WARNING.GIF'
       _SCREEN.picture = 'C:\sistemaranchopiroy\imagenes\warning.gif'
       MESSAGEBOX('Esta intentando ejecutar una copia no autorizada, contacte con su proveedor del Sistema', 048, 'Mensaje de Error')
    ENDIF
 ELSE
    *_SCREEN.picture = 'IMAGENES\WARNING.GIF'
     _SCREEN.picture = 'C:\sistemaranchopiroy\imagenes\warning.gif'
    MESSAGEBOX('Esta intentando ejecutar una copia no autorizada, contacte con su proveedor del Sistema', 048, 'Mensaje de Error')
 ENDIF
ENDPROC
**
