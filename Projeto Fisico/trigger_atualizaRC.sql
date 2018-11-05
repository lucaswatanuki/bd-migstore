ALTER TRIGGER atualizar_RC
ON item_requisicao
AFTER UPDATE
AS
IF UPDATE(quantidade)
   BEGIN TRANSACTION
      DECLARE @qtd_final int = (select quantidade from inserted)
      DECLARE @qtd_inicial int = (select quantidade from deleted)
      IF @qtd_final > @qtd_inicial
           BEGIN
               UPDATE produtos SET qtd_estoque = qtd_estoque + (@qtd_final - @qtd_inicial)
               WHERE produtos.codigo = (select cod_produto from inserted)
           END
      ELSE
           BEGIN
               UPDATE produtos SET qtd_estoque = qtd_estoque - (@qtd_inicial - @qtd_final)
               WHERE produtos.codigo = (select cod_produto from inserted) 
           END
       IF @@ROWCOUNT > 0
           BEGIN
           UPDATE requisicao_compra SET total = (select sum(item_requisicao.quantidade* (0.8*produtos.preco))
           from item_requisicao inner join produtos on produtos.codigo = item_requisicao.cod_produto)
           WHERE requisicao_compra.codigo = (select cod_req from inserted) OR requisicao_compra.codigo = (select cod_req from deleted)
           COMMIT TRANSACTION
           END
       ELSE
           BEGIN
               ROLLBACK TRANSACTION
           END