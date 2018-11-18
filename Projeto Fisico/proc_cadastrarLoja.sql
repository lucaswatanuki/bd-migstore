CREATE PROCEDURE cadastrar_loja
@cnpj VARCHAR(18),
@endereco VARCHAR(100),
@numero int,
@cidade VARCHAR(20),
@uf char(2),
@nome VARCHAR(50)
AS
INSERT into loja VALUES(@cnpj, @endereco, @numero, @cidade, @uf, @nome)
    IF @@ROWCOUNT>0
        BEGIN
            PRINT 'Loja cadastrada com sucesso!'
            RETURN 1
        END
    ELSE
        BEGIN
            PRINT 'Erro ao cadastrar loja'
            RETURN 0
        END

EXEC cadastrar_loja '05.045.386/0001-71', 'Rua Unicamp FT', 100, 'Limeira', 'SP', 'MigSports'