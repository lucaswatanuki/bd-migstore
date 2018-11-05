Create TRIGGER excluir_itemRequisicao
on item_requisicao
after delete
as
BEGIN TRANSACTION
UPDATE requisicao_compra SET total = total - ((select quantidade from deleted) * (0.8*(select preco from produtos 
                                                                        where codigo = (select cod_produto from deleted))))
WHERE requisicao_compra.codigo = (select cod_req from deleted)
IF @@ROWCOUNT>0 
    BEGIN
        UPDATE produtos SET qtd_estoque = qtd_estoque - (select quantidade from deleted)
        WHERE produtos.codigo = (select cod_produto from deleted)
        IF @@ROWCOUNT>0
            BEGIN
                PRINT 'Produto(s) removido(s) da RC com sucesso!'
                COMMIT TRANSACTION
            END
        ELSE
            BEGIN
                PRINT 'Não foi possível excluir o produto da RC!'
                ROLLBACK TRANSACTION
            END
    END
ELSE ROLLBACK TRANSACTION