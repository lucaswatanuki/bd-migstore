ALTER PROCEDURE cadastrar_gerente
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
@tipo_func INT,
@departamento VARCHAR(25)
AS 
BEGIN TRANSACTION
INSERT into pessoa VALUES(@codloja, @nome, @endereco, @numero, @cidade, @UF, @telefone, @tipo_pessoa)
DECLARE @cod_pessoa INT = (select IDENT_CURRENT('pessoa') AS [IDENT_CURRENT('pessoa')])
IF @@ROWCOUNT>0 AND @tipo_pessoa = 0
    BEGIN
        INSERT into funcionario VALUES(@RF, @cod_pessoa, @codloja, @salario, @tipo_func)
        IF @@ROWCOUNT>0 AND @tipo_func = 0
            BEGIN
            INSERT into gerente VALUES(@RF, @departamento)
                IF @@ROWCOUNT>0
                    BEGIN
                        COMMIT TRANSACTION
                        RETURN 1
                    END
                ELSE ROLLBACK TRANSACTION RETURN 0
            END
        ELSE ROLLBACK TRANSACTION
    END

EXEC cadastrar_gerente 1, 'Paulo', 'Heslington, York YO10 5DD, Reino Unido', 13, 'York', 'YO', '(19)99665-1902', 0, 66123, 20000, 0, 'Logistica'