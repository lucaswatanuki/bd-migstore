ALTER PROCEDURE cadastrar_vendedor
@codloja int,
@nome VARCHAR(50),
@endereco VARCHAR(100),
@numero int,
@cidade VARCHAR(50),
@UF CHAR(2),
@telefone VARCHAR(14),
@tipo_pessoa int,
@RF INT,
@salario money,
@tipo_func INT
AS 
BEGIN TRANSACTION
INSERT into pessoa VALUES(@codloja, @nome, @endereco, @numero, @cidade, @UF, @telefone, @tipo_pessoa)
DECLARE @cod_pessoa INT = (select IDENT_CURRENT('pessoa') AS [IDENT_CURRENT('pessoa')])
IF @@ROWCOUNT>0 AND @tipo_pessoa = 0
    BEGIN
        INSERT into funcionario VALUES(@RF, @cod_pessoa, @codloja, @salario, @tipo_func)
        IF @@ROWCOUNT>0 AND @tipo_func = 1
            BEGIN
            INSERT into vendedor VALUES(@RF, 0)
                IF @@ROWCOUNT>0
                    BEGIN
                        COMMIT TRANSACTION
                        RETURN 1
                    END
                ELSE ROLLBACK TRANSACTION RETURN 0
            END
        ELSE ROLLBACK TRANSACTION
    END

EXEC cadastrar_vendedor 1, 'Filipe', 'Rua Apple Inc', 123, 'São Paulo', 'SP', '(11)61244-6666', '0', 190754, 15000, 1
