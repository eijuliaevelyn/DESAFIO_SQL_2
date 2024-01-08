USE smningatreinamentogrupo2
GO


-- Cria��o da procedure de insert na tabela Tipo Premia��o. 
CREATE OR ALTER PROC SP_InsTipoPremiacao(
		@TipoPremiacao VARCHAR (45)
		)

	AS
	/*
	Documenta��o
	Arquivo fonte.....: SP_InsTipoPremiacao.sql
	Objetivo..........: INSERIR NA TABELA TIPO PREMIA��O.
	Autor.............: SMN - J�LIA EVELYN
	Data..............: 04/01/2024
	Ex................: DECLARE @RETURN TINYINT 
                        EXEC @RETURN = [dbo].[SP_InsTipoPremiacao] 'Organiza��o'
                        SELECT @RETURN AS RESULTADO
	Retornos..........: 0 - Processamento OK.
						1 - Erro.
	*/ 
	BEGIN			
		-- Inser��o de registros na tabela Tipo Premia��o.
		INSERT INTO TipoPremiacao (TipoPremiacao) 
			VALUES (@TipoPremiacao)
		RETURN 0 
		IF @@ERROR <>0 RETURN 3
	END
GO

-- Cria��o da procedure de update na tabela Tipo Premia��o.
CREATE OR ALTER PROC SP_UpTipoPremiacao(
		@IdTipoPremiacao TINYINT, 
		@TipoPremiacao VARCHAR (45)
		) 	

	AS
	/*
	Documenta��o
	Arquivo fonte.....: SP_UpTipoPremiacao.sql
	Objetivo..........: ATUALIZAR A TABELA TIPO PREMIA��O.
	Autor.............: SMN - J�LIA EVELYN
	Data..............: 04/01/2024
	Ex................: DECLARE @RETURN TINYINT 
                        EXEC @RETURN = [dbo].[SP_UpTipoPremiacao] 1, 'Empresa do Ano'
                        SELECT @RETURN AS RESULTADO
	Retornos..........: 0 - Processamento OK.
						1 - ID Tipo Premia��o inexistente.
						2 - Erro.
	*/ 
	BEGIN
		-- Validando se o Id existe.
		IF NOT EXISTS (SELECT TOP 1 Id 
							FROM TipoPremiacao
								WHERE Id = @IdTipoPremiacao) RETURN 1	
		
		-- Atualizando a tabela Tipo Premia��o.
		UPDATE TipoPremiacao
			SET TipoPremiacao = @TipoPremiacao
			WHERE Id = @IdTipoPremiacao
		RETURN 0
		IF @@ERROR <>0 RETURN 2
	END
GO

-- Cria��o da procedure de delete na tabela Tipo Premia��o.
CREATE OR ALTER PROC SP_DelTipoPremiacao(
		@IdTipoPremiacao TINYINT
		)

	AS
	/*
	Documenta��o
	Arquivo fonte.....: SP_DelTipoPremiacao.sql
	Objetivo..........: DELETAR REGISTRO NA TABELA TIPO PREMIA��O.
	Autor.............: SMN - J�LIA EVELYN
	Data..............: 04/01/2024
	Ex................: DECLARE @RETURN TINYINT 
                        EXEC @RETURN = [dbo].[SP_DelTipoPremiacao] 2
                        SELECT @RETURN AS RESULTADO
	Retornos..........: 0 - Processamento OK.
						1 - ID Tipo Premia��o inexistente.
						2 - Erro.
	*/
	BEGIN
		-- Validando se o Id existe.
		IF NOT EXISTS (SELECT TOP 1 Id 
							FROM TipoPremiacao
								WHERE Id = @IdTipoPremiacao) RETURN 1	

		-- Deletando registro na Tipo Premia��o.
		DELETE TipoPremiacao 
			WHERE Id = @IdTipoPremiacao
		RETURN 0
		IF @@ERROR <>0 RETURN 2
	END
GO

-- Cria��o da procedure de select na tabela Tipo Premia��o.
CREATE OR ALTER PROC SP_SelTipoPremiacao(
		@IdTipoPremiacao TINYINT = NULL, 
		@TipoPremiacao VARCHAR (45)
		) 	
		
	AS
	/*
	Documenta��o
	Arquivo fonte.....: SP_SelTipoPremiacao.sql
	Objetivo..........: SELECIONAR A TABELA CLIENTE.
	Autor.............: SMN - J�LIA EVELYN
	Data..............: 04/01/2024
	Ex................: EXEC [dbo].[SP_SelTipoPremiacao] @TipoPremiacao = 'Organiza��o'          
	Retornos..........: 0 - Erro.
	*/
	BEGIN 
		-- Selecionando a tabela Tipo Premia��o..
			SELECT Id,
				   TipoPremiacao
				FROM TipoPremiacao		
					WHERE (@IdTipoPremiacao IS NULL OR Id = @IdTipoPremiacao) AND 
						  (@TipoPremiacao IS NULL OR TipoPremiacao = @TipoPremiacao)
		IF @@ERROR <> 0 RETURN 0
	END 
