 SQLEXEC(v_cone, 'SELECT A.CODIGO,A.CAR_COD,B.EMPL_COD as falta,a.empl_cod FROM EMPLEADO A LEFT OUTER JOIN CARGO_EMPLEADO B ON A.EMPL_COD=b.EMPL_COD'+' ', 'TRAE2')
 SELECT * FROM trae2 WHERE ISNULL(falta) INTO CURSOR trae3
 GOTO TOP
 SCAN WHILE  .NOT. EOF()
    v = DATE(2008, 01, 01)
    c = codigo
    k = car_cod
    e = empl_cod
    ah = DATETIME()
    SQLEXEC(v_cone, 'insert into cargo_empleado (empl_cod,vigencia,car_cod,usuins,fecins)	'+' values (?e,?v,?k,?usu,?ah)')
    SELECT trae3
 ENDSCAN
 SQLEXEC(v_cone, 'select * from regivaca where monto=monto_ips', 'vaca')
 SCAN WHILE  .NOT. EOF()
    v = ROUND(monto*1.098901 , 0)
    n = nroid
    SQLEXEC(v_cone, 'update regivaca set monto=?v where nroid=?n')
    SELECT vaca
 ENDSCAN
ENDPROC
**
