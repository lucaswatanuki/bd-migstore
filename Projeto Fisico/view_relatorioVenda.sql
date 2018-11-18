ALTER view relatorio_venda
AS
SELECT venda.codigo, venda._data "Data" , venda.RF, sum(item_venda.quantidade)"qtd_total", venda.total "Total"
from venda 
INNER JOIN item_venda ON item_venda.cod_venda = venda.codigo
GROUP BY venda.codigo, venda._data, venda.RF, venda.total