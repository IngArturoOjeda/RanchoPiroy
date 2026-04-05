USE [piroy]
GO

/****** Object:  StoredProcedure [seguridad].[sp_roles_permisos_listar]    Script Date: 04-Apr-26 6:20:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [seguridad].[sp_roles_permisos_listar]
    @id_rol INT
AS
BEGIN

    SELECT  
        p.id_permiso,
        p.nombre_permiso,
        p.descripcion,
        CASE 
            WHEN rp.id_permiso IS NULL THEN 0
            ELSE 1
        END AS acceso
    FROM seguridad.permisos p
    LEFT JOIN seguridad.rol_permiso rp 
           ON p.id_permiso = rp.id_permiso
          AND rp.id_rol = @id_rol
    ORDER BY p.nombre_permiso

END
GO


