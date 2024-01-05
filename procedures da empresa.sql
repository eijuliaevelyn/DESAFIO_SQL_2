-- Criação da procedure insert tabela empresa
CREATE OR ALTER PROC [dbo].[SP_InsEmpresa](
		@NomeFantasia VARCHAR (80),
		@RazaoSocial VARCHAR (80),
		@CNPJ BIGINT,
		@InscricaoEstadual varchar (9) = NULL,
		@InscricaoMunicipal BIGINT,
		@Email VARCHAR (150),
		@DDD SMALLINT,
		@Telefone INT
)
	AS
	/*
    Documentação
	Arquivo Fonte.....: SQLQUERY.CriaçãoProcedureEmpresa.sql
	Objetivo..........: Insert na tabela empresa
	Autor.............: SMN - Henrique Oliveira Nascimento Dos Santos
	Data..............: 04/01/2024
	Ex................: DECLARE @RESULT TINYINT
						EXEC @RESULT = [dbo].[SP_InsEmpresa]@NomeFantasia = '',@razaoSocial = '',@CNPJ = 12312,@InscricaoEstadual = '',@InscricaoMunicipal = ,@Email = '', @DDD = ,@Telefone =
						SELECT @RESULT AS RESULATDO
	Retornos..........: 1 - Processamento OK.
						2 - Erro.
	*/
	BEGIN

		-- Inserção de registro na tabela Empresa
		INSERT INTO Empresa (NomeFantasia,RazaoSocial,CNPJ,InscricaoEstadual,InscricaoMunicipal,Email,DDD,TelefoneFixo)
			VALUES (@NomeFantasia,@RazaoSocial,@CNPJ,@InscricaoEstadual,@InscricaoMunicipal,@Email,@DDD,@Telefone)
		RETURN 1

		IF @@ERROR <> 0 RETURN 2

	END
GO

-- Criação da procedure update tabela empresa
CREATE OR ALTER PROC [dbo].[SP_UpdEmpresa](
		@Id SMALLINT,
		@NomeFantasia VARCHAR (80),
		@RazaoSocial VARCHAR (80),
		@CNPJ BIGINT,
		@InscricaoEstadual VARCHAR (9) = NULL,
		@InscricaoMunicipal BIGINT,
		@Email VARCHAR (150),
		@DDD TINYINT,
		@Telefone INT
)
AS
/*
    	Documentação
		Arquivo Fonte.....: SQLQUERY.CriaçãoProcedureEmpresa.sql
		Objetivo..........: Insert na tabela empresa
		Autor.............: SMN - Henrique Oliveira Nascimento Dos Santos
		Data..............: 04/01/2024
		Ex................: DECLARE @RESULT TINYINT
							EXEC @RESULT = [dbo].[SP_UpdEmpresa]@Id = , @NomeFantasia = '',@razaoSocial = '',@CNPJ =  ,@InscricaoEstadual = 'NULL' ,@InscricaoMunicipal = ,@Email = '',@DDD =  ,@Telefone = 
							SELECT @RESULT AS RESULATDO
		Returns...........:	1 -> Id empresa não existir
							2 -> Atualizado
							3 -> Erro
*/
	BEGIN

		IF NOT EXISTS (SELECT TOP 1 Id
							FROM Empresa
								WHERE Id = @Id) RETURN 1
		UPDATE Empresa
		SET 
			NomeFantasia = @NomeFantasia,
			RazaoSocial = @RazaoSocial,
			CNPJ = @CNPJ,
			InscricaoEstadual = @InscricaoEstadual,
			InscricaoMunicipal = @InscricaoMunicipal,
			Email = @Email,
			DDD = @DDD,
			TelefoneFixo = @Telefone
		WHERE Id = @Id
		RETURN 2

		IF @@ERROR <> 0 RETURN 3

	END
GO

