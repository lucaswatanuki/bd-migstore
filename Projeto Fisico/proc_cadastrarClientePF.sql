Create PROCEDURE cadastrar_cliente_PF
@codloja int,
@nome VARCHAR(50),
@endereco VARCHAR(100),
@numero int,
@cidade VARCHAR(50),
@estado CHAR(2),
@telefone VARCHAR(14),
@tipo_pessoa int,
@dt_nasc date,
@tipo_cliente INT,
@cpf VARCHAR(14),
@rg VARCHAR(13)
AS
BEGIN TRANSACTION
    INSERT into pessoa VALUES(@codloja, @nome, @endereco, @numero, @cidade, @estado, @telefone, @tipo_pessoa)
    DECLARE @cod_pessoa INT = (select IDENT_CURRENT('pessoa') AS [IDENT_CURRENT('pessoa')])
    IF @@ROWCOUNT>0 AND @tipo_pessoa = 1
        BEGIN
            INSERT into cliente VALUES(@cod_pessoa, @dt_nasc, @tipo_cliente)
            DECLARE @cod_cliente INT = (select IDENT_CURRENT('cliente') AS [IDENT_CURRENT('cliente')])
            IF @@ROWCOUNT > 0 AND @tipo_cliente = 1
                BEGIN
                   INSERT into pessoa_fisica VALUES(@cod_cliente, @cpf, @rg)
                   if @@ROWCOUNT>0
                        BEGIN
                            COMMIT TRANSACTION
                            RETURN 1
                        END
                    ELSE
                        BEGIN
                            ROLLBACK TRANSACTION
                            RETURN 0
                        END
                END
            ELSE
                ROLLBACK TRANSACTION
        END
    ELSE
        ROLLBACK TRANSACTION

DECLARE @teste INT
EXEC @teste = cadastrar_cliente_PF 1, 'Henrique Doente', 'Rua Morar Mais', 666, 'Limeira', 'SP', '169123451234', 0, '25/03/2000', 1, '123.456.789-10','44.123.000-X'