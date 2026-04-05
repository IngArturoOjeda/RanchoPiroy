USE [ferreteria]
GO

/****** Object:  StoredProcedure [seguridad].[sp_roles_permisos_guardar]    Script Date: 04-Apr-26 6:20:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [seguridad].[sp_roles_permisos_guardar]
(
    @id_rol INT,
    @id_permiso INT,
    @acceso BIT,
    @usuario VARCHAR(50),
    @maquina VARCHAR(50),
    @ip VARCHAR(50),
	@tablaname VARCHAR(50)
)
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @accion VARCHAR(20)
    DECLARE @id_registro VARCHAR(50)

    SET @id_registro = CAST(@id_rol AS VARCHAR) + '-' + CAST(@id_permiso AS VARCHAR)

    IF @acceso = 1
    BEGIN

        IF NOT EXISTS (
            SELECT 1 
            FROM seguridad.rol_permiso
            WHERE id_rol = @id_rol
            AND id_permiso = @id_permiso
        )
        BEGIN

            INSERT INTO seguridad.rol_permiso
            (id_rol,id_permiso)
            VALUES
            (@id_rol,@id_permiso)

            SET @accion = 'GRANT'

        END
        ELSE
            RETURN

    END
    ELSE
    BEGIN

        DELETE FROM seguridad.rol_permiso
        WHERE id_rol = @id_rol
        AND id_permiso = @id_permiso

        SET @accion = 'REVOKE'

    END

    INSERT INTO seguridad.auditoria
    (
        tabla,
        id_registro,
        accion,
        usuario,
        maquina,
        ip
    )
    VALUES
    (
        @tablaname,
        @id_registro,
        @accion,
        @usuario,
        @maquina,
        @ip
    )

END
GO