GO

--	Cria��o da procedure de insert na tabela Premia��o Mensal.
CREATE OR ALTER PROC SP_InsPremiacaoMensal(
		@IdTipoPremiacao TINYINT,
		@IdParametroRanking TINYINT,
		@IdEmpresa SMALLINT, 
		@Mes TINYINT,
		@Ano SMALLINT
		)

	AS
	/*
	Documenta��o
	Arquivo fonte.....: SP_InsPremiacaoMensal.sql
	Objetivo..........: INSERIR NA TABELA PREMIA��O MENSAL.
	Autor.............: SMN - J�LIA EVELYN
	Data..............: 04/01/2024
	Ex................: DECLARE @RETURN TINYINT 
                        EXEC @RETURN = [dbo].[SP_InsPremiacaoMensal] 1, 2, 2, 09, 2023
                        SELECT @RETURN AS RESULTADO
	Retornos..........: 0 - Processamento OK.
						1 - Id Tipo Premia��o inexistente.
						2 - Id Par�metro Ranking inexistente.
						3 - Id Empresa inexistente.
						4 - Erro.
	*/ 
	BEGIN		
		-- Validando se o Id Tipo Premia��o existe.
		IF NOT EXISTS (SELECT TOP 1 Id 
							FROM TipoPremiacao
								WHERE Id = @IdTipoPremiacao) RETURN 1

		-- Validando se o Id Par�metro Ranking existe.
		IF NOT EXISTS (SELECT TOP 1 Id 
							FROM ParametroRanking
								WHERE Id = @IdParametroRanking) RETURN 2

		-- Validando se o Id Empresa existe.
		IF NOT EXISTS (SELECT TOP 1 Id 
							FROM Empresa
								WHERE Id = @IdEmpresa) RETURN 3
		
		-- Inser��o de registros na tabela Premia��o Mensal.
		INSERT INTO PremiacaoMensal (IdTipoPremiacao, IdParametroRanking, IdEmpresa, Mes, Ano) 
			VALUES (@IdTipoPremiacao, @IdParametroRanking, @IdEmpresa, @Mes, @Ano)
		RETURN 0 
		IF @@ERROR <>0 RETURN 4
	END
GO


CREATE OR ALTER PROC SP_UpPremiacaoMensal(
		@Id SMALLINT,
		@IdTipoPremiacao TINYINT, 
		@IdParametroRanking TINYINT,
		@IdEmpresa SMALLINT, 
		@ValorPremiacaoAtual MONEY, 
		@Mes TINYINT,
		@Ano SMALLINT
		) 	

	AS
	/*
	Documenta��o
	Arquivo fonte.....: SP_UpPremiacaoMensal.sql
	Objetivo..........: ATUALIZAR A TABELA PREMIA��O MENSAL.
	Autor.............: SMN - J�LIA EVELYN
	Data..............: 04/01/2024
	Ex................: DECLARE @RETURN TINYINT 
                        EXEC @RETURN = [dbo].[SP_UpPremiacaoMensal] 1, 1, 1, 1, 2500, 11, 2023
                        SELECT @RETURN AS RESULTADO
	Retornos..........: 0 - Processamento OK.
						1 - Id Premia��o inexistente.
						2 - Id Tipo Premia��o inexistente.
						3 - Id Par�metro Ranking inexistente.
						4 - Id Empresa inexistente.
						5 - Erro.
	*/ 
	BEGIN
		
		-- Validando se o Id existe.
		IF NOT EXISTS (SELECT TOP 1 Id 
							FROM PremiacaoMensal
								WHERE Id = @Id) RETURN 1
		-- Validando se o Id Tipo Premia��o existe.
		IF NOT EXISTS (SELECT TOP 1 Id 
							FROM TipoPremiacao
								WHERE Id = @IdTipoPremiacao) RETURN 2

		-- Validando se o Id Par�metro Ranking existe.
		IF NOT EXISTS (SELECT TOP 1 Id 
							FROM ParametroRanking
								WHERE Id = @IdParametroRanking) RETURN 3

		-- Validando se o Id Empresa existe.
		IF NOT EXISTS (SELECT TOP 1 Id 
							FROM Empresa
								WHERE Id = @IdEmpresa) RETURN 4
		
		-- Atualizando a tabela Premia��o Mensal
		UPDATE PremiacaoMensal
			SET IdTipoPremiacao = @IdTipoPremiacao, IdParametroRanking = @IdParametroRanking, IdEmpresa = @IdEmpresa, ValorPremiacaoAtual = @ValorPremiacaoAtual,
				Mes = @Mes, Ano = @Ano
			WHERE Id = @Id
		RETURN 0
		IF @@ERROR <>0 RETURN 5
	END
