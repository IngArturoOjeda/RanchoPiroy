USE [ferreteria]
GO

/****** Object:  StoredProcedure [seguridad].[sp_permisos_usuario]    Script Date: 04-Apr-26 6:19:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [seguridad].[sp_permisos_usuario]
    @id_usuario INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DISTINCT RTRIM(p.nombre_permiso) AS nombre_permiso
    FROM seguridad.usuario_rol ur
    INNER JOIN seguridad.rol_permiso rp ON ur.id_rol = rp.id_rol
    INNER JOIN seguridad.permisos p ON rp.id_permiso = p.id_permiso
    WHERE ur.id_usuario = @id_usuario
END


GO


