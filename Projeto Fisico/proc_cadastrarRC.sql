CREATE PROCEDURE cadastrar_RC
@cod_fornecedor INT,
@RF_gerente INT,
@cod_produto INT,
@quantidade INT,
@data date
AS 
BEGIN TRANSACTION
INSERT INTO requisicao_compra VALUES(@cod_fornecedor, @cod_produto, @RF_gerente, @data, 0)
DECLARE @cod_RC INT = (select IDENT_CURRENT('requisicao_compra') AS [IDENT_CURRENT('requisicao_compra')])
IF @@ROWCOUNT>0
    BEGIN
        INSERT into item_requisicao VALUES(@cod_RC, @cod_produto, @quantidade)
        IF @@ROWCOUNT>0
            BEGIN
                COMMIT TRANSACTION
                RETURN 1
            END
        ELSE ROLLBACK TRANSACTION RETURN 0
    END
ELSE ROLLBACK TRANSACTION RETURN 0

exec cadastrar_RC 1, 66123, 2, 2, '10/11/2018'