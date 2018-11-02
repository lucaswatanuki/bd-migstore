/*Base de Dados - Tabelas*/

CREATE TABLE loja
(
    codigo int not NULL,
    cnpj VARCHAR(18) not NULL,
    endereco VARCHAR(100),
    numero int not NULL,
    cidade VARCHAR(20) NOT NULL,
    estado CHAR(2) NOT NULL,
    nome VARCHAR(50),
    PRIMARY KEY(codigo),
    UNIQUE(cnpj)
)

create TABLE pessoa
(
    codigo int NOT NULL,
    cod_loja int NOT NULL,
    nome VARCHAR(50) NOT NULL,
    endereco VARCHAR(100),
    numero int not NULL,
    cidade VARCHAR(20) NOT NULL,
    estado CHAR(2) NOT NULL,
    telefone VARCHAR(14) NOT NULL,
    PRIMARY KEY(codigo),
    FOREIGN KEY(cod_loja) REFERENCES loja
)

CREATE TABLE funcionario
(
    RF int NOT NULL,
    cod_pessoa INT NOT NULL,
    cod_loja INT NOT NULL,
    salario money not NULL,
    tipo_func SMALLINT NOT NULL,
    PRIMARY KEY(RF),
    UNIQUE(cod_pessoa),
    FOREIGN KEY(cod_pessoa) REFERENCES pessoa,
    FOREIGN KEY(cod_loja) REFERENCES loja
)

CREATE TABLE gerente
(
    RF int not NULL,
    departamento VARCHAR(25) not NULL,
    PRIMARY KEY(RF),
    FOREIGN KEY(RF) REFERENCES funcionario
)

CREATE TABLE vendedor
(
    RF int not NULL,
    comissao money,
    PRIMARY KEY(RF),
    FOREIGN KEY(RF) REFERENCES funcionario
)

CREATE TABLE cliente
(
    codigo INT NOT NULL,
    cod_pessoa INT NOT NULL,
    dt_nasc DATE not NULL,
    tipo_cliente SMALLINT NOT NULL,
    PRIMARY KEY(codigo),
    FOREIGN KEY(cod_pessoa) REFERENCES pessoa
)

CREATE TABLE pessoa_juridica
(
    cod_cliente int not NULL,
    cnpj VARCHAR(18) not NULL,
    nome_fantasia VARCHAR(50) NOT NULL,
    PRIMARY KEY(cod_cliente),
    FOREIGN KEY(cod_cliente) REFERENCES cliente,
    UNIQUE(cnpj)
)

CREATE TABLE pessoa_fisica
(
    cod_cliente int not NULL,
    cpf VARCHAR(14) NOT NULL,
    rg VARCHAR(13),
    PRIMARY KEY(cod_cliente),
    FOREIGN KEY(cod_cliente) REFERENCES cliente,
    UNIQUE(cpf)
)

CREATE TABLE fornecedor
(
    codigo int not NULL,
    cnpj VARCHAR(18) not NULL,
    nome_fantasia VARCHAR(50) not NULL,
    endereco VARCHAR(100),
    numero int not NULL,
    cidade VARCHAR(20) NOT NULL,
    estado CHAR(2) NOT NULL,
    PRIMARY KEY(codigo),
    UNIQUE(cnpj)
)

CREATE TABLE produtos
(
    codigo int not NULL,
    nome VARCHAR(50) not NULL,
    marca VARCHAR(15),
    departamento VARCHAR(15) not NULL,
    preco money not NULL,
    cor VARCHAR(15),
    qtd_estoque INT NOT NULL,
    tipo SMALLINT NOT NULL,
    PRIMARY KEY(codigo),
)

CREATE TABLE roupa
(
    cod_produto INT NOT NULL,
    tipo_peca VARCHAR(15) NOT NULL,
    tamanho char(3) NOT NULL,
    _time VARCHAR(15),
    FOREIGN KEY(cod_produto) REFERENCES produtos
)

CREATE TABLE calcado
(
    cod_produto INT NOT NULL,
    numero INT NOT NULL,
    FOREIGN KEY(cod_produto) REFERENCES produtos
)

CREATE TABLE requisicao_compra
(
    codigo int not NULL,
    cod_fornecedor INT NOT NULL,
    cod_produto INT NOT NULL,
    RF INT not NULL,
    _data DATE not NULL,
    _status VARCHAR(10),
    total money NOT NULL,
    PRIMARY KEY(codigo),
    FOREIGN KEY(cod_fornecedor) REFERENCES fornecedor,
    FOREIGN KEY(cod_produto) REFERENCES produtos,
    FOREIGN KEY(RF) REFERENCES gerente,
)

CREATE TABLE venda
(
    codigo int not NULL,
    cod_cliente int not NULL,
    RF int not NULL,
    cod_produto int not NULL,
    _data DATE not NULL,
    total money NOT NULL,
    PRIMARY KEY(codigo),
    FOREIGN KEY(cod_cliente) REFERENCES cliente,
    FOREIGN KEY(RF) REFERENCES vendedor
)

CREATE TABLE item_requisicao
(
    cod_req INT NOT NULL,
    cod_produto INT NOT NULL,
    quantidade INT NOT NULL,
    PRIMARY KEY(cod_req),
    FOREIGN KEY(cod_req) REFERENCES requisicao_compra,
    FOREIGN KEY(cod_produto) REFERENCES produtos
)

CREATE TABLE item_venda
(
    cod_produto INT NOT NULL,
    cod_venda INT NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY(cod_produto) REFERENCES produtos,
    FOREIGN KEY(cod_venda) REFERENCES venda
)

/* ÍNDICES PARA CHAVES ESTRANGEIRAS*/

CREATE INDEX indice_loja
on pessoa(cod_loja)

CREATE INDEX indice_funcionario
on funcionario(cod_pessoa, cod_loja)

CREATE INDEX indice_pessoa_cliente
on cliente(cod_pessoa)

CREATE INDEX indice_cod_roupa
ON roupa(cod_produto)

CREATE INDEX indice_cod_calcado
ON calcado(cod_produto)

CREATE INDEX indice_gerente
ON requisicao_compra(RF)

CREATE INDEX indice_produto
ON requisicao_compra(cod_produto)

CREATE INDEX indice_fornecedor
ON requisicao_compra(cod_fornecedor)

CREATE INDEX indice_cliente_venda
ON venda(cod_cliente)

CREATE INDEX indice_vendedor
ON venda(RF)

CREATE INDEX indice_requisicao
ON item_requisicao(cod_produto)

CREATE INDEX indice_itemvenda
ON item_venda(cod_venda)