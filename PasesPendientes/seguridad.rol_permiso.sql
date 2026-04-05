USE [ferreteria]
GO

/****** Object:  Table [seguridad].[rol_permiso]    Script Date: 04-Apr-26 4:39:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [seguridad].[rol_permiso](
	[id_rol] [int] NOT NULL,
	[id_permiso] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_rol] ASC,
	[id_permiso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [seguridad].[rol_permiso]  WITH CHECK ADD FOREIGN KEY([id_permiso])
REFERENCES [seguridad].[permisos] ([id_permiso])
GO

ALTER TABLE [seguridad].[rol_permiso]  WITH CHECK ADD FOREIGN KEY([id_rol])
REFERENCES [seguridad].[roles] ([id_rol])
GO


