USE [piroy]
GO

/****** Object:  Table [seguridad].[auditoria]    Script Date: 04-Apr-26 4:33:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [seguridad].[auditoria](
	[id_auditoria] [int] IDENTITY(1,1) NOT NULL,
	[tabla] [varchar](100) NOT NULL,
	[id_registro] [varchar](100) NULL,
	[accion] [varchar](20) NOT NULL,
	[datos_anteriores] [nvarchar](max) NULL,
	[datos_nuevos] [nvarchar](max) NULL,
	[id_usuario] [int] NULL,
	[usuario] [varchar](50) NULL,
	[maquina] [varchar](50) NULL,
	[ip] [varchar](50) NULL,
	[fecha] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_auditoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [seguridad].[auditoria] ADD  DEFAULT (getdate()) FOR [fecha]
GO


