/*CONSULTAS A BASE DE DADOS*/


SELECT* FROM pessoa
SELECT* FROM cliente
SELECT* FROM funcionario
SELECT* FROM fornecedor
SELECT* FROM produtos
SELECT* FROM roupa
SELECT* FROM calcado
SELECT* FROM venda
SELECT* FROM item_venda
SELECT* from requisicao_compra
SELECT* FROM item_requisicao
SELECT* FROM produtos

UPDATE item_requisicao SET quantidade = 0 WHERE cod_produto = 2 and cod_req = 1
