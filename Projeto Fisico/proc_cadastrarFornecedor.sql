create PROCEDURE cadastrar_fornecedor
@cnpj VARCHAR(18),
@nome_fantasia VARCHAR(50),
@endereco VARCHAR(100),
@numero int,
@cidade VARCHAR(20),
@estado CHAR(2)
AS
INSERT into fornecedor VALUES(@cnpj, @nome_fantasia, @endereco, @numero, @cidade, @estado)
IF @@ROWCOUNT>0
    BEGIN
        PRINT 'Fornecedor cadastrado com sucesso'
        RETURN 1
    END
ELSE
    BEGIN
        PRINT 'Erro'
        RETURN 0
    END

DECLARE @teste INT
EXEC @teste = cadastrar_fornecedor '93.362.460/0001-40', 'Centaurius Distribuidora', 'Rua Brasil', 2002, 'São Paulo', 'SP' 
print @teste

select* from fornecedor