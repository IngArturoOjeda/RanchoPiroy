 SET STEP ON
 conectar()
   = SQLEXEC(gncone, 'select * from usuario', 'usua')
 desconectar()
 SELECT usua
 LOCATE ALL FOR usuario=v_usu
 IF FOUND()
    *usudpto = dpto
    *IF (v_compu='INFORMATICA2' .OR. v_compu='LUCIA' .OR. v_compu='PCINFORMATICA' .OR. v_compu='DAVID') .AND. (v_usu='LNOGUERA' .OR. v_usu='DIEGO' .OR. v_usu='ACANO')
     *  usudpto = usu_dpto
    *ENDIF
     conectar()
       = SQLEXEC(gncone, 'select * from menudpto WHERE usu_dpto=?vc_dpto', 'usumenu')
     desconectar()

    SET SYSMENU TO
    SET SYSMENU AUTOMATIC
    conectar()
      SQLEXEC(gncone, 'SELECT * FROM MENUOP', 'MENUOP')
    desconectar()
    SELECT c.* FROM menuop c, usumenu d WHERE c.menupad=d.menupad AND c.menupop=d.menupop ORDER BY c.menupad, c.menupop INTO TABLE menu
    GOTO TOP
    SCAN WHILE  .NOT. EOF()
       SCATTER MEMVAR
       IF EMPTY(m.menupop)
          menuca = nommenu
          menuoami = "menuoami"+ALLTRIM(STR(m.menupad))
          DEFINE PAD &menuoami OF _MSYSMENU PROMPT ALLTRIM(DESCRI) COLOR SCHEME 3
          IF  .NOT. EMPTY(m.orden)
             ON SELECTION PAD &menuoami OF _MSYSMENU &orden
          ELSE
             ON PAD &menuoami OF _MSYSMENU ACTIVATE POPUP &menuca
          ENDIF
       ENDIF
       SELECT menu
    ENDSCAN
    SELECT * FROM menu WHERE menuhijo>0 INTO CURSOR m1
    SELECT m1
    GOTO TOP
    SET STEP ON
    SCAN WHILE  .NOT. EOF()
       SCATTER MEMVAR
       menuhi = m.menuhijo
       nomme = nommenu
       des = ALLTRIM(m.descri)
       DEFINE POPUP &nomme MARGIN RELATIVE SHADOW TITLE des COLOR SCHEME 4
       m = 1
       SELECT * FROM menu WHERE menupad=m.menuhi INTO CURSOR m2
       SELECT m2
       GOTO TOP
       SCAN WHILE  .NOT. EOF()
          SCATTER MEMVAR
          descri = ALLTRIM(m.descri)
          mpopu = m.nommenu
          IF m.menuhijo>0
             DEFINE BAR m OF &nomme PROMPT DESCRI
             ON BAR m OF &nomme ACTIVATE POPUP &mpopu
             m = m+1
          ELSE
             DEFINE BAR m OF &nomme PROMPT DESCRI
             IF  .NOT. EMPTY(m.orden)
                ON SELECTION BAR m OF &nomme &orden
             ENDIF
             m = m+1
          ENDIF
          SELECT m2
       ENDSCAN
       SELECT m1
    ENDSCAN
    CLOSE TABLE ALL
    DELETE FILE menu.dbf
*!*	    vce=0
*!*	     conectar()
*!*	        =SQLEXEC(gncone,'select a.ART_COD,a.ART_NOMBRE,a.ART_STOCKMIN,s.STO_CANTIDAD;
*!*				    '+' from articulos a inner join STOCK s on a.ART_COD=s.ART_COD ;
*!*	                '+' where ART_STOCKMIN>?vce and s.STO_CANTIDAD<=a.ART_STOCKMIN','cu_stockminimo')
*!*						IF RECCOUNT('cu_stockminimo')>0
*!*	 						REPORT FORM inf_stockminimo PREVIEW 
*!*						ENDIF 
*!*	    desconectar()					
*!*	    
 ENDIF
ENDPROC
**
