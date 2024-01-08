-- Criação de procedure de insert em Parametro Ranking
CREATE OR ALTER PROC SP_InsParametrosRanking (
		@NomePosicao VARCHAR (45),
		@Valor REAL 
		)

		AS
		/*
		Documentação
		Arquivo fonte.....: SQLQuery.CriaçãoProceduresCnaeCnaeEmpresa.sql
		Objetivo..........: INSERIR NA TABELA PARAMETRO RANKING.
		Autor.............: SMN - ALCYMÁRIO GABRIEL
		Data..............: 04/01/2024   
		Ex................:	DECLARE @RETURN TINYINT 
							EXEC @RETURN = [dbo].[SP_InsParametrosRanking]'Decimo Lugar', -500
							SELECT @RETURN AS RESULTADO
							O - Processamento OK.
							1 - Erro.
		*/  
		BEGIN		
			-- Inserção de registros na tabela ParametroRanking.
			INSERT INTO ParametroRanking (NomePosicao, Valor) 
				VALUES (@NomePosicao, @Valor)
			RETURN 0 
			IF @@ERROR <>0 RETURN 1
		END


-- Criação de procedure de update em Parametro Ranking
CREATE OR ALTER PROC SP_UpdtParametrosRanking(
		@Id SMALLINT, 
		@NomePosicao VARCHAR (45),
		@Valor REAL
		) 	

		AS
		/*
		Documentação
		Arquivo fonte.....: SQLQuery.CriaçãoProceduresCnaeCnaeEmpresa.sql
		Objetivo..........: ATUALIZAR A TABELA PARAMETROS RANKING.
		Autor.............: SMN - ALCYMÁRIO GABRIEL
		Data..............: 04/01/2023
		Ex................: DECLARE @RETURN TINYINT 
							EXEC @RETURN = [dbo].[SP_UpdtParametrosRanking] 
							SELECT @RETURN AS RESULTADO
		Retornos..........: 0 - Processamento OK.
							1 - ID Emprestimo inexistente.
							2 - Erro.
		*/ 
		BEGIN
			-- Validando se o ID ParametroRanking existe.
			IF NOT EXISTS (SELECT TOP 1 Id 
								FROM ParametroRanking
									WHERE Id = @Id) RETURN 1	
		
			-- Atualizando a tabela ParametroRanking.
			UPDATE ParametroRanking 
				SET NomePosicao = @NomePosicao,
					Valor = @Valor
				WHERE Id = @Id
			RETURN 0
			IF @@ERROR <>0 RETURN 2
		END
	
-- Criação de procedure de update em Parametro Ranking
CREATE OR ALTER PROC SP_DelParametroRanking (
		@Id SMALLINT
		)
		AS
		/*
		Documentação
		Arquivo fonte.....: SQLQuery.CriaçãoProceduresCnaeCnaeEmpresa.sql
		Objetivo..........: DELETAR A TABELA PARAMETROS RANKING.
		Autor.............: SMN - ALCYMÁRIO GABRIEL
		Data..............: 04/01/2023
		Ex................: DECLARE @RETURN TINYINT 
							EXEC @RETURN = [dbo].[SP_DelParametroRanking] 11
							SELECT @RETURN AS RESULTADO
		Retornos..........: 0 - Processamento OK.
							1 - ID inexistente.
							2 - Erro.
		*/ 

		BEGIN
        -- Validando se o ID ParametroRanking existe.
        IF NOT EXISTS (SELECT TOP 1 Id 
                            FROM ParametroRanking
                                WHERE Id = @Id) RETURN 1

        -- Deletando registro na tabela ParametroRanking.
        DELETE FROM ParametroRanking
            WHERE Id = @Id
        RETURN 0
        IF @@ERROR <>0 RETURN 2
    END


-- Criação de procedure de select em Parametro Ranking
CREATE OR ALTER PROC SP_SelParametroRanking (
		@Id SMALLINT = NULL, 
		@NomePosicao VARCHAR (45) = NULL,
		@Valor REAL = NULL
		) 
		AS
		/*
		Documentação
		Arquivo fonte.....: SQLQuery.CriaçãoProceduresCnaeCnaeEmpresa.sql
		Objetivo..........: SELECIONAR A TABELA PARAMETRO RANKING.
		Autor.............: SMN - ALCYMÁRIO GABRIEL
		Data..............: 04/01/2023
		Ex................: EXEC [dbo].[SP_SelParametroRanking] @NomePosicao = 'Quinto Lugar'
		Retornos..........: 0 - Erro.
		*/
		BEGIN
			-- Selecionando a tabela Parametro Ranking.
			SELECT	Id AS 'Código',
					NomePosicao AS 'Nome',
					Valor 
				FROM ParametroRanking
					WHERE	(@Id IS NULL OR Id = @Id) AND
							(@NomePosicao IS NULL OR NomePosicao = @NomePosicao) AND
							(@Valor IS NULL OR Valor = @Valor)
				IF @@ERROR <> 0 RETURN 0
		END 
	

