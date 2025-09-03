
@echo off
setlocal

:: CONFIGURACIÓN
set SERVIDOR=192.168.40.153
set USUARIO=AgroVeterinaria
set CONTRASENA=rancho123
set IMPRESORA=MTP3
set NOMBRE_LOCAL=MTP3

echo ================================
echo VERIFICANDO CONEXIÓN DE RED...
echo ================================

ping -n 2 %SERVIDOR% >nul
if errorlevel 1 (
    echo ❌ No se pudo conectar con el servidor %SERVIDOR%.
    echo Verificá que esté encendido y en la red.
    pause
    exit /b
)

echo ✅ Servidor accesible.

echo.
echo ================================
echo AUTENTICANDO EN RECURSO COMPARTIDO...
echo ================================

net use \\%SERVIDOR%\IPC$ /user:%USUARIO% %CONTRASENA% >nul 2>&1
if errorlevel 1 (
    echo ❌ Error al autenticarse. Verificá usuario y contraseña.
    pause
    exit /b
)

echo ✅ Autenticado correctamente.

echo.
echo ================================
echo CONECTANDO IMPRESORA COMPARTIDA...
echo ================================

rundll32 printui.dll,PrintUIEntry /in /n \\%SERVIDOR%\%IMPRESORA% /q

timeout /t 1 >nul

wmic printer where "Name='%NOMBRE_LOCAL%'" get Name | findstr /i "%NOMBRE_LOCAL%" >nul
if errorlevel 1 (
    echo ❌ No se pudo agregar la impresora %NOMBRE_LOCAL%.
    echo Verificá que esté bien compartida y visible en red.
    pause
    exit /b
)

echo ✅ Impresora %NOMBRE_LOCAL% conectada correctamente.

echo.
echo ================================
echo IMPRIMIENDO PRUEBA...
echo ================================

rundll32 printui.dll,PrintUIEntry /k /n "%NOMBRE_LOCAL%"

echo ✅ Proceso finalizado.
pause
