 PARAMETER fec
 mes = ''
 DO CASE
    CASE MONTH(fec)=1
       mes = 'Enero'
    CASE MONTH(fec)=2
       mes = 'Febrero'
    CASE MONTH(fec)=3
       mes = 'Marzo'
    CASE MONTH(fec)=4
       mes = 'Abril'
    CASE MONTH(fec)=5
       mes = 'Mayo'
    CASE MONTH(fec)=6
       mes = 'Junio'
    CASE MONTH(fec)=7
       mes = 'Julio'
    CASE MONTH(fec)=8
       mes = 'Agosto'
    CASE MONTH(fec)=9
       mes = 'Septiembre'
    CASE MONTH(fec)=10
       mes = 'Octubre'
    CASE MONTH(fec)=11
       mes = 'Noviembre'
    CASE MONTH(fec)=12
       mes = 'Diciembre'
 ENDCASE
 RETURN mes
ENDFUNC
**
