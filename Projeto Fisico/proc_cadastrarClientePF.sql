ALTER PROCEDURE cadastrar_cliente_PF
@codloja int,
@nome VARCHAR(50),
@endereco VARCHAR(100),
@numero int,
@cidade VARCHAR(50),
@UF CHAR(2),
@telefone VARCHAR(14),
@tipo_pessoa int,
@dt_nasc date,
@tipo_cliente INT,
@cpf VARCHAR(14),
@rg VARCHAR(13)
AS
BEGIN TRANSACTION
    INSERT into pessoa VALUES(@codloja, @nome, @endereco, @numero, @cidade, @UF, @telefone, @tipo_pessoa)
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
                            PRINT 'Cliente cadastrado com sucesso!'
                            RETURN 1
                        END
                    ELSE
                        BEGIN
                            PRINT 'Erro ao cadastrar cliente!'
                            ROLLBACK TRANSACTION
                            RETURN 0
                        END
                END
            ELSE
                PRINT 'Erro ao cadastrar cliente!'
                ROLLBACK TRANSACTION
        END
    ELSE
        PRINT 'Erro ao cadastrar cliente!'
        ROLLBACK TRANSACTION


EXEC cadastrar_cliente_PF 1, 'Lucas Watanuki', 'Rua Anita Garibaldi', 59, 'Limeira', 'SP', '(13)99663-4819', 1, '14/10/1996', 1, '469.015.148-24','52.691.851-2'