-- Criação da procedure select tabela empresa mas detalhado
CREATE OR ALTER PROC [dbo].[SP_SelEmpresa2](
		@Id SMALLINT = NULL,
		@IdTelefoneFixo SMALLINT = NULL,
		@NomeFantasia VARCHAR (80),
		@RazaoSocial VARCHAR (80) = NULL,
		@CNPJ BIGINT = NULL,
		@InscricaoEstadual VARCHAR (9) = NULL,
		@InscricaoMunicipal BIGINT = NULL,
		@Email VARCHAR (150) = NULL,
		@DDD TINYINT = NULL,
		@Telefone INT = NULL,
		@CodigoCnae INT = NULL,
		@DescricaoCnae VARCHAR (70) = NULL
)
	AS
	/*
    Documentação
	Arquivo Fonte.....: SQLQUERY.CriaçãoProcedureEmpresa.sql
	Objetivo..........: Select na tabela empresa
	Autor.............: SMN - Henrique Oliveira Nascimento Dos Santos
	Data..............: 04/01/2024
	Ex................:	DECLARE @RESULT TINYINT
						EXEC @RESULT = [dbo].[SP_SelEmpresa2] @Id =null,@NomeFantasia = NULL,@RazaoSocial = NULL,@CNPJ = NULL ,@InscricaoEstadual = NULL ,@InscricaoMunicipal = NULL ,@email = NULL, @DDD =NULL , @Telefone = NULL,@CodigoCnae = null ,@DescricaoCnae = null
						SELECT @RESULT AS RESULATDO
	Returns...........:	1 -> Selecionado
						2 -> Erro
	*/
	BEGIN
		-- SELECT PARA TABELA EMPRESA
		SELECT TOP 10 e.Id AS IdEmpresa,NomeFantasia,RazaoSocial,CNPJ,CASE WHEN InscricaoEstadual IS NULL THEN '-' ELSE InscricaoEstadual END AS InscricaoEstadual,
                InscricaoMunicipal,Email,CONCAT('(',DDD,')',' ',TelefoneFixo) AS Telefone,CONCAT(c.CodigoCnae, ' - ' ,c.DescricaoCnae) AS Cnae
			FROM Empresa e
			INNER JOIN CnaeEmpresa ce
			ON e.Id = ce.IdEmpresa
			INNER JOIN Cnae c
			ON ce.IdCnae = c.Id
				WHERE (@Id IS NULL OR IdEmpresa = @Id) AND
					  (@NomeFantasia IS NULL OR NomeFantasia = @NomeFantasia) AND
					  (@RazaoSocial IS NULL OR RazaoSocial = @RazaoSocial ) AND
					  (@CNPJ IS NULL OR CNPJ = @CNPJ) AND
					  (@InscricaoEstadual IS NULL OR InscricaoEstadual = @InscricaoEstadual) AND
					  (@InscricaoMunicipal IS NULL OR InscricaoMunicipal = @InscricaoMunicipal) AND
					  (@Email IS NULL OR Email = @Email) AND
					  (@DDD IS NULL OR DDD = @DDD) AND
					  (@Telefone IS NULL OR TelefoneFixo = @Telefone) AND
					  (@CodigoCnae IS NULL OR c.CodigoCnae = @CodigoCnae) AND
					  (@DescricaoCnae IS NULL OR c.DescricaoCnae = @DescricaoCnae)AND
					  (ce.Principal = 1)

					
		
		IF @@ERROR <> 0 RETURN 2 
	END;
GO



-- Criação da procedure delete tabela empresa
CREATE OR ALTER PROC [dbo].[SP_DelEmpresa](
		@Id SMALLINT
)
	AS
	/*
    Documentação
	Arquivo Fonte.....: SQLQUERY.CriaçãoProcedureEmpresa.sql
	Objetivo..........: Delete na tabela empresa
	Autor.............: SMN - Henrique Oliveira Nascimento Dos Santos
	Data..............: 04/01/2024
	Ex................: DECLARE @RESULT TINYINT
						EXEC @RESULT = [dbo].[SP_DelEmpresa]
						SELECT @RESULT AS RESULATDO
	Returns...........: 1 -> Id empresa não existir
						2 -> Deletado
						3 -> Erro
	*/
	BEGIN
		-- Validando o Id empresa
		IF NOT EXISTS (SELECT TOP 1 Id
							FROM Empresa
								WHERE Id = @Id) RETURN 1

		DELETE Empresa
			WHERE Id = @Id RETURN 2

		IF @@ERROR <> 0 RETURN 3
	END
GO
