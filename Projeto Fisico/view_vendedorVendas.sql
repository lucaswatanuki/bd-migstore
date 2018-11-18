ALTER view vendedor_vendas
as
SELECT pessoa.nome, pessoa.cod_loja, sum(relatorio_venda.qtd_total)"Produtos vendidos",
sum(relatorio_venda.Total) "Total(R$)"
from funcionario
INNER JOIN vendedor on funcionario.RF = vendedor.RF
INNER JOIN pessoa ON pessoa.codigo = funcionario.cod_pessoa AND funcionario.cod_loja = pessoa.cod_loja
INNER JOIN relatorio_venda ON relatorio_venda.RF = funcionario.RF
GROUP BY pessoa.nome, pessoa.cod_loja