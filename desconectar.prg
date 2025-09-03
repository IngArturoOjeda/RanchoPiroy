 host = SUBSTR(SYS(0), 1, AT('#', SYS(0))-2)
 SQLEXEC(gncone, 'exec p_desconecta_usu ?host')
 SQLDISCONNECT(gncone)
ENDPROC
**
