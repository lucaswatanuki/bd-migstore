CREATE PROCEDURE cadastrar_roupa
@cod_produto INT,
@nome VARCHAR(50),
@marca VARCHAR(15),
@departamento VARCHAR(15),
@preco money,
@cor VARCHAR(15),
@qtd_estoque INT,
@tipo SMALLINT,
@tipo_peca VARCHAR(15),
@tamanho CHAR(3),
@time VARCHAR(15)
as
BEGIN TRANSACTION
INSERT into produtos VALUES(@cod_produto, @nome, @marca, @departamento, @preco, @cor, @qtd_estoque, @tipo)
IF @@ROWCOUNT>0 AND @tipo = 0
    BEGIN
        INSERT into roupa VALUES(@cod_produto, @tipo_peca, @tamanho, @time)
        IF @@ROWCOUNT>0 
            BEGIN COMMIT TRANSACTION RETURN 1 END
        ELSE ROLLBACK TRANSACTION RETURN 0
    END
ELSE ROLLBACK TRANSACTION RETURN 0 

EXEC cadastrar_roupa 1, 'Camisa SPFC I 2018', 'Adidas', 'Futebol', 249, 'Branco', 150, 0, 'Camisa', 'P', 'São Paulo FC'