GO

-- Cria��o da procedure de delete na tabela Premia��o Mensal.
CREATE OR ALTER PROC SP_DelPremiacaoMensal(
		@IdPremiacaoMensal SMALLINT
		)

	AS
	/*
	Documenta��o
	Arquivo fonte.....: SP_DelPremiacaoMensal.sql
	Objetivo..........: DELETAR REGISTRO NA TABELA TIPO PREMIA��O.
	Autor.............: SMN - J�LIA EVELYN
	Data..............: 04/01/2024
	Ex................: DECLARE @RETURN TINYINT 
                        EXEC @RETURN = [dbo].[SP_DelPremiacaoMensal] 7
                        SELECT @RETURN AS RESULTADO
	Retornos..........: 0 - Processamento OK.
						1 - Id Premia��o Mensal inexistente.
						2 - Erro.
	*/
	BEGIN
		-- Validando se o Id existe.
		IF NOT EXISTS (SELECT TOP 1 Id 
							FROM PremiacaoMensal
								WHERE Id = @IdPremiacaoMensal) RETURN 1	

		-- Deletando registro na tabela Premia��o Mensal.
		DELETE PremiacaoMensal 
			WHERE Id = @IdPremiacaoMensal
		RETURN 0
		IF @@ERROR <>0 RETURN 2
	END
GO

-- Cria��o da procedure de select na tabela Premia��o Mensal.
CREATE OR ALTER PROC SP_SelPremiacaoMensal(
		@Id SMALLINT = NULL,
		@IdTipoPremiacao TINYINT = NULL, 
		@IdParametroRanking TINYINT = NULL,
		@IdEmpresa SMALLINT = NULL, 
		@ValorPremiacaoAtual MONEY = NULL, 
		@Mes TINYINT = NULL,
		@Ano SMALLINT = NULL
		) 	
		
	AS
	/*
	Documenta��o
	Arquivo fonte.....: SP_SelTipoPremiacao.sql
	Objetivo..........: SELECIONAR A TABELA PREMIA��O MENSAL.
	Autor.............: SMN - J�LIA EVELYN
	Data..............: 04/01/2024
	Ex................: EXEC [dbo].[SP_SelPremiacaoMensal] @IdEmpresa = 2   
	Retornos..........: 0 - Erro.
	*/
	BEGIN 
		-- Selecionando a tabela Premia��o Mensal.
			SELECT R.NomePosicao AS Ranking,
				   E.NomeFantasia AS Empresa,
				   E.Cnpj AS CNPJ,
				   TP.TipoPremiacao AS 'Tipo Premia��o',
				   PM.ValorPremiacaoAtual AS 'Faturamento Mensal',
				   CONCAT(PM.Mes, '/', PM.Ano) AS 'M�s e Ano'
				FROM PremiacaoMensal PM
					INNER JOIN ParametroRanking R
				ON R.Id = PM.IdParametroRanking
					INNER JOIN Empresa E
				ON E.Id = PM.IdEmpresa
					INNER JOIN TipoPremiacao TP
				ON TP.Id = PM.IdTipoPremiacao
					
					WHERE (@Id IS NULL OR PM.Id = @Id) AND 
						  (@IdTipoPremiacao IS NULL OR IdTipoPremiacao = @IdTipoPremiacao) AND
						  (@IdParametroRanking IS NULL OR IdParametroRanking = @IdParametroRanking) AND 
						  (@IdEmpresa IS NULL OR IdEmpresa = @IdEmpresa) AND 
						  (@ValorPremiacaoAtual IS NULL OR ValorPremiacaoAtual = @ValorPremiacaoAtual) AND 
						  (@Mes IS NULL OR Mes = @Mes) AND 
						  (@Ano IS NULL OR Ano = @Ano) 
		IF @@ERROR <> 0 RETURN 0
	END 
GO