-- Criação de procedure de insert em Cnae
CREATE OR ALTER PROC SP_InsCnae (
		@CodigoCnae INT,
		@DescricaoCnae VARCHAR (70)
		)
		AS
		/*
		Documentação
		Arquivo fonte.....: SQLQuery.CriaçãoProceduresCnaeCnaeEmpresa.sql
		Objetivo..........: INSERIR NA TABELA CNAE.
		Autor.............: SMN - ALCYMÁRIO GABRIEL
		Data..............: 04/01/2024
		Ex................:	DECLARE @RETURN TINYINT 
							EXEC @RETURN = [dbo].[SP_InsCnae]  63127, 'Portais, provedores de conteúdo e outros serviços de informação na internet'
							SELECT @RETURN AS RESULTADO
							O - Processamento OK.
							1 - Erro.
		*/  
		BEGIN		
			-- Inserção de registros na tabela Cnae.
			INSERT INTO Cnae (CodigoCnae, DescricaoCnae) 
				VALUES (@CodigoCnae, @DescricaoCnae)
			RETURN 0 
			IF @@ERROR <>0 RETURN 1
		END

-- Criação de procedure de update em Cnae.
CREATE OR ALTER PROC SP_UpdtCnae(
		@Id SMALLINT, 
		@CodigoCnae INT,
		@DescricaoCnae VARCHAR (70)
		)	

		AS
		/*
		Documentação
		Arquivo fonte.....: SQLQuery.CriaçãoProceduresCnaeCnaeEmpresa.sql
		Objetivo..........: ATUALIZAR A TABELA CNAE.
		Autor.............: SMN - ALCYMÁRIO GABRIEL
		Data..............: 04/01/2023
		Ex................: DECLARE @RETURN TINYINT 
							EXEC @RETURN = [dbo].[SP_UpdtCnae] @Id = 2, @CodigoCnae = 456, @DescricaoCnae =  'Sem descrição.'
							SELECT @RETURN AS RESULTADO
		Retornos..........: 0 - Processamento OK.
							1 - ID Emprestimo inexistente.
							2 - Erro.
		*/ 
		BEGIN
			-- Validando se o ID Cnae existe.
			IF NOT EXISTS (SELECT TOP 1 Id 
								FROM Cnae
									WHERE Id = @Id) RETURN 1	
		
			-- Atualizando a tabela Cnae.
			UPDATE Cnae 
				SET CodigoCnae = @CodigoCnae,
					DescricaoCnae = @DescricaoCnae
				WHERE Id = @Id
			RETURN 0
			IF @@ERROR <>0 RETURN 2
		END

-- Criação de procedure de select em Cnae.
CREATE OR ALTER PROC SP_SelCnae (
		@Id SMALLINT = NULL, 
		@CodigoCnae INT = NULL,
		@DescricaoCnae VARCHAR (70) = NULL
		) 
		AS
		/*
		Documentação
		Arquivo fonte.....: SQLQuery.CriaçãoProceduresCnaeCnaeEmpresa.sql
		Objetivo..........: SELECIONAR A TABELA CNAE.
		Autor.............: SMN - ALCYMÁRIO GABRIEL
		Data..............: 04/01/2023
		Ex................: EXEC [dbo].[SP_SelCnae] @Id = 2
		Retornos..........: 0 - Erro.
		*/
		BEGIN
			-- Selecionando a tabela Cnae.
			SELECT	Id,
					CodigoCnae AS 'Número Cnae',
					DescricaoCnae AS 'Descrição' 
				FROM Cnae
					WHERE	(@Id IS NULL OR Id = @Id) AND
							(@CodigoCnae IS NULL OR CodigoCnae = @CodigoCnae) AND
							(@DescricaoCnae IS NULL OR DescricaoCnae = @DescricaoCnae)
				IF @@ERROR <> 0 RETURN 0
		END 

-- Criação de procedure de insert em Cnae Empresa
CREATE OR ALTER PROC SP_InsCnaeEmpresa (
		@IdEmpresa SMALLINT,
		@IdCnae SMALLINT,
		@Principal BIT
		)
		AS
		/*
		Documentação
		Arquivo fonte.....: SQLQuery.CriaçãoProceduresCnaeCnaeEmpresa.sql
		Objetivo..........: INSERIR NA TABELA CNAE EMPRESA.
		Autor.............: SMN - ALCYMÁRIO GABRIEL
		Data..............: 04/01/2024
		Ex................:	DECLARE @RETURN TINYINT 
							EXEC @RETURN = [dbo].[SP_InsCnaeEmpresa] 16, 15, 0
							SELECT @RETURN AS RESULTADO
							O - Processamento OK.
							1 - Id Empresa inexistente.
							2 - Id Cnae inexistente.
							3 - Erro.
		*/			
		BEGIN		
					
			 -- Validando se o ID Empresa existe.
	         IF NOT EXISTS (SELECT TOP 1 Id 
								FROM Empresa
								 WHERE Id = @IdEmpresa) RETURN 1
			 -- Validando se o ID Cnae existe.
	         IF NOT EXISTS (SELECT TOP 1 Id 
								FROM Cnae
								 WHERE Id = @IdCnae) RETURN 2
			-- Inserção de registros na tabela Cnae Empresa.
			INSERT INTO CnaeEmpresa (IdEmpresa,IdCnae,Principal) 
				VALUES (@IdEmpresa,@IdCnae,@Principal)
			RETURN 0 
			IF @@ERROR <>0 RETURN 3
		END
		

