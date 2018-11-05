ALTER PROCEDURE cadastrar_calcado
@nome VARCHAR(50),
@marca VARCHAR(15),
@departamento VARCHAR(15),
@preco money,
@cor VARCHAR(15),
@qtd_estoque INT,
@tipo SMALLINT,
@numero INT
as
BEGIN TRANSACTION
INSERT into produtos VALUES(@nome, @marca, @departamento, @preco, @cor, @qtd_estoque, @tipo)
DECLARE @cod_produto INT = (select IDENT_CURRENT('produtos') AS [IDENT_CURRENT('produtos')])
IF @@ROWCOUNT>0 AND @tipo = 1
    BEGIN
        INSERT into calcado VALUES(@cod_produto, @numero)
        IF @@ROWCOUNT>0 
            BEGIN PRINT 'Produto cadastrado com sucesso!' COMMIT TRANSACTION RETURN 1 END
        ELSE PRINT 'Erro ao cadastrar produto!' ROLLBACK TRANSACTION RETURN 0
    END
ELSE PRINT 'Erro ao cadastrar produto!' ROLLBACK TRANSACTION RETURN 0 

EXEC cadastrar_calcado 'Tenis Kyrie Irving Flytrap', 'Nike', 'Basquete', 350, 'Preto', 10, 1, 42
