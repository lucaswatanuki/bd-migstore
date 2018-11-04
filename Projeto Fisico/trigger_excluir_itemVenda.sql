Create TRIGGER excluir_itemvenda
on item_venda
after delete
as
BEGIN TRANSACTION
UPDATE venda SET total = total - ((select quantidade from deleted) * (select preco from produtos 
                                                                        where codigo = (select cod_produto from deleted)))
WHERE venda.codigo = (select cod_venda from deleted)
IF @@ROWCOUNT>0
    BEGIN
        UPDATE produtos SET qtd_estoque = qtd_estoque + (select quantidade from deleted)
        WHERE produtos.codigo = (select cod_produto from deleted)
        IF @@ROWCOUNT>0
            BEGIN
                PRINT 'Produto(s) removido(s) da venda com sucesso!'
                COMMIT TRANSACTION
            END
        ELSE
            BEGIN
                PRINT 'Não foi possível excluir o produto da venda!'
                ROLLBACK TRANSACTION
            END
    END
ELSE ROLLBACK TRANSACTION