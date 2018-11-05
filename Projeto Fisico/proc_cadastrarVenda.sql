Create PROCEDURE cadastrar_venda
@cod_cliente int,
@rf_vendedor int,
@data DATE,
@cod_produto INT,
@quantidade INT
AS
BEGIN TRANSACTION
INSERT into venda VALUES(@cod_cliente, @rf_vendedor, @data, 0)
DECLARE @cod_venda INT = (select IDENT_CURRENT('venda') AS [IDENT_CURRENT('venda')])
IF @@ROWCOUNT>0 
    BEGIN
        INSERT into item_venda VALUES(@cod_produto,@cod_venda, @quantidade)
        IF @@ROWCOUNT>0
            BEGIN
                COMMIT TRANSACTION
                RETURN 1
            END
        ELSE ROLLBACK TRANSACTION RETURN 0
    END
ELSE ROLLBACK TRANSACTION RETURN 0


DECLARE @venda INT
EXEC @venda = cadastrar_venda 1, 205541, '05/11/2018', 2, 1
print @venda