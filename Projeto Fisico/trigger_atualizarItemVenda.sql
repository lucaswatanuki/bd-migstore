alter TRIGGER atualizar_itemVenda
ON item_venda
AFTER UPDATE
AS
IF UPDATE(quantidade)
   BEGIN TRANSACTION
      DECLARE @qtd_final int = (select quantidade from inserted) 
      DECLARE @qtd_inicial int = (select quantidade from deleted)
      IF @qtd_final > @qtd_inicial
           BEGIN
               UPDATE produtos SET qtd_estoque = qtd_estoque - (@qtd_final - @qtd_inicial)
               WHERE produtos.codigo = (select cod_produto from inserted) --se há mais pedidos em relação ao início, tira do estoque
           END
      ELSE
           BEGIN
               UPDATE produtos SET qtd_estoque = qtd_estoque + (@qtd_inicial - @qtd_final)
               WHERE produtos.codigo = (select cod_produto from inserted) --se há menos pedidos em relação ao início, arescenta ao estoque
           END
       IF @@ROWCOUNT > 0
           BEGIN
           UPDATE venda SET total = (select sum(item_venda.quantidade*produtos.preco)
           from item_venda inner join produtos on produtos.codigo = item_venda.cod_produto)
           COMMIT TRANSACTION
           END
       ELSE
           BEGIN
               ROLLBACK TRANSACTION
           END