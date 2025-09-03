
IF Not "CIPHER50.FLL" $ Set ( "Library" )   && Verifica que la librería no este en memoria
    Set Library To CIPHER50.FLL Additive
ENDIF
activos='A'
*conectar()
=SQLEXEC(v_cone,'select * from usuarios where estado=?activos','vs_usuario')

SELECT login,nombre,clave,SPACE(50)as descrip FROM vs_usuario INTO CURSOR vsusuario readwrite

SELECT vsusuario
GO top
*SET STEP ON
SCAN
	varclaves=vsusuario.clave
	
	Vc_contra=Decrypt(ALLTRIM(varclaves),'SPSPSP') 
	   
	   replace descrip WITH Vc_contra
	
	  SELECT vsusuario
ENDSCAN


Vc_contra=Decrypt(ALLTRIM(thisform.t_Acceso.value),'SPSPSP') 