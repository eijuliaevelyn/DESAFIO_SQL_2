USE smningatreinamentogrupo2
GO

-- Criação da tabela Cnae.
CREATE TABLE Cnae (
	Id SMALLINT PRIMARY KEY IDENTITY,
	CodigoCnae INT NOT NULL,
	DescricaoCnae VARCHAR (70)
	);

-- Criação da tabela CnaeEmpresa.
CREATE TABLE CnaeEmpresa (
	IdEmpresa SMALLINT NOT NULL,
	IdCnae SMALLINT NOT NULL,
	Principal BIT NOT NULL,
	PRIMARY KEY (IdEmpresa,IdCnae),
	FOREIGN KEY (IdEmpresa) REFERENCES Empresa (Id),
	FOREIGN KEY (IdCnae) REFERENCES Cnae (Id)
	);
