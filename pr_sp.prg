PUBLIC v_tol, v_bien, v_nom, v_dir, v_ruc, v_tel, v_npat, v_act, v_raz, v_ciu, v_c, v_al,gncone,coneccion,magente,conesenal

public a as character

a = sys(5)+sys(2003)
set default to ('&a')
set deleted on
set status bar off

set talk off
set date to SHORT
set hours to 24
set sysmenu to
SET SYSFORMATS ON
set sysmenu off

_screen.MinButton= .T.
_Screen.MaxButton= .T.
_Screen.TitleBar= 1
_Screen.BorderStyle= 0
_Screen.WindowState= 0
_Screen.Height=250
_Screen.Width=440
_Screen.AutoCenter= .T.
_screen.Closable= .F. 
_screen.Visible= .T.
SET LIBRARY TO CIPHER50.FLL ADDITIVE
_screen.Caption="Sistema de Gesti�n de Medicina Pre-Paga"

coneccion='Driver={SQL Server};Server=192.168.30.33;trusted_connection=No;uid=sa;pwd=manager123*;Database=fleming'	


DO FORM FRM_ACCESO
conectar()
IF v_bien = 1
	magente=999
	v_bien = 0	
	
	IF USED('vs_usuario')
		SELECT vs_usuario
		use
	ENDIF	
	
	=SQLEXEC(gncone,'select * from usuario where usuario=?v_usu','vs_usuario')
	
	nomb=ALLTRIM(vs_usuario.nombre)
    v_nom ='FLEMING S.A.'
    
	_screen.Caption="Sistema de Gesti�n de Medicina Pre-Paga - "+v_nom+ '   ' + 'Usuario:   '+ nomb
	
   	SET CENTURY on
	SET DELETED ON 
	SET TALK OFF 
	SET DATE BRITISH 
	SET SEPARATOR TO '.'
	SET POINT TO ',' 
	_screen.WindowState= 2
	SET DELETED OFF
	SET DATE BRITISH 
	SET EXCLUSIVE OFF
	SET DELETED ON
	_SCREEN.AddObject("oImg","Image")
   _SCREEN.Picture = "S:\fondodepantalla.jpg"
   _SCREEN.Visible= .T.
		
	DO MN_MENU
	Read Events
	ON SHUTDOWN 
	SET SYSMENU TO DEFAULT
	MODIFY WINDOW SCREEN
ELSE
	
ENDIF
desconectar()





*********
