  PARAMETER w_num, x_let
 DIMENSION car(9, 4)
 DIMENSION x1_num(2)
 DIMENSION x2_num(4)
 DIMENSION x3_num(12)
 STORE 'Ciento ' TO car(1, 1)
 STORE 'Doscientos ' TO car(2, 1)
 STORE 'Trescientos ' TO car(3, 1)
 STORE 'Cuatrocientos ' TO car(4, 1)
 STORE 'Quinientos ' TO car(5, 1)
 STORE 'Seiscientos ' TO car(6, 1)
 STORE 'Setecientos ' TO car(7, 1)
 STORE 'Ochocientos ' TO car(8, 1)
 STORE 'Novecientos ' TO car(9, 1)
 STORE 'Diez ' TO car(1, 2)
 STORE 'Veinte ' TO car(2, 2)
 STORE 'Treinta ' TO car(3, 2)
 STORE 'Cuarenta ' TO car(4, 2)
 STORE 'Cincuenta ' TO car(5, 2)
 STORE 'Sesenta ' TO car(6, 2)
 STORE 'Setenta ' TO car(7, 2)
 STORE 'Ochenta ' TO car(8, 2)
 STORE 'Noventa ' TO car(9, 2)
 STORE 'Un ' TO car(1, 3)
 STORE 'Dos ' TO car(2, 3)
 STORE 'Tres ' TO car(3, 3)
 STORE 'Cuatro ' TO car(4, 3)
 STORE 'Cinco ' TO car(5, 3)
 STORE 'Seis ' TO car(6, 3)
 STORE 'Siete ' TO car(7, 3)
 STORE 'Ocho ' TO car(8, 3)
 STORE 'Nueve ' TO car(9, 3)
 STORE 'Once ' TO car(1, 4)
 STORE 'Doce ' TO car(2, 4)
 STORE 'Trece ' TO car(3, 4)
 STORE 'Catorce ' TO car(4, 4)
 STORE 'Quince ' TO car(5, 4)
 STORE 'Diez y Seis ' TO car(6, 4)
 STORE 'Diez y Siete ' TO car(7, 4)
 STORE 'Diez y Ocho ' TO car(8, 4)
 STORE 'Diez y Nueve ' TO car(9, 4)
 STORE STR(w_num, 15, 2) TO x_num
 STORE VAL(LEFT(x_num, 6)) TO x1_num(1)
 STORE VAL(SUBSTR(x_num, 7, 6)) TO x1_num(2)
 STORE VAL(SUBSTR(x_num, 1, 3)) TO x2_num(1)
 STORE VAL(SUBSTR(x_num, 4, 3)) TO x2_num(2)
 STORE VAL(SUBSTR(x_num, 7, 3)) TO x2_num(3)
 STORE VAL(SUBSTR(x_num, 10, 3)) TO x2_num(4)
 STORE 1 TO i
 DO WHILE i<=12
    STORE VAL(SUBSTR(x_num, i, 1)) TO x3_num(i)
    STORE i+1 TO i
 ENDDO
 STORE ' ' TO x_let
 STORE 1 TO i
 DO WHILE i<=4
    IF x2_num(i)>0
       IF x2_num(i)=100
          STORE x_let+'Cien ' TO x_let
       ELSE
          STORE (i-1)*3 TO j
          IF x3_num(j+1)>0
             STORE x_let+car(x3_num(j+1), 1) TO x_let
          ENDIF
          IF x3_num(j+2)>0 .AND. (x3_num(j+3)=0 .OR. x3_num(j+2)<>1)
             STORE x_let+car(x3_num(j+2), 2) TO x_let
          ENDIF
          IF x3_num(j+2)>1 .AND. x3_num(j+3)>0
             STORE x_let+'y ' TO x_let
          ENDIF
          IF x3_num(j+3)>0
             IF x3_num(j+2)=1
                STORE x_let+car(x3_num(j+3), 4) TO x_let
             ELSE
                STORE x_let+car(x3_num(j+3), 3) TO x_let
             ENDIF
          ENDIF
       ENDIF
    ENDIF
    IF i=2
       IF x1_num(1)>1
          STORE x_let+'Millones ' TO x_let
       ELSE
          IF x1_num(1)>0
             STORE x_let+'Millón ' TO x_let
          ENDIF
       ENDIF
    ENDIF
    IF (i=1 .OR. i=3) .AND. x2_num(i)>0
       STORE x_let+'Mil ' TO x_let
    ENDIF
    STORE i+1 TO i
 ENDDO
 IF x3_num(12)=1 .AND. RIGHT(x_let, 4)=' UN '
    STORE LEN(x_let) TO longitud
    STORE LEFT(x_let, longitud-1)+'O' TO x_let
 ENDIF
 IF RIGHT(STR(w_num, 15, 2), 2)<>'00'
    STORE x_let+'con '+RIGHT(STR(w_num, 15, 2), 2)+'/100' TO x_let
 ENDIF
 STORE TRIM(x_let)+'.' TO x_let
 RETURN x_let
ENDFUNC
**
