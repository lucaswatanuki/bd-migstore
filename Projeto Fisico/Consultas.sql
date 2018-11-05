/*CONSULTAS A BASE DE DADOS*/


SELECT* FROM pessoa
SELECT* FROM cliente
SELECT* FROM funcionario
SELECT* FROM produtos
SELECT* FROM roupa
SELECT* FROM calcado
SELECT* FROM venda
SELECT* FROM item_venda

update item_venda SET quantidade = 1 where cod_produto = 2

insert into item_venda values (2,2,1)

