USE smningatreinamentogrupo2
 
-- Criação da tabela Empresa.
CREATE TABLE Empresa(
		Id SMALLINT PRIMARY KEY IDENTITY,
		NomeFantasia VARCHAR (80) NOT NULL,
		RazaoSocial VARCHAR (80) NOT NULL,
		CNPJ BIGINT NOT NULL,
		InscricaoEstadual VARCHAR (9),
		InscricaoMunicipal BIGINT NOT NULL,
		Email VARCHAR (150) NOT NULL,
		DDD SMALLINT NOT NULL,
		TelefoneFixo INT NOT NULL
);