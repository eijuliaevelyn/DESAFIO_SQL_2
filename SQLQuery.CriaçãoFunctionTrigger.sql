-- Cria��o de Function Para calcular o valor 
CREATE FUNCTION [dbo].[FNCSomaPremiacao](
		@IdEmpresa SMALLINT,
		@IdParametroRanking TINYINT
		)
		
		RETURNS MONEY 

		AS
		/* 
		DOCUMENTA��O
		ARQUIVO FONTE....: FNCCalculaValorTotal.sql
		OBJETIVO.........: CALCULAR VALOR PREMIA��O ATUAL.
		AUTOR............: SMN - J�LIA EVELYN
		DATA.............: 04/01/2024
		EX...............:  select [dbo].[FNCSomaPremiacao](1, 2)
		*/
		BEGIN
			-- Declarando Vari�veis.
			DECLARE @ValorRanking MONEY,
			        @ValorPremiacaoAtual MONEY,
					@ValorTotal MONEY 
			
			-- Setando Valor para vari�vel valor premia��o atual.
			SET @ValorPremiacaoAtual = (SELECT TOP 1 ValorPremiacaoAtual FROM PremiacaoMensal WHERE IdEmpresa = @IdEmpresa AND
			    Mes <= (SELECT MAX (Mes) FROM PremiacaoMensal WHERE IdEmpresa = @IdEmpresa) AND 
				Ano = (SELECT  MAX (Ano) FROM PremiacaoMensal WHERE IdEmpresa = @IdEmpresa) AND 
				ValorPremiacaoAtual IS NOT NULL ORDER BY Id DESC)
			
			-- Setando Valor para vari�vel valor premia��o ranking.
			SET @ValorRanking = (SELECT Valor FROM ParametroRanking WHERE Id = @IdParametroRanking)

			-- Realizando c�lculo.
			IF @ValorPremiacaoAtual IS NULL 
				BEGIN
					SET @ValorTotal = @ValorRanking 	
				END
			ELSE
				BEGIN
					SET @ValorTotal = (@ValorRanking + @ValorPremiacaoAtual)  
				END
			
			RETURN @ValorTotal 
		END
GO

-- Cria��o da trigger que preenche o campo Valor Premia��o Atual.
CREATE OR ALTER TRIGGER [dbo].[TRG.PreencherValorPremiacaoAtual]
	ON [dbo].[PremiacaoMensal]
	AFTER INSERT, UPDATE

	AS 
	/*
	Documenta��o
	Arquivo fonte.....: TRG.PreencherValorPremiacaoAtual.sql
	Objetivo..........: PREENCHER O CAMPO VALOR PREMIA��O ATUAL.
	Autor.............: SMN - J�LIA EVELYN
	Data..............: 05/01/24
	Ex................: EXEC [dbo].[TRG.PreencherValorPremiacaoAtual]
	*/
	BEGIN 
		-- Declarando Vari�veis 
		DECLARE @IdPremiacaoMensalI SMALLINT,
		        @IdPremiacaoMensalD SMALLINT,
				@IdEmpresaI SMALLINT,
				@IdRanking TINYINT, 
				@ValorAtual MONEY

		-- Recuperando Inserted
		SELECT @IdPremiacaoMensalI = Id,
		       @IdEmpresaI = IdEmpresa,
			   @IdRanking = IdParametroRanking
			FROM inserted

		-- Recuperando Deleted 
		SELECT @IdPremiacaoMensalD = Id
			FROM deleted

		-- Setando valor para vari�vel ValorTotal
		 SET @ValorAtual = [dbo].[FNCSomaPremiacao](@IdEmpresaI, @IdRanking)

		-- Atualizando com deleted 
		IF @IdPremiacaoMensalI IS NOT NULL 
			BEGIN 
				UPDATE PremiacaoMensal
					SET ValorPremiacaoAtual = @ValorAtual 
					WHERE Id = @IdPremiacaoMensalI 
			END

		-- Atualizando com deleted e inserted
		IF @IdPremiacaoMensalI IS NOT NULL AND @IdPremiacaoMensalD IS NOT NULL
			BEGIN
				UPDATE PremiacaoMensal
					SET ValorPremiacaoAtual = ValorPremiacaoAtual
					WHERE Id = @IdPremiacaoMensalI
			END
	END