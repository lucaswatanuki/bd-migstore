ALTER TRIGGER add_item_requisicao
ON item_requisicao
FOR insert
AS
BEGIN TRANSACTION
UPDATE requisicao_compra SET total = total + ((select quantidade from inserted) * (0.8 *(select preco from produtos 
                                                                        where codigo = (select cod_produto from inserted))))
WHERE requisicao_compra.codigo = (select cod_req from inserted)                                                                        
IF @@ROWCOUNT>0
    BEGIN
        --Inserção dos produtos fornecidos ao estoque
        UPDATE produtos SET qtd_estoque = qtd_estoque + (select quantidade from inserted)
        WHERE codigo = (select cod_produto from inserted)
        IF @@ROWCOUNT>0
            BEGIN
                PRINT 'Produto(s) adicionado(s) com sucesso!'
                COMMIT TRANSACTION
            END
        ELSE
            BEGIN
                ROLLBACK TRANSACTION
            END
    END
ELSE ROLLBACK TRANSACTION
