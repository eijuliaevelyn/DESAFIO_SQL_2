-- Criação da tabela Tipo Premiação.
CREATE TABLE TipoPremiacao(
	Id TINYINT PRIMARY KEY IDENTITY,
	TipoPremiacao VARCHAR (45) NOT NULL
); 

-- Criação da tabela Parâmetro Ranking.
CREATE TABLE ParametroRanking(
	Id TINYINT PRIMARY KEY IDENTITY,
	NomePosicao VARCHAR (45) NOT NULL,
	Valor REAL NOT NULL
);

-- Criação da tabela Premiação Mensal.
CREATE TABLE PremiacaoMensal(
	Id SMALLINT PRIMARY KEY IDENTITY,
	IdTipoPremiacao TINYINT NOT NULL,
	IdParametroRanking TINYINT NOT NULL,
	IdEmpresa SMALLINT NOT NULL,
	ValorPremiacaoAtual REAL NOT NULL,
	DataPremiacao DATE NOT NULL,
	FOREIGN KEY (IdTipoPremiacao) REFERENCES TipoPremiacao (Id),
	FOREIGN KEY (IdParametroRanking) REFERENCES ParametroRanking (Id),
	FOREIGN KEY (IdEmpresa) REFERENCES Empresa (Id)
); 