Create PROCEDURE cadastrar_cliente_PJ
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
@cnpj VARCHAR(14),
@nome_fantasia VARCHAR(13)
AS
BEGIN TRANSACTION
    INSERT into pessoa VALUES(@codloja, @nome, @endereco, @numero, @cidade, @estado, @telefone, @tipo_pessoa)
    DECLARE @cod_pessoa INT = (select IDENT_CURRENT('pessoa') AS [IDENT_CURRENT('pessoa')])
    IF @@ROWCOUNT>0 AND @tipo_pessoa = 0
        BEGIN
            INSERT into cliente VALUES(@cod_pessoa, @dt_nasc, @tipo_cliente)
            DECLARE @cod_cliente INT = (select IDENT_CURRENT('cliente') AS [IDENT_CURRENT('cliente')])
            IF @@ROWCOUNT > 0 AND @tipo_cliente = 0
                BEGIN
                   INSERT into pessoa_juridica VALUES(@cod_cliente, @cnpj, @nome_fantasia)
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
EXEC @teste = cadastrar_cliente_PJ 1, 'Lucas Watanuki', 'Rua Anita Garibaldi', 59, 'Limeira', 'SP', '13996634819', 0, '14/10/1996', 0, '30.037.847/0001-01','LukeSports'
PRINT @teste

select* from pessoa_juridica
