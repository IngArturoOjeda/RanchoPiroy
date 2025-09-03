IF Not "CIPHER50.FLL" $ Set ( "Library" )   && Verifica que la librería no este en memoria
    Set Library To CIPHER50.FLL Additive
ENDIF

conectar()
=SQLEXEC(gncone,'select * from usuario','vs_usuario')

SELECT usuario,nombre,clave,SPACE(21)as clav FROM vs_usuario INTO CURSOR vsusuario readwrite

SELECT vsusuario
GO top
SCAN
	a=vsusuario.clave
	
	Vc_contra=Decrypt(ALLTRIM(a),'SPSPSP') 
	   
	   replace clav WITH Vc_contra
	
	  SELECT vsusuario
ENDSCAN


Vc_contra=Decrypt(ALLTRIM(thisform.t_Acceso.value),'SPSPSP') 