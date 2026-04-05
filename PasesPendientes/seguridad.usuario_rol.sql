USE [ferreteria]
GO

/****** Object:  Table [seguridad].[usuario_rol]    Script Date: 04-Apr-26 4:40:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [seguridad].[usuario_rol](
	[id_usuario] [int] NOT NULL,
	[id_rol] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_usuario] ASC,
	[id_rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [seguridad].[usuario_rol]  WITH CHECK ADD FOREIGN KEY([id_rol])
REFERENCES [seguridad].[roles] ([id_rol])
GO

ALTER TABLE [seguridad].[usuario_rol]  WITH CHECK ADD FOREIGN KEY([id_usuario])
REFERENCES [dbo].[usuario] ([cod_usu])
GO