-- Criação de procedure de update em Cnae Empresa.
CREATE OR ALTER PROC SP_UpdtCnaeEmpresa(
		@IdEmpresa SMALLINT,
		@IdCnae SMALLINT,
		@Principal BIT
		)	
		AS
		/*
		Documentação
		Arquivo fonte.....: SQLQuery.CriaçãoProceduresCnaeCnaeEmpresa.sql
		Objetivo..........: ATUALIZAR A TABELA CNAE EMPRESA.
		Autor.............: SMN - ALCYMÁRIO GABRIEL
		Data..............: 04/01/2023
		Ex................: DECLARE @RETURN TINYINT 
							EXEC @RETURN = [dbo].[SP_UpdtCnaeEmpresa] 4, 1, 1
							SELECT @RETURN AS RESULTADO
		Retornos..........: 0 - Processamento OK.
							1 - ID Empresa inexistente.
							2 - ID Cnae inexistente.
							3 - Erro.
		*/ 
		BEGIN
			-- Validando se o ID  Empresa existe.
			IF NOT EXISTS (SELECT TOP 1 IdEmpresa 
								FROM CnaeEmpresa
									WHERE IdEmpresa = @IdEmpresa) RETURN 1	
			-- Validando se o ID Cnae existe.
			IF NOT EXISTS (SELECT TOP 1 IdCnae
								FROM CnaeEmpresa
									WHERE IdCnae = @IdCnae) RETURN 2	
		
			-- Atualizando a tabela CnaeEmpresa.
			UPDATE CnaeEmpresa 
				SET Principal = @Principal
				WHERE	IdEmpresa = @IdEmpresa AND IdCnae = @IdCnae
						
			RETURN 0
			IF @@ERROR <>0 RETURN 3
		END


-- Criação de procedure de update em Cnae Empresa.
CREATE OR ALTER PROC SP_DelCnaeEmpresa (
		@IdEmpresa SMALLINT,
		@IdCnae SMALLINT
		)	
		AS
		/*
		Documentação
		Arquivo fonte.....: SQLQuery.CriaçãoProceduresCnaeCnaeEmpresa.sql
		Objetivo..........: DELETAR A TABELA CNAE.
		Autor.............: SMN - ALCYMÁRIO GABRIEL
		Data..............: 04/01/2023
		Ex................: DECLARE @RETURN TINYINT 
							EXEC @RETURN = [dbo].[SP_DelCnaeEmpresa] 4,1
							SELECT @RETURN AS RESULTADO
		Retornos..........: 0 - Processamento OK.
							1 - ID Empresa inexistente.
							2 - ID Cnae inexistente.
							3 - Erro.
		*/ 

		BEGIN
        -- Validando se o ID  Empresa existe.
			IF NOT EXISTS (SELECT TOP 1 IdEmpresa 
								FROM CnaeEmpresa
									WHERE IdEmpresa = @IdEmpresa) RETURN 1	
			-- Validando se o ID Cnae existe.
			IF NOT EXISTS (SELECT TOP 1 IdCnae
								FROM CnaeEmpresa
									WHERE IdCnae = @IdCnae) RETURN 2
        -- Deletando registro na tabela CnaeEmpresa.
        DELETE FROM CnaeEmpresa
            WHERE IdEmpresa = @IdEmpresa AND IdCnae = @IdCnae
        RETURN 0
        IF @@ERROR <>0 RETURN 3
    END


-- Criação de procedure de select em Cnae Empresa.
CREATE OR ALTER PROC SP_SelCnaeEmpresa (
		@IdEmpresa SMALLINT = NULL,
		@IdCnae SMALLINT = NULL,
		@Principal BIT = NULL
		) 
		AS
		/*
		Documentação
		Arquivo fonte.....: SQLQuery.CriaçãoProceduresCnaeCnaeEmpresa.sql
		Objetivo..........: SELECIONAR A TABELA CNAE.
		Autor.............: SMN - ALCYMÁRIO GABRIEL
		Data..............: 04/01/2023
		Ex................: EXEC [dbo].[SP_SelCnaeEmpresa] @IdEmpresa = 1, @IdCnae = 1
		Retornos..........: 0 - Erro.
		*/
		BEGIN
			-- Selecionando a tabela Cnae Empresa.
			SELECT	IdEmpresa,
					IdCnae,
					Principal
				FROM CnaeEmpresa
					WHERE	(@IdEmpresa IS NULL OR IdEmpresa = @IdEmpresa) AND
							(@IdCnae IS NULL OR IdCnae = @IdCnae) AND
							(@Principal IS NULL OR Principal = @Principal)
				IF @@ERROR <> 0 RETURN 0
		END 