**
PROCEDURE Errores
 PARAMETER error, mensaje, mensaje1, programa, linea
 LOCAL ccadena
 ccadena = 'N� Error: '+STR(error)+CHR(13)+'Mensaje: '+mensaje+CHR(13)+'Mensaje: '+mensaje1+CHR(13)+'Programa: '+programa+CHR(13)+'L�nea: '+STR(linea)
 = MESSAGEBOX(ccadena, 064, '� Error !')
 IF error=1466
    STORE SQLCONNECT('rrhh') TO gncone
 ENDIF
ENDPROC
**
