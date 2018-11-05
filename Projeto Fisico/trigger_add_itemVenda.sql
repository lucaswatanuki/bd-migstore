Create TRIGGER adicionar_itemvenda
on item_venda
after INSERT
as
BEGIN TRANSACTION
UPDATE venda SET total = total + ((select quantidade from inserted) * (select preco from produtos 
                                                                        where codigo = (select cod_produto from inserted)))
IF @@ROWCOUNT>0
    BEGIN
        UPDATE produtos SET qtd_estoque = qtd_estoque - (select quantidade from inserted)
        WHERE codigo = (select cod_produto from inserted)
        DECLARE @estoque INT = (select qtd_estoque from produtos where codigo = (select cod_produto from inserted))
        IF @@ROWCOUNT>0 AND @estoque >= 0
            BEGIN
                PRINT 'Produto(s) adicionado(s) com sucesso!'
                COMMIT TRANSACTION
            END
        ELSE
            BEGIN
                PRINT 'Produto indisponível!'
                ROLLBACK TRANSACTION
            END
    END
ELSE ROLLBACK TRANSACTION



                

                                                                        
