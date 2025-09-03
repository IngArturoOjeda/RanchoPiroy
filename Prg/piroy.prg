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
_Screen.Height=480 
_Screen.Width=440
_Screen.AutoCenter= .T.
_screen.Closable= .F. 
_screen.Visible= .T.
SET LIBRARY TO CIPHER50.FLL ADDITIVE
_screen.Caption="VETERINARIA"
_screen.Icon="C:\Sistemapiroy\imagenes\rancho.ico"

*coneccion='Driver={SQL Server};Server=.\;trusted_connection=No;uid=sa;pwd=manager123*;Database=piroy'	
 coneccion='Driver={SQL Server};Server=192.168.40.153;trusted_connection=No;uid=sa;pwd=manager123*;Database=piroy'	

DO FORM accesodominio
conectar()
IF v_bien = 0
	magente=999
	v_bien = 0	
	
	IF USED('vs_usuario')
		SELECT vs_usuario
		use
	ENDIF	
	SET STEP ON
	=SQLEXEC(gncone,'select * from usuario where usuario=?v_usu','vs_usuario')
	
	nomb=ALLTRIM(vs_usuario.nombre)
    v_nom ='RanchoPiroy'
    
	_screen.Caption="Veterinaria - "+v_nom+ '   ' + 'Usuario:   '+ nomb
	
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
   *_SCREEN.Picture = "C:\sistemaranchopiroy\imagenes\starfieldfx.jpg"
  * _SCREEN.Picture = "C:\sistemaranchopiroy\imagenes\starfieldfx.jpg"
   SQLEXEC(gncone,'select emp_logo from empresa','cur_milogo') 
   varmilogo=cur_milogo.emp_logo   
 * _SCREEN.Picture = varmilogo
  _screen.AddObject("olmg","image")
   _screen.olmg.picture = varmilogo
   _screen.olmg.visible = .T.
   _screen.olmg.stretch = 0
   _screen.olmg.left = 90
   _screen.olmg.width = 1300
   _screen.olmg.top = 120
   
  IF USED('cur_milogo')
       SELECT cur_milogo
       USE 
    ENDIF
  
   _SCREEN.Visible= .T.
		*C:\Proyectos Fox\RanchoPiroy\graficos
	DO MN_MENU
	Read Events
	ON SHUTDOWN 
	SET SYSMENU TO DEFAULT
	MODIFY WINDOW SCREEN
ELSE
	
ENDIF
desconectar()





*********
